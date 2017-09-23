;; This module exprots subroutines to change terminal behavior to quickly get
;; characters, and one to get that character

global set_term_await
global restore_term_setting
global getch


%include "meta.inc"
%include "syscalls.inc"

section .bss

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

original_termios:
	resb Termios.size
copy_termios:
	resb Termios.size
chr:

section .data

;; create two copies of termios needed to set and reset term options
;; deleted for now as i just reserved them before
; termios instanses {{{
;original_termios:
;  istruc Termios
;    at .c_iflag,  dd 0
;    at .c_oflag,  dd 0
;    at .c_cflag,  dd 0
;    at .c_lflag,  dd 0
;    at .c_line,   db 0
;    at .c_cc,     db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
;                  db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
;    at .c_ispeed, dd 0
;    at .c_ospeed, dd 0
;  iend
;copy_termios:
;  istruc Termios
;    at .c_iflag,  dd 0
;    at .c_oflag,  dd 0
;    at .c_cflag,  dd 0
;    at .c_lflag,  dd 0
;    at .c_line,   db 0
;    at .c_cc,     db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
;                  db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
;    at .c_ispeed, dd 0
;    at .c_ospeed, dd 0
;  iend
; }}}


section .text

;; sets terminal to a mode where it sends one symbol right after it's typed
; set_term_await {{{
defsub set_term_await

	;; fetch current terminal settings

	;; TCGETS for stdin, write to original_termios
	sys_call sys_ioctl, 0, 21505, original_termios
	;; fetch a copy to make changes in to
	sys_call sys_ioctl, 0, 21505, copy_termios

	;; change settings
	
	;; &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR | IGNCR | ICRNL | IXON)
	and [copy_termios + Termios.c_iflag], -1516
	;; &= ~OPOST
	and [copy_termios + Termios.c_oflag], -2
	;; &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN)
	and [copy_termios + Termios.c_lflag], -32844
	;; &= ~(CSIZE | PARENB)
	and dword [copy_termios + Termios.c_cflag], -305     
	;; &= CS8
	or  dword [copy_termios + Termios.c_cflag], 48        

	;; set the settings we've changed

	;; TCSETS for stdin from copy_termios
	sys_call sys_ioctl, 0, 21506, copy_termios

endsub
; }}}


;; restores the settings we mixed up with the above subroutine
; restore_term_setting {{{
defsub restore_term_setting
	;; ONLY CALL AFTER set_term_await! Undefined behavior otherwise
	;; simpy set the settings we stored before

	sys_call sys_ioctl, 0, 21506, original_termios
endsub
; }}}


;; get one character from terminal
;; *al* - character read
; getch {{{
defsub getch
	;; reads from stdin into chr one character
	syscall sys_read, 0, chr, 1
	mov al, [chr]
endsub
; }}}
