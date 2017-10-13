%include "meta.inc"
%include "syscalls.inc"

%include "terminal.asmh"
%include "vigenere/main.asmh"
%include "strstr/main.asmh"

global _start


section .text
; text {{{

_start:

 %ifndef PROGRAM_BEHAVIOR
   sys_exit 0
 %else
 %ifidn PROGRAM_BEHAVIOR, 'vigenere'
 ; vigenere {{{

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
 %elifidn PROGRAM_BEHAVIOR, 'StrStr'
 ; strstr {{{
	puts "input haystack: "
	sys_read 0, haystack, 1023
	mov [haystack + rax], byte 0
	puts "input needle: "
	sys_read 0, needle, 1023
	mov [needle + rax], byte 0
 ; }}}
 %endif

; }}}

section .data
; data {{{
; }}}

section .bss
; bss {{{
haystack: resb 1024
needle:   resb 1024

; }}}
