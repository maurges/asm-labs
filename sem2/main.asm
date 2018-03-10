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

	push 0 ;; flags
	push gotstr_len
	push gotstr
	push dword [ebp-8]

	mov eax, 0x66
	mov ebx, 10 ;; sys_recv
	mov ecx, esp
	int 0x80

	push 0 ;; flags
	push greetstr_len
	push greetstr
	push dword [ebp-8] ;; sockfd

	mov eax, 0x66 ;; sys_socketcall
	mov ebx, 9    ;; sys_send
	mov ecx, esp
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
