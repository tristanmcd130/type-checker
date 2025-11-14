from label import LabelEnv, str_to_label
from re import search, findall

def type_check(filename: str) -> None:
	env = LabelEnv()
	current_func = None
	current_block = None
	with open(filename, "r") as file:
		for i, line in enumerate(file.readlines()):
			if match := search(r"(@\S+) = .+ !sec !{!\"(\w+)\"}", line):
				# global variable
				env[match.group(1)] = str_to_label(match.group(2))
			elif match := search(r"declare .+ @free\(", line):
				# free
				pass
			elif match := search(r"declare .+ (@\S+)\(", line):
				# declare
				name = match.group(1)
				matches = findall(r"\"(public|private|void|...)\"", line)
				if matches[0] != "void" and matches[1] != matches[0]:
					raise TypeError(f"{filename}:{i + 1}: {name} has different ret ({matches[0]}) and pc ({matches[1]}) labels")
				env[name] = str_to_label(" ".join(matches))
			elif match := search(r"define .+ (@\S+)\(", line):
				# define
				name = match.group(1)
				matches = findall(r"\"(public|private|void|...)\"", line)
				if matches[0] != "void" and matches[1] != matches[0]:
					raise TypeError(f"{filename}:{i + 1}: {name} has different ret ({matches[0]}) and pc ({matches[1]}) labels")
				env[name] = str_to_label(" ".join(matches))
				current_func = name
				print(f"START {current_func}")
				env = LabelEnv(env)
			elif match := search(r"^(\S+):", line):
				# block
				current_block = match.group(1)
				print(f"{match.group(1)}")
			elif match := search(r"^}", line):
				env = env.parent
				print(f"END {current_func}")
			# else:
			# 	print(f"Ignoring {filename}:{i}: {line}")

print(type_check("btree1-annotated.ll"))