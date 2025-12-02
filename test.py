from type_check import type_check
from os import listdir

passed = 0
total = 0
for filename in listdir("tests"):
	try:
		type_check(f"tests/{filename}")
		print(f"✔️ {filename}")
		passed += 1
	except Exception as e:
		print(f"❌ {filename}: {e}")
	total += 1

print(f"{passed}/{total} tests passed")