Osection .text
global _start
_start:
	mov eax, 10 ;store 10 directly in eax (Immediate Addressing)
	mov ebx, 20 ;store 20 in ebx
	add eax, ebx ;add 20 to 10

	;exit
	mov eax, 1
	int 0x80
