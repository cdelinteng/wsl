section .data
	prompt db 'Enter a character:', 0xA,0 
	len1 equ $ - prompt

section .bss
	input_char resb 2 ;one byte for input and another byte for newline (Enter key)

section .text
	global _start

_start:
	;Print prompt
	mov eax, 4 	;syscall number for sys_write
	mov ebx, 1 	; file descriptor 1 (stdout)
	mov ecx, prompt ;memory address of prompt
	mov edx, len1 	;length of prompt
	int 0x80 	;call kernel

;Read Character
	mov eax, 3 		;syscall num for sys_read
	mov ebx, 0		;file descriptor 0 (stdin)
	mov ecx, input_char	;memory address to store input
	mov edx, 2		;number of bytes to read
	int 0x80		;call kernel

;display back
	mov eax, 4
	mov ebx, 1
	mov ecx, input_char
	mov edx, 2
	int 0x80

;exit
	mov eax, 1
	xor ebx, ebx
	int 0x80


