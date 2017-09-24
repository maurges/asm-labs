%include "meta.inc"
%include "syscalls.inc"

%include "terminal.asmh"

global _start


section .text

defun add_vals, a, b
	add a, b
	return a
endfun

_start:
	call set_term_await
	call getch
	mov [hello_world], al
	call restore_term_setting
	sys_call sys_write, 0, hello_world, hwlength

	sys_call sys_exit, 0


section .data

hello_world:
	db "hello tupoy pidor", 10
hwlength equ $ - hello_world
