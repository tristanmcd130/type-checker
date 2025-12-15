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
		if search(r"\.[^@%].*", key):
			return False
		raise KeyError(key)
	def __setitem__(self, key, value):
		self.vars[key] = value

vars = LabelDict()
solver = z3.Solver()
label_to_bool = {"public": False, "private": True}
assertions = set()

def add_variable(name: str, value: str) -> None:
	vars[name] = z3.Bool(name)
	# solver.add(vars[name] == label_to_bool[value])
	if f"{name} == {value}" not in assertions:
		assertions.add(f"{name} == {value}")
		solver.assert_and_track(vars[name] == label_to_bool[value], f"{name} == {value}")

def type_check(filename: str):
	current_function = None
	current_block = None
	with open(filename, "r") as file:
		for (i, line) in enumerate(file.readlines()):
			if match := search(r"(@\S+) = .+ !sec !{!\"(\w+)\"}", line):
				# global variable
				add_variable(match.group(1), match.group(2))
				# add_constaint(match.group(1), lambda x: x == label_to_bool[match.group(2)])
			elif match := search(r"declare .+ @(free|malloc)\(", line):
				# free and malloc
				pass
			elif match := search(r"declare .+ (@\S+)\(", line):
				# declare
				labels = findall(r"\"(public|private|void|...)\"", line)
				if labels[0] == "void":
					add_variable(f"{match.group(1)}.ret", labels[1])
				else:
					add_variable(f"{match.group(1)}.ret", labels[0])
				add_variable(f"{match.group(1)}.min_pc", labels[1])
				for (i, label) in enumerate(labels[2 : ]):
					add_variable(f"{match.group(1)}.param{i}", label)
				print(f"DECLARE {match.group(1)}")
			elif match := search(r"define .+ (@\S+)\(", line):
				# define
				labels = findall(r"\"(public|private|void|...)\"", line)
				params = findall(r"(%[^,)]+)", line)
				current_function = match.group(1)
				if labels[0] == "void":
					add_variable(f"{match.group(1)}.ret", labels[1])
				else:
					add_variable(f"{match.group(1)}.ret", labels[0])
				add_variable(f"{current_function}.min_pc", labels[1])
				for (j, label) in enumerate(labels[2 : ]):
					add_variable(f"{current_function}.{params[j]}", label)
					add_variable(f"{current_function}.param{j}", label)
					solver.add(vars[f"{current_function}.{params[j]}"] == vars[f"{current_function}.param{j}"])
				current_block = "entry" # just in case there isn't one
				print(f"START {current_function}({", ".join(params)})")
			elif match := search(r"^(\S+):.+!sec !{!\"(public|private)\"}", line):
				# block
				current_block = match.group(1)
				print(f"{current_block}:")
			elif match := search(r"^}", line):
				# end of function
				print(f"END {current_function}\n")
			elif match := search(r"(%\S+) = alloca .+ !sec !{!\"(public|private)\"}", line):
				# alloca
				add_variable(f"{current_function}.{match.group(1)}", match.group(2))
				solver.add(z3.Implies(vars[f"{current_function}.min_pc"], vars[f"{current_function}.{match.group(1)}"]))
			elif match := search(r"(%\S+) = load .+ ptr ([%@]\S+), .+ !sec !{!\"(public|private)\", !\"(public|private)\"}", line):
				# load
				add_variable(f"{current_function}.{match.group(1)}", match.group(3))
				add_variable(f"{current_function}.{match.group(2)}", match.group(4))
				solver.add(z3.Implies(vars[f"{current_function}.min_pc"], vars[f"{current_function}.{match.group(1)}"]))
				solver.add(z3.Implies(vars[f"{current_function}.{match.group(2)}"], vars[f"{current_function}.{match.group(1)}"]))
			elif match := search(r"store ptr ([%@]?\S+), ptr ([%@]\S+), .+ !{!\"(public|private)\", !\"(public|private)\"}", line):
				# store ptr
				add_variable(f"{current_function}.{match.group(2)}", match.group(4))
				add_variable(f"{current_function}.{match.group(1)}", match.group(3))
				solver.add(z3.Implies(vars[f"{current_function}.min_pc"], vars[f"{current_function}.{match.group(2)}"]))
				solver.add(vars[f"{current_function}.{match.group(1)}"] == vars[f"{current_function}.{match.group(2)}"])
			elif match := search(r"store .+ ([%@]?\S+), ptr ([%@]\S+), .+ !{!\"(public|private)\", !\"(public|private)\"}", line):
				# store
				add_variable(f"{current_function}.{match.group(2)}", match.group(4))
				add_variable(f"{current_function}.{match.group(1)}", match.group(3))
				solver.add(z3.Implies(vars[f"{current_function}.min_pc"], vars[f"{current_function}.{match.group(2)}"]))
				solver.add(z3.Implies(vars[f"{current_function}.{match.group(1)}"], vars[f"{current_function}.{match.group(2)}"]))
			elif match := search(r"(%\S+) = (?:add|sub|mul|sdiv|udiv|srem|urem|fadd|fsub|fmul|fdiv|frem|and|or|xor|shl|lshr|ashr|icmp|fcmp) .+ ([%@]?\S+), ([%@]?\S+), !sec !\{!\"(public|private)\"\}", line):
				# binary operations
				add_variable(f"{current_function}.{match.group(1)}", match.group(4))
				solver.add(z3.Implies(vars[f"{current_function}.min_pc"], vars[f"{current_function}.{match.group(1)}"]))
				solver.add(z3.Implies(vars[f"{current_function}.{match.group(2)}"], vars[f"{current_function}.{match.group(1)}"]))
				solver.add(z3.Implies(vars[f"{current_function}.{match.group(3)}"], vars[f"{current_function}.{match.group(1)}"]))
			# elif match := search(r"br .+ ([%@]\S+), label (%\S+), label (%\S+), !sec !{!\"(public|private)\"}", line):
			# 	# conditional branch
			# 	current_block.add_instruction(BrCond(i + 1, (match.group(1), str_to_label(match.group(4))), match.group(2), match.group(3)))
			# 	current_block.add_succ(match.group(2))
			# 	current_block.add_succ(match.group(3))
			elif match := search(r"ret void", line):
				# ret void
				pass
			elif match := search(r"ret .+ ([%@]\S+), !sec !{!\"(public|private)\"}", line):
				# ret
				add_variable(f"{current_function}.{match.group(1)}", match.group(2))
				solver.add(vars[f"{current_function}.{match.group(1)}"] == vars[f"{current_function}.ret"])
			elif match := search(r"(%\S+) = call .+ @declassify\S*\([^,]+ (\S+)(?:, [^,]+ (\S+))*\)", line):
				# declassify
				labels = findall(r"\"(public|private)\"", line)
				args = [x.split(" ")[-1] for x in search(r"\(([^)]+)\)", line).group(1).split(", ")]
				add_variable(f"{current_function}.{match.group(1)}", labels[1])
				solver.add(z3.Implies(vars[f"{current_function}.min_pc"], vars[f"{current_function}.{match.group(1)}"]))
			elif match := search(r"(%\S+) = call .+ (@\S+)\([^,]+ (\S+)(?:, [^,]+ (\S+))*\)", line):
				# call
				labels = findall(r"\"(public|private)\"", line)
				args = [x.split(" ")[-1] for x in search(r"\(([^)]+)\)", line).group(1).split(", ")]
				solver.add(z3.Implies(vars[f"{current_function}.min_pc"], vars[f"{match.group(2)}.min_pc"]))
				for (j, arg) in enumerate(labels[1:]):
					add_variable(f"{current_function}.{args[j]}", arg)
					solver.add(z3.Implies(vars[f"{current_function}.{args[j]}"], vars[f"{match.group(2)}.param{j}"]))
				vars[f"{current_function}.{match.group(1)}"] = z3.Bool(f"{current_function}.{match.group(1)}")
				solver.add(z3.Implies(vars[f"{match.group(2)}.ret"], vars[f"{current_function}.{match.group(1)}"]))
			elif match := search(r"call void (@\S+)\([^,]+ (\S+)(?:, [^,]+ (\S+))*\)", line):
				# call void
				labels = findall(r"\"(public|private)\"", line)
				args = [x.split(" ")[-1] for x in search(r"\(([^)]+)\)", line).group(1).split(", ")]
				solver.add(z3.Implies(vars[f"{current_function}.min_pc"], vars[f"{match.group(1)}.min_pc"]))
				for (j, arg) in enumerate(labels[1:]):
					add_variable(f"{current_function}.{args[j]}", arg)
					solver.add(z3.Implies(vars[f"{current_function}.{args[j]}"], vars[f"{match.group(1)}.param{j}"]))
			elif not line.isspace():
				print(f"Ignoring {line[ : -1]}")
	if solver.check() == z3.unsat:
		print(f"Unsatisfied: {solver.unsat_core()}")
	else:
		print("All constraints satisfied")

if __name__ == "__main__":
	if len(argv) != 2:
		print(f"Usage: {argv[0]} <file>")
	type_check(argv[1])