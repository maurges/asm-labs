;; This file defines routines to encrypt file by key

global VigenereCipher

%include "meta.inc"
%include "syscalls.inc"
%include "files.asmh"
%include "terminal.asmh"

section .bss
; bss {{{
pre_key: resb 1024

; }}}

section .text
; text {{{

;; if bl is a letter, return its alphabet position
; ToPosition {{{
defsub ToPosition
	if    bl, ge, 'a'
	andif bl, le, 'z'
	  sub bl, 'a'
	  ret
	elseif bl, ge, 'A'
	andif  bl , le, 'Z'
	  sub bl, 'A'
	  ret
	else
	  die "Not an an alphabetic symbol in ToPosition"
	endif
endsub
; }}}

;; if al is letter, return its alphabet position
;; and set rdx to 1 if was uppercase
;; if was not letter, set rdx to 2
; ToPositionWithFlag {{{
defsub ToPositionWithFlag
	xor rdx, rdx
	if     al, ge, 'a'
	andif  al, le, 'z'
	  sub al, 'a'
	  ret
	elseif al, ge, 'A'
	andif  al, le, 'Z'
	  sub al, 'A'
	  inc rdx
	  ret
	else
	  inc rdx
	  inc rdx
	  ret
	endif
endsub
; }}}


;; restore letter according to rdx and rax set by ToLower
; RestoreLetter {{{
defsub RestoreLetter
	if rdx, e, 2
	  ret
	elseif rdx, e, 1
	  add al, 'A'
	  ret
	elseif rdx, e, 0
	  add al, 'a'
	  ret
	else
	  die "incorrect parameter passed for RestoreLetter"
	endif
endsub
; }}}


;; accepts one parameter: whether to decrypt the text (1) or encrypt (0)
; VigenereCipher {{{
defun VigenereCipher, decrypt
	push decrypt ;; [rbp - 8] - decrypt
	cld
	;; open files

	defstr .src_file, "source.txt", 0
	sys_open .src_file, FlagR
	mov r15, rax ;; r15 - descriptor of read

	defstr .dst_file, "dest.txt", 0
	sys_open .dst_file, FlagW
	mov r14, rax ;; r14 - descriptor of write


	;; get key
	puts "Enter passphrase:", 10
	vcall get_pwd, pre_key, FileMaxsize
	mov r13, rax ;; r13 - size of key

  ; loop_key {{{
	;; leave only alphabetic symbols in key
	mov rsi, pre_key
	mov rdi, utl_text
	mov rcx, r13
  .loop_key:
	lodsb
	call ToPositionWithFlag
	;; if was not letter
	if rdx, e, 2
	  ;; decrease length of key
	  dec r13
	else
	  stosb
	endif
	loop .loop_key

	if r13, e, 0
	  die "Key should contain at least one letter!", 10
	endif
  ; }}}


  ; loop_blocks {{{
  .loop_blocks:
	;; while still something left to read
	sys_read r15, src_text, FileMaxsize
	cmp rax, 0
	je .loop_end

	mov r11, rax ;; save number of bytes read
	mov rcx, rax ;; count by number of bytes read

	mov rsi, src_text
	mov rdi, dst_text
	mov r12, 0

  ; loop_chars {{{
  .loop_chars:
	;; get next text symbol
	lodsb
	call ToPositionWithFlag

	;; skip non-alphabetical symbols
	if rdx, e, 2
	  stosb
	else
	  ;; get next key symbol
	  mov bl, [utl_text + r12]
	  inc r12
	  ;; test if should encrypt or decrypt
	  if [rbp - 8], e, byte 1
	    ;; decrypting
	    add al, 26
	    sub al, bl
	  else
	    ;; encrypting
	    add al, bl
	  endif
	  ;; checking if within modulo 26
	  if al, ge, 26
	    sub al, 26
	  endif
	  ;; restore symbol as letter
	  call RestoreLetter
	  ;; write symbol to ciphertext
	  stosb
	  ;; check if key index is within bounds
	  if r12, ge, r13
	    sub r12, r13
	  endif
	endif

	;; will loop by rcx set above as number of bytes read
	loop .loop_chars
	;; if bytes are done, write them
	sys_write r14, dst_text, r11
	;; and repeat with next chunk
	jmp .loop_blocks
	
  ; }}}
  ; }}}
  ;; goes here after all blocks are done
  .loop_end:
	sys_close r15
	sys_close r14

	return
endfun
; }}}

;}}}
