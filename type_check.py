from re import search, findall
from sys import argv
import z3

class LabelDict:
	def __init__(self):
		self.vars = {}
	def __getitem__(self, key):
		assert type(key) == str, f"{key} has type {type(key)}"
		if key in self.vars:
			return self.vars[key]
		if search(r"\.[^@%].*$", key):
			self.vars[key] = z3.Bool(key)
			return self.vars[key]
		raise KeyError(key)
	def __setitem__(self, key, value):
		self.vars[key] = value

vars = LabelDict()
solver = z3.Solver()
label_to_bool = {"public": False, "private": True}
assertions = set()
literal_count = 0 # every literal is unique, so just count them and assign a number to each one

def add_variable(name: str, value: str) -> str: # might modify the name, so we'll return it
	global literal_count
	if name.count(".") > 0 and search(r"^(\d+|null)$", name.split(".")[-1]): # if the value is a literal (number of null), add a unique identifier to the name
		name += f"_{literal_count}"
		literal_count += 1
	vars[name] = z3.Bool(name)
	# solver.add(vars[name] == label_to_bool[value])
	if f"{name} == {value}" not in assertions:
		assertions.add(f"{name} == {value}")
		solver.assert_and_track(vars[name] == label_to_bool[value], f"{name} == {value}")
	return name

def type_check(filename: str):
	current_function = None
	current_block = None
	with open(filename, "r") as file:
		iter = enumerate(file.readlines())
		for (i, line) in iter:
			if match := search(r"(@\S+) = .+ !sec !{!\"(\w+)\"}", line):
				# global variable
				add_variable(match.group(1), match.group(2))
			# elif match := search(r"declare .+ @(free|malloc)\(", line):
			# 	# free and malloc
			# 	pass
			elif match := search(r"declare .+ (@\S+)\(", line):
				# declare
				labels = findall(r"\"(public|private|void|...)\"", line)
				if labels[0] == "void":
					add_variable(f"{match.group(1)}.ret", labels[1])
				else:
					add_variable(f"{match.group(1)}.ret", labels[0])
				add_variable(f"{match.group(1)}.min_pc", labels[1])
				for (j, label) in enumerate(labels[2 : ]):
					add_variable(f"{match.group(1)}.param{j}", label)
				solver.add(vars[f"{match.group(1)}.ret"] == vars[f"{match.group(1)}.min_pc"]) # ret = min pc
				print(f"DECLARE {match.group(1)}")
			elif match := search(r"define .+ @declassify\S+\(", line):
				# define declassify
				# declassify definitions have to be skipped since by definition they violate the rules
				print(f"declassify definition starting on line {i} skipped")
				for (_, line) in iter:
					if match := search(r"^}", line):
						break 
			elif match := search(r"define .+ (@\S+)\(", line):
				# define
				labels = findall(r"\"(public|private|void|...)\"", line)
				params = findall(r"(%[^,)]+)", line)
				current_function = match.group(1)
				if labels[0] == "void":
					add_variable(f"{current_function}.ret", labels[1])
				else:
					add_variable(f"{current_function}.ret", labels[0])
				add_variable(f"{current_function}.min_pc", labels[1])
				for (j, label) in enumerate(labels[2 : ]):
					add_variable(f"{current_function}.{params[j]}", label)
					add_variable(f"{current_function}.param{j}", label) # "param_j" is needed for declared functions with no named arguments, we need to be able to access params purely by index
					solver.add(vars[f"{current_function}.{params[j]}"] == vars[f"{current_function}.param{j}"])
				solver.add(vars[f"{current_function}.ret"] == vars[f"{current_function}.min_pc"]) # ret = min pc
				current_block = "entry" # just in case there isn't one
				print(f"START {current_function}({", ".join(params)})")
			elif match := search(r"^(\S+):.+!sec !{!\"(public|private)\"}", line):
				# block
				current_block = match.group(1)
				add_variable(f"{current_function}.{current_block}", match.group(2))
				print(f"{current_block}:")
			elif match := search(r"^}", line):
				# end of function
				print(f"END {current_function}\n")
			elif match := search(r"(%\S+) = alloca .+ !sec !{!\"(public|private)\"}", line):
				# alloca
				dest = add_variable(f"{current_function}.{match.group(1)}", match.group(2)) # pc ⊑ dest
				solver.add(z3.Implies(vars[f"{current_function}.{current_block}"], vars[dest]))
			elif match := search(r"(%\S+) = load .+ ptr ([%@]\S+), .+ !sec !{!\"(public|private)\", !\"(public|private)\"}", line):
				# load
				dest = add_variable(f"{current_function}.{match.group(1)}", match.group(3))
				src = add_variable(f"{current_function}.{match.group(2)}", match.group(4))
				solver.add(z3.Implies(vars[f"{current_function}.{current_block}"], vars[dest])) # pc ⊑ dest
				solver.add(z3.Implies(vars[src], vars[dest])) # src ⊑ dest
			elif match := search(r"store ptr ([%@]?\S+), ptr ([%@]\S+), .+ !{!\"(public|private)\", !\"(public|private)\"}", line):
				# store ptr
				src = add_variable(f"{current_function}.{match.group(1)}", match.group(3))
				tgt = add_variable(f"{current_function}.{match.group(2)}", match.group(4))
				solver.add(z3.Implies(vars[f"{current_function}.{current_block}"], vars[tgt])) # pc ⊑ tgt
				solver.add(vars[src] == vars[tgt]) # src = tgt when they're both pointers
			elif match := search(r"store .+ ([%@]?\S+), ptr ([%@]\S+), .+ !{!\"(public|private)\", !\"(public|private)\"}", line):
				# store
				src = add_variable(f"{current_function}.{match.group(1)}", match.group(3))
				tgt = add_variable(f"{current_function}.{match.group(2)}", match.group(4))
				solver.add(z3.Implies(vars[f"{current_function}.{current_block}"], vars[tgt])) # pc ⊑ tgt
				solver.add(z3.Implies(vars[src], vars[tgt])) # src ⊑ tgt
			elif match := search(r"(%\S+) = (?:add|sub|mul|sdiv|udiv|srem|urem|fadd|fsub|fmul|fdiv|frem|and|or|xor|shl|lshr|ashr|icmp|fcmp) .+ ([%@]?\S+), ([%@]?\S+), !sec !\{!\"(public|private)\"\}", line):
				# binary operations
				result = add_variable(f"{current_function}.{match.group(1)}", match.group(4))
				op1 = add_variable(f"{current_function}.{match.group(2)}", match.group(4))
				op2 = add_variable(f"{current_function}.{match.group(3)}", match.group(4))
				solver.add(z3.Implies(vars[f"{current_function}.{current_block}"], vars[result])) # pc ⊑ result
				solver.add(vars[op1] == vars[result]) # op1 = result
				solver.add(vars[op2] == vars[result]) # op2 = result
			elif match := search(r"ret void", line):
				# ret void
				pass
			elif match := search(r"ret .+ ([%@]\S+), !sec !{!\"(public|private)\"}", line):
				# ret
				value = add_variable(f"{current_function}.{match.group(1)}", match.group(2))
				solver.add(vars[value] == vars[f"{current_function}.ret"]) # value = function return label
			elif match := search(r"(%\S+) = call .+ @declassify\S*\(", line):
				# declassify
				labels = findall(r"\"(public|private)\"", line)
				args = [x.split(" ")[-1] for x in search(r"\(([^)]+)\)", line).group(1).split(", ")]
				result = add_variable(f"{current_function}.{match.group(1)}", labels[1])
				solver.add(z3.Implies(vars[f"{current_function}.{current_block}"], vars[result])) # pc ⊑ result
			elif match := search(r"(%\S+) = call .+ (@\S+)\(", line):
				# call
				labels = findall(r"\"(public|private)\"", line)
				args = [x.split(" ")[-1] for x in search(r"\(([^)]+)\)", line).group(1).split(", ")]
				solver.add(z3.Implies(vars[f"{current_function}.{current_block}"], vars[f"{match.group(2)}.min_pc"])) # pc ⊑ callee min pc
				for (j, arg) in enumerate(labels[1:]):
					arg_j = add_variable(f"{current_function}.{args[j]}", arg)
					solver.add(z3.Implies(vars[arg_j], vars[f"{match.group(2)}.param{j}"])) # arg_j ⊑ param_j
				vars[f"{current_function}.{match.group(1)}"] = z3.Bool(f"{current_function}.{match.group(1)}")
				solver.add(z3.Implies(vars[f"{match.group(2)}.ret"], vars[f"{current_function}.{match.group(1)}"])) # callee return ⊑ result
			elif match := search(r"call void (@\S+)\(", line):
				# call void
				labels = findall(r"\"(public|private)\"", line)
				args = [x.split(" ")[-1] for x in search(r"\(([^)]+)\)", line).group(1).split(", ")]
				solver.add(z3.Implies(vars[f"{current_function}.{current_block}"], vars[f"{match.group(1)}.min_pc"])) # pc ⊑ callee min pc
				for (j, arg) in enumerate(labels[1:]):
					arg_j = add_variable(f"{current_function}.{args[j]}", arg)
					solver.add(z3.Implies(vars[arg_j], vars[f"{match.group(1)}.param{j}"])) # arg_j ⊑ param_j
			elif not line.isspace():
				print(f"Ignoring {line[ : -1]}")
	if solver.check() == z3.unsat:
		print(f"Unsatisfied: {solver.unsat_core()}")
	else:
		print("All constraints satisfied")
	# print(solver)

if __name__ == "__main__":
	if len(argv) != 2:
		print(f"Usage: {argv[0]} <file>")
	type_check(argv[1])