section .data
var dd 42 ;declare a variable in memory
section .text
global _start
_start:
	mov eax, [var] ;load value from memory location into eax (Direct Addressing)
	mov ebx, eax ;copy the value to another register

	;exit
	mov eax, 1
	int 0x80

