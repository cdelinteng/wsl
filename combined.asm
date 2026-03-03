section .data
combined db 'Hello, World!' , 0xA, 'Welcome to NASM programming!', 0xA
combined_len equ $ - combined

section .bss
section .text
global _start

_start:
;print combined msg
mov eax, 4
mov ebx, 1
mov ecx, combined
mov edx, combined_len
int 0x80

;exit
mov eax,1
xor ebx, ebx
int 0x80


