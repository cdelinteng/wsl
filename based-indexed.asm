section .data

array db 5, 10, 15, 20 ; Declare an array

section .text

global _start

_start:

mov ebx, array ; Base address of the array

mov esi, 2 ; Offset value (third element)

mov al, [ebx + esi] ; Load value from (Base + Index)


; Exit program

mov eax, 1

int 0x80
