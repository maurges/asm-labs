ASM = nasm
NASMFLAGS = -f elf -g
LDFLAGS = -m elf_i386


%.o: %.asm meta.inc syscalls.inc
	$(ASM) $< $(NASMFLAGS) -o $@

%.l: %.asm meta.inc syscalls.inc
	$(ASM) $< $(NASMFLAGS) -l $@

all: *.o
 	ld $(LDFLAGS) -o main $^
