SRC := $(wildcard *.c)
LL := $(SRC:.c=.ll)
all: $(LL)

%.ll: %.c
	clang -S -emit-llvm $< -o _$@

clean:
	rm -f $(LL)