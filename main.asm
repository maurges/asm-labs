%include "meta.inc"
%include "syscalls.inc"

global _start


section .text

defun add_vals, a, b
	add a, b
	return a
endfun

_start:
	mov rax, 5
	mov rbx, 10
	vcall add_vals, rax, rbx

	sys_call sys_write, 1, hello_world, hwlength
	sys_call sys_exit, 0


section .data

hello_world:
	db "hello tupoy pidor", 10
hwlength equ $ - hello_world
