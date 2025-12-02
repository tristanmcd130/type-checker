from module import *
from re import search, findall
from sys import argv

def type_check(filename: str):
	module = Module()
	current_function = None
	current_block = None
	with open(filename, "r") as file:
		for (i, line) in enumerate(file.readlines()):
			if match := search(r"(@\S+) = .+ !sec !{!\"(\w+)\"}", line):
				# global variable
				module.add_global(match.group(1), str_to_label(match.group(2)))
			elif match := search(r"declare .+ @(free|malloc)\(", line):
				# free and malloc
				pass
			elif match := search(r"declare .+ (@\S+)\(", line):
				# declare
				labels = list(map(str_to_label, findall(r"\"(public|private|void|...)\"", line)))
				module.add_function(DeclaredFunction(match.group(1), labels[0], labels[1], labels[2 : ]))
				print(f"DECLARE {match.group(1)}")
			elif match := search(r"define .+ (@\S+)\(", line):
				# define
				labels = list(map(str_to_label, findall(r"\"(public|private|void|...)\"", line)))
				params = findall(r"(%[^,)]+)", line)
				current_function = Function(match.group(1), labels[0], labels[1], dict(zip(params, labels[2 : ])), module)
				# current_block = Block("%entry", labels[1], current_function)
				# current_function.add_block(current_block)
				print(f"START {current_function.name}({", ".join(params)})")
			elif match := search(r"^(\S+):.+!sec !{!\"(public|private)\"}", line):
				# block
				current_block = Block("%" + match.group(1), str_to_label(match.group(2)), current_function)
				current_function.add_block(current_block)
				print(f"{match.group(1)}")
			elif match := search(r"^}", line):
				# end of function
				module.add_function(current_function)
				print(f"END {current_function.name}\n")
			elif match := search(r"(%\S+) = alloca .+ !sec !{!\"(public|private)\"}", line):
				# alloca
				current_block.add_instruction(Alloca(i + 1, (match.group(1), str_to_label(match.group(2)))))
			elif match := search(r"(%\S+) = load .+ ptr ([%@]\S+), .+ !sec !{!\"(public|private)\", !\"(public|private)\"}", line):
				# load
				current_block.add_instruction(Load(i + 1, (match.group(1), str_to_label(match.group(3))), (match.group(2), str_to_label(match.group(4)))))
			elif match := search(r"store .+ ([%@]?\S+), ptr ([%@]\S+), .+ !{!\"(public|private)\", !\"(public|private)\"}", line):
				# store
				current_block.add_instruction(Store(i + 1, (match.group(1), str_to_label(match.group(3))), (match.group(2), str_to_label(match.group(4)))))
			elif match := search(r"(%\S+) = (?:add|sub|mul|sdiv|udiv|srem|urem|fadd|fsub|fmul|fdiv|frem|and|or|xor|shl|lshr|ashr|icmp|fcmp) .+ ([%@]?\S+), ([%@]?\S+), !sec !\{!\"(public|private)\"\}", line):
				# binary operations
				current_block.add_instruction(BinaryOp(i + 1, (match.group(1), str_to_label(match.group(4))), match.group(2), match.group(3)))
			elif match := search(r"br .+ ([%@]\S+), label (%\S+), label (%\S+), !sec !{!\"(public|private)\"}", line):
				# conditional branch
				current_block.add_instruction(BrCond(i + 1, (match.group(1), str_to_label(match.group(4))), match.group(2), match.group(3)))
				current_block.add_succ(match.group(2))
				current_block.add_succ(match.group(3))
			elif match := search(r"ret .+ ([%@]\S+), !sec !{!\"(public|private)\"}", line):
				# ret
				current_block.add_instruction(Ret(i + 1, (match.group(1), str_to_label(match.group(2)))))
			elif match := search(r"ret void", line):
				# ret void
				current_block.add_instruction(Ret(i + 1, ("void", Label.Void())))
			elif not line.isspace():
				print(f"Ignoring {line[ : -1]}")
	module.type_check()

if __name__ == "__main__":
	type_check(argv[1])