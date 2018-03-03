;; This file has subroutines to initialize random generator and generate
;; numbers with lfsr-generator

;; vim: filetype=nasm

global add_tap
global set_length
global set_base_lfsr
global lfsr_next


%include "meta.inc"
%include "syscalls.inc"


section .bss
; bss {{{
taps:
	resb 64

; }}}

section .data
; data {{{
taps_amount:
	db 0
current_lfsr:
	dq 0
length:
	db 0

; }}}


section .text
; .text {{{

; add_tap {{{
defun add_tap, pos
;;             rdi
	xor rsi, rsi
	mov sil, [taps_amount]
	mov [taps + rsi], dil
	inc rsi
	mov [taps_amount], sil
	return
endfun
; }}}


; set_length {{{
defun set_length, len
;;                rdi
	mov [length], dil
	return
endfun
; }}}


; set_base_lfsr {{{
defun set_base_lfsr, value
	mov [current_lfsr], value
	return
endfun
; }}}


; lfsr_next {{{
defsub lfsr_next
	push rbp
	mov rbp, rsp
	push_regs rbx, rcx, rdx, r8, r9, r10, r11, r12, r13, r14, r15
	;; put current lfsr value to quick access
	mov rax, [current_lfsr]
	;; prepare the bit
	xor r8, r8
	;; set r14 to be out shift amount
	xor r14,  r14
	mov r14b, [length]
	dec r14
	;; set r15 to be a bit mask for our length
	mov r15, 1
	push rcx
	mov rcx, r14
	shl r15, cl
	pop rcx
	dec r15

	;; start the taps cycle
	mov rsi, taps
	xor rcx, rcx
	mov cl, [taps_amount]
.taps_cycle:
	;; current tap index
	xor r9,  r9
	mov r9b, [rsi]
	;; create bit
	mov r10,  rax
	push rcx
	mov rcx,  r9
	shr r10,  cl
	pop rcx
	and r10b, 1
	;; applyt bit
	xor r8b, r10b
	;; go to next
	inc  rsi
	loop .taps_cycle

	;; add bit to lfsr
	shr rax, 1
	push rcx
	mov rcx, r14
	shl r8,  cl
	pop rcx
	or rax,  r8
	mov [current_lfsr], rax
	pop_regs rbx, rcx, rdx, r8, r9, r10, r11, r12, r13, r14, r15
	return [current_lfsr]
endsub
; }}}

; }}}
