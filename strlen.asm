section .data
    msg1 db 'Hello, World!', 0xA
    len1 equ $ - msg1

    msg2 db 'Welcome to NASM programming', 0xA
    len2 equ $ - msg2

    len_msg1 db 'Length of msg1: ', 0
    len_msg2 db 'Length of msg2: ', 0

section .bss
    buf resb 5 ; 4 digits max + newline

section .text
    global _start

_start:
    ; Print "Length of msg1: "
    mov eax, 4
    mov ebx, 1
    mov ecx, len_msg1
    mov edx, 17
    int 0x80

    ; Print length of msg1
    mov eax, len1
    call int_to_str
    call print_buf

    ; Print msg1
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ; Print "Length of msg2: "
    mov eax, 4
    mov ebx, 1
    mov ecx, len_msg2
    mov edx, 17
    int 0x80

    ; Print length of msg2
    mov eax, len2
    call int_to_str
    call print_buf

    ; Print msg2
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80


; Converts number in EAX to string in BUF
int_to_str:
    mov ecx, buf + 4        ; Point to last byte
    mov byte [ecx], 0xA     ; Store newline
    dec ecx

    mov ebx, 10
.next_digit:
    xor edx, edx
    div ebx                 ; EAX / 10
    add dl, '0'             ; convert digit to ASCII
    mov [ecx], dl
    dec ecx
    test eax, eax
    jnz .next_digit

    inc ecx                 ; point to first digit
    mov esi, ecx            ; save pointer to buffer start
    ret

; Prints the string pointed to by ESI
print_buf:
    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    mov edx, 0
.count:
    cmp byte [ecx + edx], 0xA
    je .done
    inc edx
    jmp .count
.done:
    inc edx
    int 0x80
    ret

