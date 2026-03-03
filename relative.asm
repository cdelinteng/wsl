section .text

global _start

_start:

mov eax, 5

cmp eax, 5

je label_1 ; Jump if equal (Relative Addressing)


mov eax, 1

int 0x80

label_1:

mov eax, 2

int 0x80
