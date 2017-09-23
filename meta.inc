%ifndef ASM_LAB_META
%define ASM_LAB_META

;; vim: foldmethod=marker


;; a set of macros to quickly put arguments for fastcall
; putargs {{{

%macro putargs 1
	mov rdi, %1
%endmacro

%macro putargs 2
	mov rdi, %1
	mov rsi, %2
%endmacro

%macro putargs 3
	mov rdi, %1
	mov rsi, %2
	mov rdx, %3
%endmacro

%macro putargs 4
	mov rdi, %1
	mov rsi, %2
	mov rdx, %3
	mov rcx, %4
%endmacro

%macro putargs 5
	mov rdi, %1
	mov rsi, %2
	mov rdx, %3
	mov rcx, %4
	mov r8, %5
%endmacro

%macro putargs 6
	mov rdi, %1
	mov rsi, %2
	mov rdx, %3
	mov rcx, %4
	mov r8, %5
	mov r9, %6
%endmacro

;; }}}


;; macros to put arguments for syscalls
; syscallargs {{{

%macro syscallargs 1
	mov rdi, %1
%endmacro

%macro syscallargs 2
	mov rdi, %1
	mov rsi, %2
%endmacro

%macro syscallargs 3
	mov rdi, %1
	mov rsi, %2
	mov rdx, %3
%endmacro

%macro syscallargs 4
	mov rdi, %1
	mov rsi, %2
	mov rdx, %3
	mov r10, %4
%endmacro

%macro syscallargs 5
	mov rdi, %1
	mov rsi, %2
	mov rdx, %3
	mov r10, %4
	mov r8,  %5
%endmacro

%macro syscallargs 6
	mov rdi, %1
	mov rsi, %2
	mov rdx, %3
	mov r10, %4
	mov r8,  %5
	mov r9,  %6
%endmacro

;; }}}


;; macros to call functions and syscalls
; calls {{{

%macro sys_call 2+
	mov rax, %1
	syscallargs %2
	syscall
%endmacro


%macro vcall 2+
	putargs %2
	call %1
%endmacro

; }}}


;; macros to define functions with named parameters
; defun {{{

;; define subroutine: function without parameters and stackframe
%macro defsub 1
	%push %1
    %1:
%endmacro
%macro endsub 0
	%pop
%endmacro

%macro defun 2
	%push %1
	%define %2 rdi
     %1:
	push rbp
	mov rbp, rsp
%endmacro

%macro defun 3
	%push %1
	%define %2 rdi
	%define %3 rsi
     %1:
	push rbp
	mov rbp, rsp
%endmacro

%macro defun 4
	%push %1
	%assign %2 rdi
	%assign %3 rsi
	%assign %4 rdx
     %1:
	push rbp
	mov rbp, rsp
%endmacro

%macro defun 5
	%push %1
	%assign %2 rdi
	%assign %3 rsi
	%assign %4 rdx
	%assign %5 rcx
     %1:
	push rbp
	mov rbp, rsp
%endmacro

%macro defun 6
	%push %1
	%assign %2 rdi
	%assign %3 rsi
	%assign %4 rdx
	%assign %5 rcx
	%assign %6 r8
     %1:
	push rbp
	mov rbp, rsp
%endmacro

%macro defun 7
	%push %1
	%assign %2 rdi
	%assign %3 rsi
	%assign %4 rdx
	%assign %5 rcx
	%assign %6 r8
	%assign %7 r9
     %1:
	push rbp
	mov rbp, rsp
%endmacro

; }}}


;; ending function definition

%macro endfun 0
	%pop
%endmacro


;; returning from function
; return {{{

%macro return 0
	pop rbp
	ret
%endmacro

%macro return 1
	mov rax, %1
	pop rbp
	ret
%endmacro

; }}}


%endif
