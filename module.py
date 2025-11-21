from instruction import *

class Block:
	def __init__(self, name: str, pc: Label, function: "Function"):
		self.name = name
		self.pc = pc
		self.function = function
		self.instructions = []
		self.succs = set()
	def add_instruction(self, instruction: Instruction):
		self.instructions.append(instruction)
	def type_check(self):
		print(f"block {self.name} type check")
		for instruction in self.instructions:
			print(instruction)
			match instruction:
				case Alloca((var_name, var_label)):
					assert flows(self.pc, var_label)
					self.function.add_local(var_name, var_label)
				case Load((dest_name, dest_label), (src_name, src_label)):
					assert equals(self.function.get_label(src_name), src_label)
					assert flows(self.pc, dest_label)
					assert flows(src_label, dest_label)
					self.function.add_local(dest_name, dest_label)
				case Store((tgt_name, tgt_label), (src_name, src_label)):
					# if src is a pointer, src = tgt, otherwise, src => tgt: for now we'll do the stricter check
					assert equals(self.function.get_label(tgt_name), tgt_label)
					assert equals(self.function.get_label(src_name), src_label)
					assert equals(src_label, tgt_label)
				case BrCond((cond_name, cond_label), true_block, false_block):
					assert equals(self.function.get_label(cond_name), cond_label)
					assert flows(join(self.pc, cond_label), self.function.get_label(true_block))
					assert flows(join(self.pc, cond_label), self.function.get_label(false_block))
	def add_succ(self, name: str):
		self.succs.add(name)

class Function:
	def __init__(self, name: str, ret: Label, min_pc: Label, params: dict[str, Label], module: "Module"):
		assert ret == Label.Void or ret == min_pc, f"{name} has different return ({ret}) and min pc ({min_pc}) labels"
		self.name = name
		self.ret = ret
		self.min_pc = min_pc
		self.params = params
		self.module = module
		self.blocks = {} # {str: Block}
		self.labels = {} # {str: Label}
	def add_block(self, block: Block):
		assert block.name not in self.blocks, f"{self.name} already has a block called {block.name}"
		self.blocks[block.name] = block
		self.labels[block.name] = block.pc
	def add_local(self, name: str, label: Label):
		self.labels[name] = label
	def get_label(self, name: str) -> Label:
		if name in self.labels:
			return self.get_label(name)
		return self.module.globals[name]
	def type_check(self):
		# to find immediate post doms: lengauer tarjan
		print(f"function {self.name} type check")
		for block in self.blocks.values():
			assert flows(self.min_pc, block.pc), f"{self.name}'s min pc ({self.min_pc}) doesn't flow to {block.name}'s label ({block.pc})"
			block.type_check()

class DeclaredFunction:
	def __init__(self, name: str, ret: Label, min_pc: Label, params: list[Label]):
		assert ret == Label.Void or ret == min_pc, f"{name} has different return ({ret}) and min pc ({min_pc}) labels"
		self.name = name
		self.ret = ret
		self.min_pc = min_pc
		self.params = params
	def type_check(self):
		print(f"declared function {self.name} type check")

class Module:
	def __init__(self):
		self.globals = {}
		self.functions = {}
	def add_global(self, name: str, label: Label):
		assert name not in self.globals, f"Global {name} already defined"
		self.globals[name] = label
	def add_function(self, function: Function | DeclaredFunction):
		assert function.name not in self.functions, f"Function {function.name} already defined"
		self.functions[function.name] = function
	def type_check(self):
		print(f"module type check")
		for function in self.functions.values():
			function.type_check()