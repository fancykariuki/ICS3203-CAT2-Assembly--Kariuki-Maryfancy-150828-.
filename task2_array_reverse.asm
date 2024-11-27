section .bss
    array resb 5       ; Reserve space for 5 integers (as bytes)
    input_num resb 1   ; Space to hold the user input character

section .text
    global _start

_start:
    ; Prompt user to enter 5 integers
    mov rax, 1                ; syscall: write
    mov rdi, 1                ; file descriptor: stdout
    mov rsi, prompt_message   ; message to print
    mov rdx, 24               ; length of message
    syscall

    ; Read 5 integers from user input
    mov rcx, 5                ; Loop counter (5 integers)
    lea rbx, [array]          ; Load address of array into rbx
read_input:
    mov rax, 0                ; syscall: read
    mov rdi, 0                ; file descriptor: stdin
    lea rsi, [input_num]      ; Load address of input_num
    mov rdx, 1                ; number of bytes to read
    syscall

    ; Convert ASCII to integer and store in array
    movzx rsi, byte [input_num]   ; Load input character into rsi
    sub rsi, '0'                ; Convert from ASCII to integer
    mov [rbx], rsi             ; Store the value in the array
    inc rbx                    ; Move to the next position in array
    loop read_input            ; Repeat for 5 numbers

    ; Reverse the array in place
    lea rbx, [array]           ; Load address of array into rbx
    lea rdx, [array+4]         ; Load address of the last element
    mov rcx, 2                 ; Loop counter: 2 swaps for 5 elements
reverse_loop:
    mov al, [rbx]              ; Load the value from the front
    mov bl, [rdx]              ; Load the value from the back
    mov [rbx], bl              ; Store the back value at the front
    mov [rdx], al              ; Store the front value at the back
    inc rbx                    ; Move forward in array
    dec rdx                    ; Move backward in array
    loop reverse_loop          ; Repeat for 2 swaps

    ; Print the reversed array
    mov rax, 1                 ; syscall: write
    mov rdi, 1                 ; file descriptor: stdout
    mov rsi, reversed_message  ; message to print
    mov rdx, 20                ; length of message
    syscall

    mov rcx, 5                 ; Loop counter (5 elements)
    lea rbx, [array]           ; Load address of array into rbx
print_array:
    movzx rsi, byte [rbx]      ; Load value from array
    add rsi, '0'               ; Convert integer to ASCII
    mov rax, 1                 ; syscall: write
    mov rdi, 1                 ; file descriptor: stdout
    mov rsi, rsi               ; Load ASCII value
    mov rdx, 1                 ; number of bytes to write
    syscall

    inc rbx                    ; Move to the next element in array
    loop print_array           ; Repeat for 5 elements

    ; Exit the program
    mov rax, 60                ; syscall: exit
    xor rdi, rdi               ; exit code 0
    syscall

section .data
    prompt_message db "Enter 5 integers separated by spaces: ", 0
    reversed_message db "Reversed array: ", 0

