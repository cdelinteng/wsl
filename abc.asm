section .data
	msg1 db 'A'
	msg2 db 'B'
	msg3 db 'C'

section .text
global _start
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, 1
	int 0x80

	mov eax, 1
	xor ebx, ebx
	int 0x80
