from dataclasses import dataclass

@dataclass
class Public:
	pass

@dataclass
class Private:
	pass

@dataclass
class Void:
	pass

@dataclass
class VarArgs:
	pass

@dataclass
class Function:
	params: list["Label"]
	ret: "Label"

Label = Public | Private | Function | Void | VarArgs

def str_to_label(string: str) -> Label:
	match string:
		case "public":
			return Public()
		case "private":
			return Private()
		case "void":
			return Void()
		case "...":
			return VarArgs()
		case _:
			labels = string.split(" ")
			if len(labels) > 1:
				return Function(list(map(str_to_label, labels[2:])), str_to_label(labels[0]))
			raise ValueError(f"{labels[0]} is not a valid label")

def label_to_str(label: Label) -> str:
	match label:
		case Public():
			return "public"
		case Private():
			return "private"
		case Function(params, ret):
			return f"({", ".join(map(label_to_str, params))}) -> {label_to_str(ret)}"
		case Void():
			return "void"
		case VarArgs():
			return "..."

class LabelEnv:
	def __init__(self, parent: "None | LabelEnv" = None, labels: dict[str, Label] = {}):
		self.parent = parent
		self.labels = labels
	def __getitem__(self, name: str) -> Label:
		if name not in self.labels:
			return self.parent[name]
		return self.labels[name]
	def __setitem__(self, name: str, label: Label) -> None:
		assert name not in self.labels, f"{name} was already given a label"
		self.labels[name] = label
	def __str__(self) -> str:
		return self.to_string(0)
	def to_string(self, tabs: int) -> str:
		string = ""
		if self.parent:
			string += str(self.parent) + "\n"
		return string + "\n".join([f"{"\t" * tabs}{name}: {label_to_str(label)}" for name, label in self.labels.items()])