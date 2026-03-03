section .data
	msg db 'Data Movement Example', 0xA 

section .bss
	buffer resb 10

section .text
	global _start

_start:
	;move an immediate value to a register
	mov eax, 5	;eax register now holds value 5

	;mov data between registers
	mov ebx, eax

	;move a value to memory
	mov [buffer], ebx

	;move a value from memory to a register
	mov ecx, [buffer]

	;move a string from memory to the screen (syscall to print)
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, 30
	int 0x80

	;exit
	mov eax, 1
	mov ebx, 0
	int 0x80

