%include "socket.asmh"
;; vim: ft=nasm

global main
extern printf
extern fprintf
extern fflush

section .text
; text {{{

; main {{{
main:
	mov ebp, esp
	sub esp, 8 ;; two values: two sockfd

	push word 0x3905
	call TCPSocketNewBind
	mov [ebp-4], eax
	add esp, 4

.loop_accept:
	push dword [ebp-4]
	call TCPSocketAccept
	mov [ebp-8], eax
	add esp, 4

	;; fork and go
	mov eax, 2
	int 0x80
	cmp eax, 0
	jne .loop_accept

	;; forked:
	;; go read from new one
	push dword [ebp-8]
	call loopread
	add esp, 4

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

	;; overwrite stdin and stdout with sockfd
	mov eax, 0x3f    ;; sys_dup2
	mov ebx, [ebp+12] ;; sockfd
	mov ecx, 0       ;; stdin
	int 0x80
	mov eax, 0x3f    ;; sys_dup2
	mov ebx, [ebp+12] ;; sockfd
	mov ecx, 1       ;; stdout
	int 0x80

	sub esp, 256 ;; buffer of 256 symbols
	mov edi, esp

.loop:	;; try to read
	mov eax, 3
	mov ebx, 0
	mov ecx, edi
	mov edx, 256
	int 0x80
	mov [edi+eax], byte 0

	test eax, eax
	jz .end
	
	push edi
	call printf
	push dword 0
	call fflush
	add esp, 8

	jmp .loop

.end:	;; close socket
	push dword 0
	call TCPSocketClose
	push dword 1
	call TCPSocketClose
	push dword 2
	call TCPSocketClose
	add esp, 12

	mov esp, ebp
	pop ebx
	pop ebp
	ret
	
; }}}

; }}}

section .data
; data {{{
greetstr: db "go away",10,0
greetstr_len equ $ - greetstr

; }}}

section .bss
; .bss {{{
gotstr_len equ 1024
gotstr: resb gotstr_len

; }}}
