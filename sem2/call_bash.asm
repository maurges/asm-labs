%include "socket.asmh"
;; vim: ft=nasm

global _start

section .text
; text {{{

; _start {{{
_start:
	mov eax, 0xb
	mov ebx, cmd
	mov ecx, 0
	mov edx, 0
	int 0x80
	
; }}}

; }}}

section .data
; data {{{
cmd:	db "/bin/bash",0
cmd_len	equ $ - cmd

; }}}
