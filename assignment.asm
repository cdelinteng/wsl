section .data
	menu db 'Welcome!' ,0xA
	db '1.Line', 0xA
	db '2.Rectangle', 0xA
	db '3.Circle', 0xA
	db '4.Square', 0xA
	db '5.Triangle', 0xA
	db '6.Exit', 0xA
	db 'Enter your choice:', 0xA
	menu_len equ $ - menu

	;Prompt messages
	length_prompt db 'Enter length (1-9):', 0
	length_prompt_len equ $ - length_prompt
	height_prompt db 'Enter height (1-9):', 0
	height_prompt_len equ $ - height_prompt

	;Error msg
	invalid_choice db 'Invalid choice!', 0xA, 0
	invalid_choice_len equ $ - invalid_choice
	invalid_number db 'Invalid number!', 0xA, 0
	invalid_number_len equ $ - invalid_number

	;Shape char
	star db '*'
	space db ' '
	newline db 0xA

section .bss
	choice resb 2 		;1 byte+enter
	number resb 3
	length resb 1
	height resb 1
	row resb 1
	col resb 1
	star_count resb 1	;count stars per row
	spaces_count resb 1	;count spaces for alignment

section .text
	global _start

_start:
	;print menu
	mov eax, 4
	mov ebx, 1
	mov ecx, menu
	mov edx, menu_len
	int 0x80

	;get choice
	mov eax, 3
	mov ebx, 0
	mov ecx, choice
	mov edx, 2
	int 0x80

	;process choice
	mov al, [choice]
	cmp al, '1'
	je get_line_length		;je = jump if equal
	cmp al, '2'
	je get_rectangle_dimensions
	cmp al, '3'
	je draw_circle
	cmp al, '4'
	je get_square_length
	cmp al, '5'
	je draw_triangle
	cmp al, '6'
	je exit_program

	;invalid
	mov eax, 4
	mov ebx, 1
	mov ecx, invalid_choice
	mov edx, invalid_choice_len
	int 0x80
	jmp _start

get_line_length:
	mov eax, 4
	mov ebx, 1
	mov ecx, length_prompt
	mov edx, length_prompt_len
	int 0x80

	call read_number
	mov [length], al
	jmp draw_line

get_rectangle_dimensions:
	;get length
	mov eax, 4
	mov ebx, 1
	mov ecx, length_prompt
	mov edx, length_prompt_len
	int 0x80

	call read_number
	mov [length], al

	;get height
	mov eax, 4
	mov ebx, 1
	mov ecx, height_prompt
	mov edx, height_prompt_len
	int 0x80

	call read_number
	mov [height], al
	jmp draw_rectangle

get_square_length:
	mov eax, 4
	mov ebx, 1
	mov ecx, length_prompt
	mov edx, length_prompt_len
	int 0x80

	call read_number
	mov [length], al
	mov [height], al
	jmp draw_square

read_number:
	mov eax, 3
	mov ebx, 0
	mov ecx, number
	mov edx, 3
	int 0x80

	mov al, [number]
	cmp al, '1'
	jl .invalid
	cmp al, '9'
	jg .invalid
	sub al, '0' ;convert to number
	ret

.invalid:
	mov eax, 4
	mov ebx, 1
	mov ecx, invalid_number
	mov edx, invalid_number_len
	int 0x80
	jmp read_number

draw_line:
	mov cl, [length]
.line_loop:
	mov eax, 4
	mov ebx, 1
	mov ecx, star
	mov edx, 1
	int 0x80

	dec cl
	jnz .line_loop
	call print_newline
	jmp _start

draw_rectangle:
	mov byte [row], 0
.rect_row_loop:
	mov byte [col], 0
.rect_col_loop:
	;check if border position
	cmp byte [row], 0
	je .print_star
	mov al, [height]
	dec al
	cmp [row], al
	je .print_star
	cmp byte [col], 0
	je .print_star
	mov al, [length]
	dec al
	cmp [col], al
	je .print_star

	;if not on border, print space
	mov eax, 4
	mov ebx, 1
	mov ecx, space
	mov edx, 1
	int 0x80
	jmp .next

.print_star:
	mov eax, 4
	mov ebx, 1
	mov ecx, star
	mov edx, 1
	int 0x80
.next:
	inc byte [col]
	mov al, [length]
	cmp [col], al
	jl .rect_col_loop
	call print_newline
	inc byte [row]
	mov al, [height]
	cmp [row], al
	jl .rect_row_loop
	jmp _start

draw_square:
	mov byte [row], 0
.square_row_loop:
	mov byte [col], 0
.square_col_loop:
	cmp byte [row], 0
	je .print_star
	mov al, [length]
	dec al
	cmp [row], al
	je .print_star
	cmp byte [col], 0
	je .print_star
	mov al, [length]
	dec al
	cmp [col], al
	je .print_star

	;if not on border, print space
	mov eax, 4
	mov ebx, 1
	mov ecx, space
	mov edx, 1
	int 0x80
	jmp .next

.print_star:
	mov eax, 4
	mov ebx, 1
	mov ecx, star
	mov edx, 1
	int 0x80
.next:
	inc byte [col]
	mov al, [length]
	cmp [col], al
	jl .square_col_loop
	call print_newline
	inc byte [row]
	mov al, [length]
	cmp [row], al
	jl .square_row_loop
	jmp _start

draw_triangle:
	mov byte [row], 0
.triangle_loop:
	;calculate spaces (4-row)
	mov al, 4
	sub al, [row]
	mov [spaces_count], al

	;calculate stars (2 x row + 1)
	mov al, [row]
	add al, al		; x2
	inc al			; add 1
	mov [star_count], al

	mov cl, [spaces_count]
	cmp cl, 0
	jle .print_stars 	;skip if no spaces
.print_spaces:
	mov eax, 4
	mov ebx, 1
	mov ecx, space
	mov edx, 1
	int 0x80
	dec cl
	jnz .print_spaces

.print_stars:
	mov cl, [star_count]
.star_loop:
	mov eax, 4
	mov ebx, 1
	mov ecx, star
	mov edx, 1
	int 0x80
	dec cl
	jnz .star_loop

	call print_newline
	inc byte [row]
	cmp byte [row], 5
	jl .triangle_loop
	jmp _start

draw_circle:
	mov byte [row],0
	mov byte [star_count],3
	mov byte [spaces_count],2

.circle_loop:
	;print spaces
	mov cl, [spaces_count]
.print_circle_spaces:
	mov eax, 4
	mov ebx, 1
	mov ecx, space
	mov edx, 1
	int 0x80
	dec cl
	jnz .print_circle_spaces

	;print starts
	mov cl, [star_count]
.print_circle_stars:
	mov eax, 4
	mov ebx, 1
	mov ecx, star
	mov edx, 1
	int 0x80
	dec cl
	jnz .print_circle_stars

	call print_newline

	;Adjust pattern for next row
	cmp byte [row], 1
	jge .bottom_half	;jump if greater or equal

	;Top half (decreasing stars, increasing spaces)
	dec byte [star_count]
	dec byte [star_count]
	inc byte [spaces_count]
	jmp .next_circle_row
.bottom_half:
	;Bottom half (increasing stars, decreasing spaces)
	inc byte [star_count]
	inc byte [star_count]
	dec byte [spaces_count]
.next_circle_row:
	inc byte [row]
	cmp byte [row],5
	jl .circle_loop
	jmp _start

print_newline:
	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
	int 0x80
	ret

exit_program:
	mov eax, 1
	xor ebx, ebx
	int 0x80
