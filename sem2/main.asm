%include "socket.asmh"
;; vim: ft=nasm

global _start

section .text
; text {{{

; _start {{{
_start:
	mov ebp, esp
	sub esp, 8 ;; two values: two sockfd

	call TCPSocketNewBind
	mov [ebp-4], eax

	push dword [ebp-4]
	call TCPSocketAccept
	mov [ebp-8], eax

	mov eax, 3
	mov ebx, [ebp-8]
	mov ecx, gotstr
	mov edx, gotstr_len
	int 0x80

	mov eax, 4
	mov ebx, [ebp-8]
	mov ecx, greetstr
	mov edx, greetstr_len
	int 0x80

	push dword [ebp-8]
	call TCPSocketClose
	push dword [ebp-4]
	call TCPSocketClose

	mov eax, 1
	mov ebx, 0
	int 0x80
; }}}

; }}}

section .data
; data {{{
greetstr: db "go away",10
greetstr_len equ $ - greetstr

; }}}

section .bss
; .bss {{{
gotstr_len equ 1024
gotstr: resb gotstr_len

; }}}
