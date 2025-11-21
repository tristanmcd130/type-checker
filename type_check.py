from module import *
from re import search, findall

def type_check(filename: str):
	module = Module()
	current_function = None
	current_block = None
	with open(filename, "r") as file:
		for line in file.readlines():
			if match := search(r"(@\S+) = .+ !sec !{!\"(\w+)\"}", line):
				# global variable
				module.add_global(match.group(1), str_to_label(match.group(2)))
			elif match := search(r"declare .+ @free\(", line):
				# free
				pass
			elif match := search(r"declare .+ (@\S+)\(", line):
				# declare
				labels = list(map(str_to_label, findall(r"\"(public|private|void|...)\"", line)))
				module.add_function(DeclaredFunction(match.group(1), labels[0], labels[1], labels[2 : ]))
				print(f"DECLARE {match.group(1)}")
			elif match := search(r"define .+ (@\S+)\(", line):
				# define
				labels = list(map(str_to_label, findall(r"\"(public|private|void|...)\"", line)))
				params = findall(r"\"(%[^,)]+)\"", line)
				current_function = Function(match.group(1), labels[0], labels[1], dict(zip(params, labels[2 : ])), module)
				print(f"START {current_function.name}")
			elif match := search(r"^(\S+):.+!sec !{!\"(public|private)\"}", line):
				# block
				current_block = Block(match.group(1), str_to_label(match.group(2)), current_function)
				current_function.add_block(current_block)
				print(f"{match.group(1)}")
			elif match := search(r"^}", line):
				# end of function
				module.add_function(current_function)
				print(f"END {current_function.name}\n")
			elif match := search(r"(%\S+) = alloca .+ !sec !{!\"(public|private)\"}", line):
				# alloca
				current_block.add_instruction(Alloca((match.group(1), str_to_label(match.group(2)))))
			elif match := search(r"(%\S+) = load .+ ptr ([%@]\S+), !sec !{!\"(public|private)\", !\"(public|private)\"}", line):
				# load
				current_block.add_instruction(Load((match.group(1), str_to_label(match.group(3))), (match.group(2), str_to_label(match.group(4)))))
			elif match := search(r"store .+ ([%@]\S), ptr ([%@]\S) .+ !{!\"(public|private)\", !\"(public|private)\"}", line):
				# store
				current_block.add_instruction(Store((match.group(1), str_to_label(match.group(4))), (match.group(2), str_to_label(match.group(3)))))
			elif match := search(r"br .+ ([%@]\S+), label (%\S+), label (%\S+), !sec !{!\"(public|private)\"}", line):
				# conditional branch
				current_block.add_instruction(BrCond((match.group(1), str_to_label(match.group(4))), match.group(2), match.group(3)))
				current_block.add_succ(match.group(2))
				current_block.add_succ(match.group(3))
			# else:
			# 	print(f"Ignoring {line[ : -1]}")
	module.type_check()

if __name__ == "__main__":
	type_check("btree1-annotated.ll")