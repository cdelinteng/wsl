section .data
	prompt db 'Enter a character:' ,0xA, 0
	len1 equ $ - prompt
	uppercase db 'The uppercase character is:' ,0xA, 0
	len2 equ $ - uppercase

section .bss
	inputchar resb  2

section .text
	global _start

_start:
	;print prompt
	mov eax,4
	mov ebx,1
	mov ecx,prompt
	mov edx,len1
	int 0x80

	;read char
	mov eax,3
	mov ebx,0
	mov ecx,inputchar
	mov edx,2
	int 0x80

	;convert to uppercase if it is a lowercase letter
	mov al, [inputchar] 	;load the char into AL
	cmp al, 'a'		;compare with 'a'
	jb print_char		;jump if below (not a lowercase letter) (print_char is variable)
	cmp al, 'z'		;compare with 'z'
	ja print_char		;jump if above (not a lowercase letter)
	sub al,32		;convert to uppercase (ASCII difference between 'a' and 'A')
	mov [inputchar], al

print_char:
	;print result prompt
	mov eax, 4
	mov ebx, 1
	mov ecx, uppercase
	mov edx, len2
	int 0x80

	;print char
	mov eax, 4
	mov ebx, 1
	mov ecx, inputchar
	mov edx, 2
	int 0x80

	;exit
	mov eax, 1
	xor ebx, ebx
	int 0x80
