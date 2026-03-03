section .data
msg1 db 'Line with LF', 0x0A, 0 ;\n(standard in Linux)
len1 equ $ - msg1

msg2 db 'Line with CR', 0x0D, 0 ;\r(carriage return only)
len2 equ $ - msg2

msg3 db 'Line with CRLF', 0x0D, 0x0A, 0 ;\r\n(Windows-style newline)
len3 equ $ - msg3

section .text
global _start

_start:
;print msg1
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 0x80

;print msg2
mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 0x80

;print msg3
mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, len3
int 0x80

;Exit
mov eax, 1
xor ebx, ebx
int 0x80

