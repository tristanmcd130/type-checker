from label import *
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

@dataclass
class BrCond:
	cond: tuple[str, Label]
	true_block: str
	false_block: str

Instruction = Alloca \
			| Load \
			| Store \
			| BrCond