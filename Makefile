ASM = nasm
NASMFLAGS = -f elf64 -g
LDFLAGS = 


%.o: %.asm meta.inc syscalls.inc
	$(ASM) $< $(NASMFLAGS) -o $@

%.l: %.asm meta.inc syscalls.inc
	$(ASM) $< $(NASMFLAGS) -l $@

all: *.o */*.o
	ld -o main $^
