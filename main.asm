%include "meta.inc"
%include "syscalls.inc"

%include "terminal.asmh"
%include "vigenere/main.asmh"
%include "strstr/main.asmh"
%include "lfsr/main.asmh"

extern printf

global main


section .text
; text {{{

main:

%define PROGRAM_BEHAVIOR 'lfsr'

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
	dec rax
	mov [haystack + rax], byte 0
	;; save haystack length
	mov r15, rax

	puts "input needle: "
	sys_read 0, needle, 1023
	dec rax
	mov [needle + rax], byte 0

	vcall StrStr, haystack, needle

	if rax, e, -1
	  puts "not found", 10
	  sys_exit 0
	endif

	mov r14, rax

	puts "found at: ", 10
	sys_write 1, haystack, r15
	puts 10
	mov rcx, r14
	;; KOSTYL
	if r14, e, 0
	  puts "^", 10
	  sys_exit 0
	endif
.spacesloop:
	mov r14, rcx
	puts " "
	mov rcx, r14
	loop .spacesloop
	puts "^", 10

	sys_exit 0
 ; }}}
 %elifidn PROGRAM_BEHAVIOR, 'lfsr'
 ; strstr {{{
	vcall set_length, 16
	vcall add_tap, 0
	vcall add_tap, 2
	vcall add_tap, 3
	vcall add_tap, 5
	mov rbx, 0xace1
	vcall set_base_lfsr, rbx
	mov rcx, 0
.loop:	push rbx
	push rcx
	call lfsr_next
	pop rcx
	pop rbx
	inc rcx
	cmp rbx, rax
	jne .loop
	vcall printf, format, rcx
	sys_exit 0
 ; }}}
 %endif
 %endif

; }}}

section .data
; data {{{
format:	db "%d\n"
; }}}

section .bss
; bss {{{
haystack: resb 1024
needle:   resb 1024

; }}}

;; vim: filetype=nasm
