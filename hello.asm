section .data
    msg db "Hello, World!", 0xA   ; Message to print (0xA = newline)

section .text
    global _start

_start:
    ; write syscall
    mov rax, 1          ; syscall number for write
    mov rdi, 1          ; file descriptor 1 = stdout
    mov rsi, msg        ; address of the message
    mov rdx, 14         ; number of bytes to write
    syscall

    ; exit syscall
    mov rax, 60         ; syscall number for exit
    xor rdi, rdi        ; exit code 0
    syscall
