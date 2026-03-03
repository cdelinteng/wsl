section .data
msg db 'A', 0xA, 0 
len equ $ -msg
section .bss


section .text

global _start
_start:
;to print a character
mov eax, 4 ; system call for print, sys_write
mov ebx, 1 ; standard out, (screen)
mov ecx, msg ; memory address of the message.
mov edx, len ; length of the message in bytes.(character + newline)
int 0x80 ; call for kernel

;Exit
mov eax, 1
xor ebx, ebx
int 0x80
