section .text
global _start
_start:
	mov eax, 5 ;load 5 into eax
	mov ebx, eax ;copy eax to ebx (Register Addressing)
	add ebx, 10 ;modify value in ebx

	;exit
	mov eeax, 1
	int 0x80
