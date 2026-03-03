section .data
; Define the first message with a newline
msg1 db 'Hello, World!', 0xA
len1 equ $ - msg1 ; Calculate length of msg1

; Define the second message with a newline
msg2 db 'Welcome to NASM programming!', 0xA
len2 equ $ - msg2 ; Calculate length of msg2

section .text
global _start ; Tell the linker the entry point

_start:
; Print msg1
mov eax, 4 ; syscall for print, sys_write
mov ebx, 1 ; stdout (screen)
mov ecx, msg1 ; memory address of first message
mov edx, len1 ; length of first message
int 0x80 ; call kernel to print msg1

; Print msg2
mov eax, 4 ; syscall for print, sys_write
mov ebx, 1 ; stdout (screen)
mov ecx, msg2 ; memory address of second message
mov edx, len2 ; length of second message
int 0x80 ; call kernel to print msg2

; Exit the program 
mov eax, 1 ; syscall number for sys_exit
xor ebx, ebx ; exit code = 0
int 0x80 ; call kernel to exit
