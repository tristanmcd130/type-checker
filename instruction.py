from label import *
from dataclasses import dataclass

@dataclass
class Alloca:
	line_num: int
	var: tuple[str, Label]

@dataclass
class Load:
	line_num: int
	dest: tuple[str, Label]
	src: tuple[str, Label]

@dataclass
class Store:
	line_num: int
	src: tuple[str, Label]
	tgt: tuple[str, Label]

@dataclass
class BrCond:
	line_num: int
	cond: tuple[str, Label]
	true_block: str
	false_block: str

@dataclass
class BinaryOp:
	line_num: int
	result: tuple[str, Label]
	op1: str
	op2: str

@dataclass
class Ret:
	line_num: int
	value: tuple[str, Label]

Instruction = Alloca \
			| Load \
			| Store \
			| BrCond \
			| BinaryOp