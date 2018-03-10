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

	;; fork and go
	mov eax, 2
	int 0x80
	cmp eax, 0
	je .parent

	push dword [ebp-8]
	call loopread
	jmp .exit

.parent:
	;; wait for children to terminate
	mov eax, 7  ;; sys_waitpid
	mov ebx, -1 ;; all children
	mov ecx, 0  ;; no wstatus
	mov edx, 0  ;; no flags
	int 0x80

	push dword [ebp-4]
	call TCPSocketClose

.exit:	mov eax, 1
	mov ebx, 0
	int 0x80
; }}}

; loopread {{{
;; function loopread ARGS cdecl: sockfd
loopread:
	push ebp
	push ebx
	mov ebp, esp

	sub esp, 256 ;; buffer of 256 symbols

.loop:	;; try to read
	mov eax, 3
	mov ebx, [ebp+12]
	mov ecx, esp
	mov edx, 256
	int 0x80

	test eax, eax
	jz .end

	mov edx, eax ;; length first
	mov eax, 4
	mov ebx, [ebp+12]
	mov ecx, esp
	int 0x80

	jmp .loop

.end:	;; close socket
	push dword [ebp+12]
	call TCPSocketClose

	mov esp, ebp
	pop ebx
	pop ebp
	ret
	
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
