%include "meta.inc"
%include "syscalls.inc"

%include "terminal.asmh"
%include "vigenere/main.asmh"

global _start


section .text
; text {{{

_start:

	puts "Encrypt or decrypt? e/d > "
  .loop:
  	call getch
  	;; get CR symbol
  	push rax
  	call getch
  	pop rax

  	if     rax, e, 'e'
  	orif   rax, e, 'E'
  	then
  	  mov r15, 0
  	  jmp .endloop
  	endif

  	if rax, e, 'd'
  	orif   rax, e, 'D'
  	then
  	  mov r15, 1
  	  jmp .endloop
  	endif

  	puts "Please answer E or D! > "
  	jmp .loop

  .endloop:

	puts "Processing file source.txt...", 10
	vcall VigenereCipher, r15
	puts "Done. Written to dest.txt", 10

	sys_exit 0

; }}}

section .data
; data {{{
; }}}
