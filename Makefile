ASM = nasm
NASMFLAGS = -f elf64 -g
LDFLAGS = -lstdio -I /lib/ld-linux.so.2


%.o: %.asm meta.inc syscalls.inc
	$(ASM) $< $(NASMFLAGS) -o $@

%.l: %.asm meta.inc syscalls.inc
	$(ASM) $< $(NASMFLAGS) -l $@

all: *.o */*.o
# 	ld $(LDFLAGS) -o main $^
	gcc -o main main.c $^
