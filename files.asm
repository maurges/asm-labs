;; this modules exports functions and constants to easily manipulate files
;; by reading/writing 1024 bytes of data

global src_text
global dst_text
global utl_text
global FlagR
global FlagW
global FlagRW
global FlagCR
global FileMaxsize


;; flags for file opening
FlagR  equ 0
FlagW  equ 1
FlagRW equ 2
FlagCR equ 100o

FileMaxsize equ 1024


section .bss
; bss {{{
src_text:	resb FileMaxsize
dst_text:	resb FileMaxsize
utl_text: resb FileMaxsize

; }}}
