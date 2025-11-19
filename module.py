from label import *
from instruction import *

class Block:
	def __init__(self, name: str, pc: Label):
		self.name = name
		self.pc = pc
		self.instructions = []
		self.succs = {}
		self.preds = {}
	def add_instruction(self, instruction: Instruction):
		self.instructions.append(instruction)
	def type_check(self):
		for instruction in self.instructions:
			match instruction:
				case Alloca(var):
					assert flows(self.pc, var)
				case Load(dest, src):
					assert flows(self.pc, dest)
					assert flows(src, dest)
				case Store(tgt, src):
					assert flows(self.pc, tgt)
					# if src is a pointer, src = tgt, otherwise, src => tgt
	def dfs(self):
		return [self] + sum([block.dfs() for block in self.succs.values()], [])

class Function:
	def __init__(self, name: str, ret: Label, min_pc: Label, params: dict[str, Label]):
		assert ret == Label.Void or ret == min_pc, f"{name} has different return and min pc labels"
		self.name = name
		self.ret = ret
		self.min_pc = min_pc
		self.params = params
	def set_entry(self, entry: Block):
		self.entry = entry
	def type_check(self):
		# to find immediate post doms: lengauer tarjan
		for block in self.entry.dfs():
			assert flows(self.min_pc, block.pc)

class DeclaredFunction:
	def __init__(self, name: str, ret: Label, min_pc: Label, params: list[Label]):
		assert ret == Label.Void or ret == min_pc, f"{name} has different return and min pc labels"
		self.name = name
		self.ret = ret
		self.min_pc = min_pc
		self.params = params

class Module:
	def __init__(self):
		self.globals = {}
		self.functions = {}
	def add_global(self, name: str, label: Label):
		assert name not in self.globals, f"Global {name} already defined"
		self.globals[name] = label
	def add_function(self, func: Function | DeclaredFunction):
		self.functions[func.name] = func