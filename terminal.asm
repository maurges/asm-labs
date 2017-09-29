;; This module exprots subroutines to change terminal behavior to quickly get
;; characters, and one to get that character

global set_term_await
global restore_term_setting
global getch
global get_star
global backspace
global get_pwd


%include "meta.inc"
%include "syscalls.inc"

section .bss
; bss {{{

;; copy of c's termios structure as found in my /usr/include/bits/termios.h
; termios {{{
struc Termios
  .c_iflag:	resd 1
  .c_oflag:	resd 1
  .c_cflag:	resd 1
  .c_lflag:	resd 1
  .c_line:	resb 1
  .c_cc:  	resb 32
  .c_ispeed:	resd 1
  .c_ospeed:	resd 1
  .size:
endstruc
; }}}


;; memory used by some subroutines
; reserved {{{
original_termios:
	resb Termios.size
copy_termios:
	resb Termios.size
chr:
; }}}

; }}}

section .data
; data {{{

;; used to get password symbols
asterisc:
	db "*"

bs_symbols:
	db 8, ' ', 8

; }}}

section .text
; text {{{

;; sets terminal to a mode where it sends one symbol right after it's typed
; set_term_await {{{
defsub set_term_await
	save_all

	;; fetch current terminal settings

	;; TCGETS for stdin, write to original_termios
	sys_ioctl 0, 21505, original_termios
	;; fetch a copy to make changes in to
	sys_ioctl 0, 21505, copy_termios

	;; change settings
	
	;; &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR | IGNCR | ICRNL | IXON)
	and dword [copy_termios + Termios.c_iflag], -1516
	;; &= ~OPOST
	and dword [copy_termios + Termios.c_oflag], -2
	;; &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN)
	and dword [copy_termios + Termios.c_lflag], -32844
	;; &= ~(CSIZE | PARENB)
	and dword [copy_termios + Termios.c_cflag], -305     
	;; &= CS8
	or  dword [copy_termios + Termios.c_cflag], 48        

	;; set the settings we've changed

	;; TCSETS for stdin from copy_termios
	sys_ioctl 0, 21506, copy_termios

	restore_all
endsub
; }}}


;; restores the settings we mixed up with the above subroutine
; restore_term_setting {{{
defsub restore_term_setting
	push_regs rax, rcx, rdx, rsi, rdi, r8, r9, r10, r11
	;; ONLY CALL AFTER set_term_await! Undefined behavior otherwise
	;; simpy set the settings we stored before

	sys_ioctl 0, 21506, original_termios
	restore_all
endsub
; }}}


;; get one character from terminal; returns 255 for EOF
;; *al* - character read
; getch {{{
defsub getch
	save_all
	;; reads from stdin into chr one character
	sys_read 0, chr, 1
	;;put 255 if end of file reached
	if rax, e, 0
	  mov [chr], byte 255
	endif
	restore_all
	mov al, [chr]
endsub
; }}}


;; get one symbol and print asterisc instead of it
;; to be used when terminal is set to immediately send symbols
;; *al* - character read
; get_star {{{
defsub get_star
	save_all
	sys_read 0, chr, 1
	sys_write 1, asterisc, 1
	restore_all
	mov al, [chr]
endsub
; }}}


;; deletes one character from output
; backspace {{{
defsub backspace
	save_all
	sys_write 1, bs_symbols, 3
	restore_all
endsub
; }}}


;; reads N or until newline/eof characters from stream to address and prints asteriscs
;; returns: rax - number of bytes read
; get_pwd {{{
defun get_pwd, ADDR, N
;;             rdi  rsi

	;; exit if N == 0
	if N, e, 0
	  xor rax, rax
	  return
	endif

	;; setterminal to get symbols at once
	call set_term_await

	;; save initial address to compare when deleting
	mov r15, ADDR
.loop_start:
	call getch

	if al, e, 127
	  ;; delete symbol if was backspace
	  ;; do nothing if there are no symbols
	  cmp ADDR, r15
	  je .loop_start
	  ;; backspace and position at previous symbol
	  call backspace
	  dec ADDR
	  jmp .loop_start
	endif

	; exits {{{
	if   al, e, 10
	orif al, e, 13
	orif al, e, 0
	orif al, e, 255
	orif al, e, 4
	then
	  jmp .return
	endif
	; }}}

	;; write to ADDR otherwise
	stosb
	dec N
	;; and print asterisc
	push_regs rax, rdi, rsi
	sys_write 1, asterisc, 1
	pop_regs rax, rdi, rsi

	;; exit if read all bytes
	cmp N, 0
	je .return

	jmp .loop_start


.return:
	;; restore settings we set at the beginning
	call restore_term_setting

	;; put bytes read to rax
	mov rax, ADDR
	sub rax, r15
	push rax
	;; set counter in rcx and save it
	mov rcx, rax
	push rcx

	;; clear screen from asteriscs
	;; position at start of line
	mov [chr], byte 13
	sys_write 1, chr, 1
	;; type spaces for all symbols entered
	mov [chr], byte ' '
	;; restore counter set previuosly
	pop rcx
.spaces:	push rcx
	sys_write 1, chr, 1
	pop rcx
	loop .spaces
	;; and position at start of line once more
	mov [chr], byte 13
	sys_write 1, chr, 1

	pop rax
	return
endfun
; }}}

; }}}
