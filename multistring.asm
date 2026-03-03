section .data 
    msg1 db 'Hello, World!', 0xA   ; first string 
    msg2 db 'Welcome to NASM programming!', 0xA  ; second string 

section .text 
global _start 

 
_start: 
    ; write the first string to stdout 
    mov eax, 4           ; sys_write (system call number) 
    mov ebx, 1           ; file descriptor 1 (stdout) 
    mov ecx, msg1        ; memory address of the first string 
    mov edx, 14          ; number of bytes for the first string 
    int 0x80             ; call kernel

 

    ; write the second string to stdout 
    mov eax, 4           ; sys_write (system call number) 
    mov ebx, 1           ; file descriptor 1 (stdout) 
    mov ecx, msg2        ; memory address of the second string 
    mov edx, 30          ; number of bytes for the second string 
    int 0x80             ; call kernel

    ; exit the program
    mov eax, 1           ; sys_exit (system call number)
    xor ebx, ebx         ; return code 0
    int 0x80             ; call kernel
