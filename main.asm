%include "meta.inc"
%include "syscalls.inc"

%include "terminal.asmh"
%include "vigenere/main.asmh"

global _start


section .text
; text {{{

_start:

	call VigenereCipher

	sys_exit 0

; }}}

section .data
; data {{{

hello_world:
	db "hello tupoy pidor", 10
hwlength equ $ - hello_world

output:
	db "you entered: "
your_char:
	db 'Y', 10
textlength equ $ - output

; }}}
