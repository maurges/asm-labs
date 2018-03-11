;; vim: ft=nasm

global _start

section .text
_start:
	mov esi, code
	mov edi, code_end
.loop:	mov al, [esi]
	mov bl, al
	shr al, 4
	and bl, 0xf

	add al, "0"
	cmp al, "9"
	jle .al_put
	add al, "a" - "0" - 10
.al_put:	mov [digit0], al

	add bl, "0"
	cmp bl, "9"
	jle .bl_put
	add bl, "a" - "0" - 10
.bl_put:	mov [digit1], bl

	mov eax, 4
	mov ebx, 1
	mov ecx, template
	mov edx, len
	int 0x80

	inc esi
	cmp esi, edi
	jne .loop

	push byte 10
	mov eax, 4
	mov ebx, 1
	mov ecx, esp
	mov edx, 1
	int 0x80

	mov eax, 1
	mov ebx, 0
	int 0x80

section .data

template: db "0x"
digit0:	db "0"
digit1:	db "0"
	db ", "
len equ $ - template

code:
%include "cb_obj.asm"
code_end:
