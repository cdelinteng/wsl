section .data 

    msg db 'Enter a number: ', 0 

    loop_msg db 'Loop: ', 0 

    newline db 10, 0           ; newline character 

    buffer db 0                ; buffer for storing user input (one byte) 

  

section .bss 

    counter resb 1             ; Reserve space for counter 

  

section .text 

    global _start 

  

_start: 

    ; Print "Enter a number: " 

    mov eax, 4                 ; syscall number for sys_write 

    mov ebx, 1                 ; file descriptor 1 (stdout) 

    mov ecx, msg               ; memory address of the message 

    mov edx, 17                ; length of the message 

    int 0x80                   ; call the kernel 

  

    ; Read input from the user 

    mov eax, 3                 ; syscall number for sys_read 

    mov ebx, 0                 ; file descriptor 0 (stdin) 

    mov ecx, buffer            ; memory address of the buffer 

    mov edx, 1                 ; length of 1 byte (to read one character) 

    int 0x80                   ; call the kernel 

  

    ; Convert the ASCII input to an integer 

    mov al, [buffer]           ; load the input byte into AL 

    sub al, '0'                ; convert from ASCII to integer 

    mov [counter], al          ; store the integer in counter 

  

loop_start: 

    ; Check if the counter is zero 

    cmp byte [counter], 0 

    je loop_end                ; If zero, jump to loop_end 

  

    ; Print the "Loop: " message 

    mov eax, 4                 ; syscall number for sys_write 

    mov ebx, 1                 ; file descriptor 1 (stdout) 

    mov ecx, loop_msg          ; memory address of the message 

    mov edx, 6                 ; length of the message 

    int 0x80                   ; call the kernel 

  

    ; Print the value of counter (converted to ASCII) 

    mov al, [counter]          ; Load counter value into AL 

    add al, '0'                ; Convert number to ASCII 

    mov [buffer], al           ; store ASCII in buffer 

  

    mov eax, 4                 ; syscall number for sys_write 

    mov ebx, 1                 ; file descriptor 1 (stdout) 

    mov ecx, buffer            ; memory address of the buffer 

    mov edx, 1                 ; length of 1 byte (counter value) 

    int 0x80                   ; call the kernel 

  

    ; Print a newline 

    mov eax, 4                 ; syscall number for sys_write 

    mov ebx, 1                 ; file descriptor 1 (stdout) 

    mov ecx, newline           ; memory address of newline character 

    mov edx, 1                 ; length of 1 byte 

    int 0x80                   ; call the kernel 

  

    ; Decrease the counter 

    sub byte [counter], 1 

    jmp loop_start             ; Jump back to the start of the loop 

  

loop_end: 

    ; Exit the program 

    mov eax, 1                 ; syscall number for sys_exit 

    mov ebx, 0                 ; exit code 0 

    int 0x80                   ; call the kernel 
