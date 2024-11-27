section .data
    prompt db "Enter a number: ", 0
    pos_msg db "The number is POSITIVE.", 10, 0
    neg_msg db "The number is NEGATIVE.", 10, 0
    zero_msg db "The number is ZERO.", 10, 0

section .bss
    input resb 10                ; Reserve space for input string

section .text
    global _start

_start:
    ; Print prompt message
    mov rax, 1                  ; syscall: write
    mov rdi, 1                  ; file descriptor: stdout
    mov rsi, prompt
    mov rdx, 17                 ; length of the prompt message
    syscall

    ; Read input from user
    mov rax, 0                  ; syscall: read
    mov rdi, 0                  ; file descriptor: stdin
    mov rsi, input              ; buffer to store input
    mov rdx, 10                 ; number of bytes to read
    syscall

    ; Convert input string to integer
    mov rax, 0                  ; Clear RAX for conversion
    mov rbx, 10                 ; Base 10
    mov rcx, input              ; Pointer to the input buffer

.convert_loop:
    movzx rdx, byte [rcx]       ; Load next byte
    cmp rdx, 10                 ; Check for newline character
    je .done_convert             ; If newline, we're done
    sub rdx, '0'                ; Convert ASCII to integer
    imul rax, rbx               ; Multiply RAX by 10
    add rax, rdx                ; Add the new digit
    inc rcx                     ; Move to the next character
    jmp .convert_loop

.done_convert:
    ; Check if the number is positive, negative, or zero
    cmp rax, 0                  ; Compare with zero
    jg .positive                 ; If greater than zero, jump to positive
    jl .negative                 ; If less than zero, jump to negative

.zero:
    ; Print zero message
    mov rax, 1                  ; syscall: write
    mov rdi, 1                  ; file descriptor: stdout
    mov rsi, zero_msg
    mov rdx, 23                 ; length of the zero message
    syscall
    jmp .exit

.positive:
    ; Print positive message
    mov rax, 1                  ; syscall: write
    mov rdi, 1                  ; file descriptor: stdout
    mov rsi, pos_msg
    mov rdx, 27                 ; length of the positive message
    syscall
    jmp .exit

.negative:
    ; Print negative message
    mov rax, 1                  ; syscall: write
    mov rdi, 1                  ; file descriptor: stdout
    mov rsi, neg_msg
    mov rdx, 27                 ; length of the negative message
    syscall

.exit:
    ; Exit program
    mov rax, 60                 ; syscall: exit
    xor rdi, rdi                ; status: 0
    syscall
