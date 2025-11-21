from enum import Enum, auto

class Label(Enum):
	Public = auto()
	Private = auto()
	Void = auto()
	VarArgs = auto()

def str_to_label(string: str) -> Label:
	match string:
		case "public":
			return Label.Public
		case "private":
			return Label.Private
		case "void":
			return Label.Void
		case "...":
			return Label.VarArgs
		case _:
			raise ValueError(f"{string} is not a valid label")

def label_to_str(label: Label) -> str:
	match label:
		case Label.Public:
			return "public"
		case Label.Private:
			return "private"
		case Label.Void:
			return "void"
		case Label.VarArgs:
			return "..."

def flows(src: Label, tgt: Label) -> bool:
	return not (src == Label.Private and tgt == Label.Public)

def equals(src: Label, tgt: Label) -> bool:
	return src == tgt

def join(label1: Label, label2: Label) -> Label:
	if label1 == Label.Private or label2 == Label.Private:
		return Label.Private
	return Label.Public