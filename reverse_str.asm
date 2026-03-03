section .data
	prompt db 'Enter a string:', 0xA,0
	len_prompt equ $ - prompt
	result_msg db 'Reversed string:', 0xA,0
	len_resultmsg equ $ - result_msg
	newline db 10, 0


section .bss
	input_string resb 100
	string_len resb 2

section .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, len_prompt
	int 0x80

	;read string
	mov eax, 3
	mov ebx, 0
	mov ecx, input_string
	mov edx, 100
	int 0x80

	;find string length
	mov esi, input_string 	;pointer to the string
	xor ecx, ecx		;initialize length counter to 0

find_length:
	cmp byte [esi + ecx], 0 ;check for end of string
	je reverse_string	;if end, jump to reverse
	inc ecx			;increment length counter
	jmp find_length		;repeat loop

reverse_string:
	mov eax, 4
	mov ebx, 1
	mov ecx, result_msg
	mov edx, len_resultmsg
	int 0x80

	mov edi, ecx		;load length of string
	dec edi			;adjust for zero-based index
	mov esi, input_string	;pointer to the string

reverse_loop:
	cmp edi, 0		;check if we reached the start of the string
	jl done_reverse		;if below, jump to done
	mov al, [esi + edi]	;load character from end
	mov [input_string +ecx -1]	;store character in reversed position
	dec edi			;move to previous character
	dec ecx			;adjust length counter
	jmp reverse_loop	;repeat loop

done_reverse:
	;print reversed string
	mov eax, 4
	mov ebx, 1
	mov ecx, input_string
	mov edx, ecx
	int 0x80

	;print newline
	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
	int 0x80

	;exit
	mov eax, 1
	xor ebx, ebx
	int 0x80
