ASM = nasm
NASMFLAGS = -f elf -g
LDFLAGS = -m elf_i386

all: echo call_bash reverse_shell

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
