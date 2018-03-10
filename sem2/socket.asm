;; functions to create and used TCP sockets, thin-wrappers against the syscall
;; all cdecl so can be used from C

;; vim: filetype=nasm

global TCPSocketNewBind
global TCPSocketClose
global TCPSocketAccept

section .bss
; .bss {{{

; sockaddr_in {{{
struc sockaddr_in
  .sin_family: resw 1
  .sin_port:   resw 1
  .sin_addr:   resd 1
  .sin_zero:   resb 8
  .size:
endstruc
; }}}

; }}}

section .text
; .text {{{

; TCPSocketNewBind {{{
;; subroutine RETURNS sockfd
TCPSocketNewBind:
	push ebp
	mov ebp, esp

	;; sys_socket arguments:
	push 0 ;; IPPROTO_IP = 0 (int)
	push 1 ;; SOCK_STREAM = 1 (int)
	push 2 ;; AF_INET = 2 (int)

	mov eax, 0x66 ;; sys_socketcall
	mov ebx, 1    ;; sys_socket
	mov ecx, esp  ;; function args
	int 0x80
	;; value returned from syscall is in eax
	;; save it for later
	mov edx, eax

	mov esp, ebp

	;; set sock_reuseaddr to avoid some segfaults when socket is not
	;; ready
	push 4    ;; sizeof socklen_t
	push esp  ;; address of socklen_t - on the stack
	push 2    ;; SO_REUSEADDR = 2
	push 1    ;; SOL_SOCKET = 1
	push edx  ;; sockfd

	mov eax, 0x66 ;; sys_socketcall
	mov ebx, 14    ;; sys_getsockopt
	mov ecx, esp  ;; function args
	int 0x80

	mov esp, ebp

	;; bind the socket with the address type

	;; build the sockaddr_in type
	sub esp, sockaddr_in.size
	mov [esp + sockaddr_in.sin_addr], dword 0
	mov [esp + sockaddr_in.sin_port], word 0xa1ed
	mov [esp + sockaddr_in.sin_family], word 2
	mov [esp + sockaddr_in.sin_zero], dword 0
	mov [esp + sockaddr_in.sin_zero + 4], dword 0
	mov esi, esp     ;; save the struct pointer
	;; arguments for bind
	push sockaddr_in.size
	push esi ;; sockaddr_in struct pointer
	push edx ;; socket fd

	mov eax, 0x66 ;; sys_socketcall
	mov ebx, 2    ;; sys_bind
	mov ecx, esp  ;; function args
	int 0x80

	mov esp, ebp

	;; turn the socket into a listening socket

	push 0   ;; queue size
	push edx ;; socket fd

	mov eax, 0x66 ;; sys_socketcall
	mov ebx, 4    ;; sys_listen
	mov ecx, esp  ;; function args
	int 0x80

	mov esp, ebp

	;; return the socket fd
	mov eax, edx
	mov esp, ebp
	pop ebp
	ret
; }}}

; TCPSocketAccept {{{
;; function TCPSocketAccept ARGS cdecl: sockfd
TCPSocketAccept:
	push ebp
	mov ebp, esp
	;; sockfd
	mov eax, [ebp+8]

	;; call sys_accept
	push 0   ;; structure length
	push 0   ;; no structure (of length above)
	push eax ;; sockfd

	mov eax, 0x66 ;; sys_socketcall
	mov ebx, 5    ;; sys_accept
	mov ecx, esp  ;; function args
	int 0x80

	mov esp, ebp
	pop ebp
	ret
	
; }}}

; TCPSocketClose {{{
;; function TCPSocketClose ARGS cdecl: file_descriptor
TCPSocketClose:
	mov eax, 6         ;; sys_close
	mov ebx, [esp + 4] ;; argument
	int 0x80
	ret
; }}}


; }}}
