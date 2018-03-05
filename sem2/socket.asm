;; functions to create and used TCP sockets, thin-wrappers against the syscall
;; all cdecl so can be used from C

;; vim: filetype=nasm

global TCPSocketNewBind
global TCPSocketClose

section .text
; .text {{{

; TCPSocketNewBind {{{
;; subroutine
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
	mov ebx, 4    ;; sys_getsockopt
	mov ecx, esp  ;; function args
	int 0x80

	mov esp, ebp

	;; bind the socket with the address type

	;; build the sockaddr_in type
	push 0           ;; INADDR_ANY = 0 (uint32_t)
	push word 0x672b ;; port in byte reverse order = 11111 (uint16_t)
	push word 2      ;; AF_INET = 2 (unsigned short int)
	mov esi, esp     ;; save the struct pointer
	;; arguments for bind
	push 16  ;; sockaddr struct size
	push esi ;; sockaddr_in struct pointer
	push edx ;; socket fd

	mov eax, 0x66 ;; sys_socketcall
	mov ebx, 2    ;; sys_bind
	mov ecx, esp  ;; function args
	int 0x80

	;; return the socket fd
	mov eax, edx
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
