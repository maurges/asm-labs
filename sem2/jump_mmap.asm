;; vim: ft=nasm

global _start

struc mmap_arg
  .suggest: resd 1
  .length:  resd 1
  .perm:    resd 1
  .flags:   resd 1
  .fd:      resd 1
  .file_off:resd 1
  .size:
endstruc

section .text
; text {{{

; _start {{{
_start:
	mov ebp, esp
	sub esp, 4 ;; address allocated by mmap

	sub esp, mmap_arg.size
	mov [esp + mmap_arg.suggest], dword 0
	mov [esp + mmap_arg.length], dword codesize
	mov [esp + mmap_arg.perm], dword 7 ;; rwx
	mov [esp + mmap_arg.flags], dword 0x22 ;; MAP_PRIVATE|MAP_ANONYMOUS
	mov [esp + mmap_arg.fd], dword -1
	mov [esp + mmap_arg.file_off], dword 0
	mov eax, 0x5a
	mov ebx, esp
	int 0x80
	add esp, mmap_arg.size
	mov [ebp-4], eax

	mov ebx, code
	add ebx, codesize
	mov edi, eax
	mov esi, code
.loop:	mov dl, [esi]
	mov [edi], dl
	inc edi
	inc esi
	cmp esi, ebx
	jne .loop

	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, strm
	mov edx, strlen
	int 0x80

	mov eax, [ebp-4]
	call eax

	mov eax, 0x5b
	mov ebx, [ebp-4]
	mov ecx, 15
	int 0x80

	mov eax, 1
	mov ebx, 0
	int 0x80
; }}}

; }}}

section .data
; data {{{
code: db 0x83, 0xec, 0x0a, 0xc6, 0x04, 0x24, 0x2f, 0xc6, 0x44, 0x24, 0x01, 0x62, 0xc6, 0x44, 0x24, 0x02, 0x69, 0xc6, 0x44, 0x24, 0x03, 0x6e, 0xc6, 0x44, 0x24, 0x04, 0x2f, 0xc6, 0x44, 0x24, 0x05, 0x62, 0xc6, 0x44, 0x24, 0x06, 0x61, 0xc6, 0x44, 0x24, 0x07, 0x73, 0xc6, 0x44, 0x24, 0x08, 0x68, 0xc6, 0x44, 0x24, 0x09, 0x00, 0xb8, 0x0b, 0x00, 0x00, 0x00, 0x89, 0xe3, 0x31, 0xc9, 0x31, 0xd2, 0xcd, 0x80
codesize equ $ - code

strm: db "going in",10
strlen equ $ - strm

; }}}
