from label import Label
from dataclasses import dataclass

@dataclass
class Alloca:
	var: tuple[str, Label]

@dataclass
class Load:
	dest: tuple[str, Label]
	src: tuple[str, Label]

@dataclass
class Store:
	src: tuple[str, Label]
	tgt: tuple[str, Label]

Instruction = Alloca \
			| Load \
			| Store