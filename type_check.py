from label import str_to_label
from module import Module, Function, Block, DeclaredFunction
from re import search, findall

def type_check(filename: str) -> None:
	module = Module()
	current_func = None
	current_block = None
	with open(filename, "r") as file:
		for i, line in enumerate(file.readlines()):
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
				current_func = Function(match.group(1), labels[0], labels[1], dict(zip(params, labels[2 : ])))
				print(f"START {current_func.name}")
			elif match := search(r"^(\S+):.+!sec !{!\"(public|private)\"}", line):
				# block
				current_block = Block(match.group(1), str_to_label(match.group(2)))
				print(f"{match.group(1)}")
			elif match := search(r"^}", line):
				# end of function
				module.add_function(current_func)
				print(f"END {current_func.name}\n")
			# else:
			# 	print(f"Ignoring {filename}:{i}: {line}")

type_check("btree1-annotated.ll")