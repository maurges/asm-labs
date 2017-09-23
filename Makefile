ASM = nasm
NASMFLAGS = -f elf64 -g
LDFLAGS = 


%.o: %.asm meta.asm
	$(ASM) $< $(NASMFLAGS) -o $@

%.l: %.asm meta.asm
	$(ASM) $< $(NASMFLAGS) -l $@

all: *.o
	ld -o main $^
