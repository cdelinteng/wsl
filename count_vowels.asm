section .data
	prompt db ‘Enter a string: ', 0xA ,0
	len_prompt equ $ - prompt
	result db 'Enter of vowels: ', 0xA, 0
	len_result equ $ - result
	newline db 0xA, 0

section .bss
	input_str resb 100	;buffer for input
	vowel_count resb 2

section .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, len_prompt
	int 0x80

	mov eax, 3
	mov ebx, 0
	mov ecx, input_str
	mov edx, 100
	int 0x80

	;eax now holds number of bytes read
	mov esi, eax			;store input length in esi
	mov edi, 0			;char index=0
	mov byte [vowel_count], 0	;initialize count to 0

count_loop:
	cmp edi, esi
	jge print_result

	mov al, [input_str + edi]

	;check is char is a vowel
	cmp al, 'a'
	je increment_count
	cmp al, 'e'
	je increment_count
	cmp al, 'i'
	je increment_count
	cmp al 'o'
	je increment_count
	cmp al 'u'
	je increment_count

	;not vowel, move to next char
	inc edi
	jmp count_loop

increment_count:
	mov al, [vowel_count]
	inc al
	mov [vowel_count], al
	inc edi
	jmp count_loop

print_result:
	;convert binary count to ASCII
	mov al, [vowel_count]
    	add al, '0'
	mov [vowel_count], al

	; print result message
	mov eax, 4
    	mov ebx, 1
    	mov ecx, result_msg
	mov edx, 20
	int 0x80

   	; print vowel count
	mov eax, 4
	mov ebx, 1
	mov ecx, vowel_count
	mov edx, 1
	int 0x80

	; print newline
	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
	int 0x80

  	; exit program
	mov eax, 1
	xor ebx, ebx
	int 0x80

