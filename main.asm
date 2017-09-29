%include "meta.inc"
%include "syscalls.inc"

%include "terminal.asmh"

global _start


section .text

_start:

	cld

	vcall get_pwd, hello_world, hwlength
	;; save length for later
	mov r15, rax
	;; no CR symbol plz
	mov [hello_world + rax], byte 10
	inc r15

	sys_write 1, hello_world, r15

	sys_exit 0


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
