;; This file contains function to determine the position the substring
;; has in haystack

global StrStr

%include "meta.inc"
%include "syscalls.inc"

section .text
; text {{{

;; Takes two null-terminated strings
;; Returns index of the first symbol of second string in first
; StrStr {{{
defun StrStr, haystack, needle
;;               rdi     rsi
	push_regs r15, r14, r13, r12

	;; remember the start of haystack and needle
	mov r15, haystack
	mov r14, needle

	;; put the largest number to rcx so it won't stop my loops
	xor rcx, rcx
	dec rcx
	;; replace the null-terminator of haystack with 255
	;; so that the rep in loop dows not exit the bounds of strings
	xor al, al
	repne scasb
	;; remember the place of it
	mov r12, haystack
	;; and place 255 there
	mov [r12], byte 255

	;; remember current position of haystack
	mov r13, r15

.loop:
	mov  haystack, r13
	mov  needle,   r14
	repe cmpsb
	dec rsi
	dec rdi
	;; if stopped on needle ending
	cmp [needle], byte 0
	je .found
	;; if haystack ended
	cmp [haystack], byte 255
	je .not_found
	;; move to next position in haystack
	inc r13
	jmp .loop
.found:
	;; restore null-terminator in haystack
	mov [r12], byte 0

	;; put index to rax
	mov rax, r13
	sub rax, r15

	pop_regs r15, r14, r13, r12
	return

.not_found:
	;; restore null-terminator in haystack
	mov [r12], byte 0

	;; put not_found to rax
	mov rax, -1
	pop_regs r15, r14, r13, r12
	return
endfun
; }}}

; }}}
