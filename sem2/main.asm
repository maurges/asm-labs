%include "socket.asmh"

global _start

section .text
; text {{{

; _start {{{
_start:
	call TCPSocketNewBind

	push eax
	call TCPSocketClose

	mov eax, 1
	mov ebx, 0
	int 0x80
; }}}

; }}}
