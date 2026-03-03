
section .data
	prompt db 'Please enter a string:' ,0xA, 0
	len1 equ $ - prompt
	display_prompt db 'This is your string:', 0xA, 0
	len2 equ $ - display_prompt


section .bss
	input_str resb 100

section .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, len1
	int 0x80

	;read input
	mov eax, 3
	mov ebx, 0
	mov ecx, input_str
	mov edx, 100
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, display_prompt
	mov edx, len2
	int 0x80

	;print string
	mov eax, 4
	mov ebx, 1
	mov ecx, input_str
	mov edx, 100
	int 0x80

	;exit
	mov eax, 1
	xor ebx, ebx
	int 0x80

