%include "meta.inc"
%include "syscalls.inc"

%include "terminal.asmh"

global _start


section .text

_start:
	call set_term_await

	cld

	vcall get_pwd, hello_world, hwlength

	call restore_term_setting

	sys_write 1, hello_world, hwlength

	sys_exit 0


section .data

hello_world:
	db "hello tupoy pidor", 10
hwlength equ $ - hello_world
