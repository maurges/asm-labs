ASM = nasm
NASMFLAGS = -f elf -g
LDFLAGS = -m elf_i386


%.o: %.asm
	$(ASM) $< $(NASMFLAGS) -o $@

%.l: %.asm
	$(ASM) $< $(NASMFLAGS) -l $@

all: *.o
	ld $(LDFLAGS) -o main $^
