section .data
msg1 db 'Hello, World!', 0xA
len1 equ $ - msg1

msg2 db 'Welcome to NASM programming!', 0xA
len2 equ $ - msg2

section .text
global _start

_start:
    ; Print msg1
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ; Print msg2
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    ; Print msg1 again
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ; Print msg2 again
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

