section .data
	star db '*', 0
	space db ' ', 0

section .text
	global _start
print_triangle:
mov byte [row], 0

triangle_print_row:
; Calculate spaces = width - row - 1
mov al, 4
sub al, [row]
dec al
mov [spaces_count], al

; Print leading spaces
cmp byte [spaces_count], 0
jle print_stars_loop

print_spaces_loop:
mov eax, 4
mov ebx, 1
mov ecx, space
mov edx, 1
int 0x80
dec byte [spaces_count]
jnz print_spaces_loop

; Print stars (2*row + 1)
print_stars_loop:
mov al, [row]
shl al, 1      ; Multiply by 2
inc al         ; Add 1
mov [star_count], al

print_star:
mov eax, 4
mov ebx, 1
mov ecx, star
mov edx, 1
int 0x80
dec byte [star_count]
jnz print_star

call print_newline

inc byte [row]
cmp byte [row], 4
jl triangle_print_row
ret

