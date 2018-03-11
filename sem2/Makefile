ASM = nasm
NASMFLAGS = -f elf -F dwarf -g
LDFLAGS = -m elf_i386

all: echo call_bash reverse_shell jump_mmap

%.o: %.asm
	$(ASM) $< $(NASMFLAGS) -o $@

%.l: %.asm
	$(ASM) $< $(NASMFLAGS) -l $@

echo.o: echo.asm socket.asmh
	$(ASM) $< $(NASMFLAGS) -o $@

echo: socket.o echo.o
	ld $(LDFLAGS) $^ -o $@

call_bash: call_bash.o
	ld $(LDFLAGS) $^ -o $@

reverse_shell.o: reverse_shell.asm socket.asmh
	$(ASM) $< $(NASMFLAGS) -o $@

reverse_shell: socket.o reverse_shell.o
	ld $(LDFLAGS) $^ -o $@

jump_mmap: jump_mmap.o
	ld $(LDFLAGS) $^ -o $@

prepare: prepare.asm cb_obj.asm
	$(ASM) $< $(NASMFLAGS) -o prepare.o
	ld $(LDFLAGS) prepare.o -o $@

.PHONY: run-prepare
run-prepare: prepare
	./prepare
