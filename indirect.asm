section .data
var dd 100 ;store 100 in a memory location
pointer dd var ;store the address of 'var'
section .text
global _start
_start:
	mov esi, [pointer] ;load address of 'var' into esi
	mov eax, [esi] ;load the value stored at 'var' (indirect addressing)

	;exit
	mov eax,1
	int 0x80

