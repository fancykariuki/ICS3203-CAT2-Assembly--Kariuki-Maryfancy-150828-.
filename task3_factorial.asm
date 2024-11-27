section .data
    prompt db "Enter a number: ", 0
    result_msg db "Factorial is: ", 0
    number db 0                  ; Space for the input number
    factorial_result dq 1        ; Space for the factorial result
    input resb 4                 ; Reserve space for user input

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
    mov rdx, 4                  ; number of bytes to read
    syscall

    ; Convert input string to integer
    movzx rax, byte [input]     ; Load the first byte (ASCII)
    sub rax, '0'                ; Convert ASCII to integer
    mov [number], al            ; Store the number

    ; Call the factorial subroutine
    movzx rdi, byte [number]    ; Load number into rdi (0-255)
    call factorial

    ; Store the result in factorial_result
    mov [factorial_result], rax  ; Store the result

    ; Print result message
    mov rax, 1                  ; syscall: write
    mov rdi, 1                  ; file descriptor: stdout
    mov rsi, result_msg
    mov rdx, 15                 ; length of the result message
    syscall

    ; Print the factorial result
    mov rax, [factorial_result]  ; Load the factorial result
    call print_number            ; Call the subroutine to print the number

    ; Exit the program
    mov rax, 60                 ; syscall: exit
    xor rdi, rdi                ; status: 0
    syscall

; Subroutine to calculate factorial
factorial:
    ; Preserve registers on the stack
    push rax                    ; Save rax
    push rdi                    ; Save rdi

    ; Base case: if n <= 1, return 1
    cmp rdi, 1                  ; Compare n with 1
    jle .base_case              ; If n <= 1, jump to base case

    ; Recursive case: n * factorial(n - 1)
    dec rdi                     ; Decrement n
    call factorial              ; Recursive call
    pop rdi                     ; Restore rdi
    pop rax                     ; Restore rax
    mul rdi                     ; Multiply rax (result) by n
    ret

.base_case:
    mov rax, 1                  ; Return 1 for base case
    pop rdi                     ; Restore rdi
    pop rax                     ; Restore rax
    ret

; Subroutine to print a number in rax
print_number:
    ; Convert number in rax to string and print
    ; (This is a simple implementation, could be improved)
    mov rsi, input + 4          ; Use input buffer for conversion
    mov rcx, 10                 ; Base 10
    xor rdx, rdx                ; Clear rdx

.convert_loop:
    xor rdx, rdx                ; Clear rdx
    div rcx                     ; Divide rax by 10
    add dl, '0'                 ; Convert remainder to ASCII
    dec rsi                     ; Move buffer pointer
    mov [rsi], dl               ; Store ASCII character
    test rax, rax               ; Check if quotient is 0
    jnz .convert_loop           ; Repeat until quotient is 0

    ; Print the number
    mov rax, 1                  ; syscall: write
    mov rdi, 1                  ; file descriptor: stdout
    mov rdx, input + 4 - rsi    ; Calculate length
    syscall

    ret
