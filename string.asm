section .data
msg db 'Hello,World!',0xA ;define string with newline character

section .text
global _start

_start:
;write the string to stdout
mov eax, 4 ;sys_write (system call number)
mov ebx, 1 ;file descriptor 1 (stdout)
mov ecx, msg ;memory address of the string
mov edx, 104 ;number of bytes to write
int 0x80 ;call kernel

;exit the program
mov eax,1 ;sts exit (system call number)
xor ebx,ebx ;return code 0
int 0x80 ;call kernel 
