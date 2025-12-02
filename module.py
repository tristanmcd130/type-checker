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
			print(self.function.labels)
			print(self.function.module.globals)
			print()
			match instruction:
				case Alloca(line_num, (var_name, var_label)):
					assert flows(self.pc, var_label), f"alloca on line {line_num}: block label ({self.pc}) doesn't flow to {var_name}'s label ({var_label})"
					self.function.add_local(var_name, var_label)
				case Load(line_num, (dest_name, dest_label), (src_name, src_label)):
					assert equals(self.function.get_label(src_name), src_label), f"load on line {line_num}: {src_name}'s label isn't actually {src_label}"
					assert flows(self.pc, dest_label), f"load on line {line_num}: block label ({self.pc}) doesn't flow to {dest_name}'s label ({dest_label})"
					assert flows(src_label, dest_label), f"load on line {line_num}: {src_name}'s label ({src_label}) doesn't flow to {dest_name}'s label ({dest_label})"
					self.function.add_local(dest_name, dest_label)
				case Store(line_num, (tgt_name, tgt_label), (src_name, src_label)):
					# if src is a pointer, src = tgt, otherwise, src => tgt: for now we'll do the stricter check
					assert equals(self.function.get_label(tgt_name), tgt_label), f"store on line {line_num}: {tgt_name}'s label isn't actually {tgt_label}"
					assert equals(self.function.get_label(src_name), src_label), f"store on line {line_num}: {src_name}'s label isn't actually {src_label}"
					assert equals(src_label, tgt_label), f"store on line {line_num}: {src_name}'s label ({src_label}) doesn't equal {tgt_name}'s label ({tgt_label})"
				case BrCond(line_num, (cond_name, cond_label), true_block, false_block):
					assert equals(self.function.get_label(cond_name), cond_label), f"br on line {line_num}: {cond_name}'s label isn't actually {cond_label}"
					assert flows(join(self.pc, cond_label), self.function.get_label(true_block)), f"br on line {line_num}: block label ({self.pc}) joined with {cond_name}'s label ({cond_label}) doesn't flow to {true_block}'s label ({self.function.get_label(true_block)})"
					assert flows(join(self.pc, cond_label), self.function.get_label(false_block)), f"br on line {line_num}: block label ({self.pc}) joined with {cond_name}'s label ({cond_label}) doesn't flow to {false_block}'s label ({self.function.get_label(false_block)})"
				case BinaryOp(line_num, (result_name, result_label), op1, op2):
					assert flows(self.pc, result_label)
					# no idea how to deal with subtyping here so we'll just join the operand labels together
					assert equals(join(self.function.get_label(op1), self.function.get_label(op2)), result_label), f"binary op on line {line_num}: join of {op1} ({self.function.get_label(op1)}) and {op2}'s label ({self.function.get_label(op2)}) doesn't equal {result_name}'s label ({result_label})"
					print(f"ADDING {result_name} TO {self.function.name} WITH LABEL {result_label}: BEFORE: {self.function.labels}")
					self.function.add_local(result_name, result_label)
					print(f"AFTER: {self.function.labels}")
				case Ret(line_num, (value_name, value_label)):
					assert equals(self.function.get_label(value_name), value_label), f"ret on line {line_num}: {value_name}'s label isn't actually {value_label}"
					assert equals(value_label, self.function.ret), f"ret on line {line_num}: {value_name}'s label doesn't equal {self.function.name}'s return label ({self.function.ret})"
				case _:
					raise ValueError(f"{instruction} is invalid")
	def add_succ(self, name: str):
		self.succs.add(name)

class Function:
	def __init__(self, name: str, ret: Label, min_pc: Label, params: dict[str, Label], module: "Module"):
		assert ret == Label.Void or ret == min_pc, f"{name} has different return ({ret}) and min pc ({min_pc}) labels"
		self.name = name
		self.ret = ret
		self.min_pc = min_pc
		self.module = module
		self.blocks = {} # {str: Block}
		self.labels = params # {str: Label}, includes labels for local vars, params, and blocks
	def add_block(self, block: Block):
		assert block.name not in self.blocks, f"{self.name} already has a block called {block.name}"
		self.blocks[block.name] = block
		self.labels[block.name] = block.pc
	def add_local(self, name: str, label: Label):
		self.labels[name] = label
	def get_label(self, name: str) -> Label:
		print(f"Function.get_label: {name=}, {self.labels=}")
		if name[0] == "%":
			return self.labels[name]
		if name[0] == "@":
			return self.module.globals[name]
		if name == "void":
			return Label.Void
		return Label.Public # all non-null literals are public (tech report page 9, t-const)
		# raise NameError(f"{name} is not a variable")
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