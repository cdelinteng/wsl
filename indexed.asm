section .data
array db 10,20,30,40 ;declare an array in memory
section .text
global _start
_start:
	mov esi, 1 ;index position 1 (second element)
	mov al, [array + esi] ;load value at index 1 into al (Indexed addressing)

	;exit
	mov eax, 1
	int 0x80
