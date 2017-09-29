section .text

;; if al is letter, return its alphabet position
;; and set rdx to 1 if was uppercase
;; if was not letter, set rdx to 2
; ToLower {{{
defsub ToPosition
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


; VigenereMain {{{
defsub VigenereCipher
	defstr src_file, "source.txt"
	sys_open src_file, FlagR
	mov r15, rax ;; r15 - descriptor of read

	defstr dst_file, "dest.txt"
	sys_open dst_file, FlagW
	mov r14, rax ;; r14 - descriptor of write

	vcall get_pwd, utl_text, FileMaxsize
	mov r13, rax ;; r13 - size of key
	if r13, e, 0
	  die "Key length mustn't be zero!"
	endif

	cld
  ; loop_blocks {{{
  .loop_blocks:
	;; while still something left to read
	sys_read r15, src_text, FileMaxsize
	cmp rax, 0
	je .loop_end

	mov rcx, rax ;; count by number of bytes read

	mov rsi, src_text
	mov rdi, dst_text
	mov r12, 0

  ; loop_chars {{{
  .loop_chars:
	lodsb
	call ToLower
	;; skip non-alphabetical symbols
	if rdx, e, 2
	  stosb
	  loop .loop_chars
	endif
	
  ; }}}
  ; }}}
	  
endsub
; }}}
