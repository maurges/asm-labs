ASM = nasm
NASMFLAGS = -f elf -g
LDFLAGS = -m elf_i386

%.o: %.asm
	$(ASM) $< $(NASMFLAGS) -o $@

%.l: %.asm
	$(ASM) $< $(NASMFLAGS) -l $@

echo.o: echo.asm socket.asmh
	$(ASM) $< $(NASMFLAGS) -o $@

echo: socket.o echo.o
	ld $(LDFLAGS) $^ -o $@
