section .data
	menu db 'Main Menu:', 0xA, 0
	db '1. Display a Greeting Message!', 0xA, 0
	db '2. NASM Assembly is Fun!', 0xA, 0
	db '3. Learning Assembly Step by Step!', 0xA, 0
	db '4. Exit', 0xA, 0
	db 'Enter your choice:', 0xA, 0
	menu_len equ $ - menu

	msg1 db 'Hello, Welcome to NASM Programming!', 0xA, 0
	msg1_len equ $ - msg1

	msg2 db 'NASM Assembly is Fun!', 0xA, 0
	msg2_len equ $ - msg2

	msg3 db 'Learning Assembly Step by Step!', 0xA, 0
	msg3_len equ $ - msg3

	invalid_msg db 'Invalid input! Please enter a number between 1 and 4.'. 0xA, 0
	invalid_msg_len equ $ - invalid_msg

section .bss
	choice resb 2

section .text
	global _start

_start:
	;print main menu
	mov eax, 4
	mov ebx, 1
	mov ecx, menu
	mov edx, menu_len
	int 0x80

get_input:
	mov eax, 3
	mov ebx, 0
	mov ecx, choice
	mov edx, 2
	int 0x80

	cmp byte [choice], '1'
	jb invalid_input
	cmp byte [choice], '4'
	ja invalid_input

	cmp byte [choice], '1'
	je option1
	cmp byte [choice], '2'
	je option2
	cmp byte [choice], '3'
	je option3
	cmp byte [choice], '4'
	je option4

invalid_input:
	mov eax, 4
	mov ebx, 1
	mov ecx, invalid_msg
	mov edx, invalid_msg_len
	int 0x80
	jmp _start

option1:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, msg1_len
	int 0x80
	jmp _start

option2:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, msg2_len
	int 0x80
	jmp _start
option3:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, msg3_len
	int 0x80
	jmp _start

option4:
	;exit
	mov eax, 1
	xor ebx, ebx
	int 0x80

