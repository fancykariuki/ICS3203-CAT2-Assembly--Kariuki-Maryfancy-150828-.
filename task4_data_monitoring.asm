section .data
    sensor_value db 5         ; Simulate sensor value (e.g., water level sensor)
    motor_status db 0         ; Motor status (0 = OFF, 1 = ON)
    alarm_status db 0         ; Alarm status (0 = OFF, 1 = ON)
    msg_motor_on db "Motor ON", 0xA, 0  ; Message for motor on
    msg_motor_off db "Motor OFF", 0xA, 0  ; Message for motor off
    msg_alarm_on db "ALARM: Water level too high!", 0xA, 0  ; Alarm message
    msg_no_alarm db "Water level is safe.", 0xA, 0  ; No alarm message

section .bss
    input_value resb 1        ; Reserve space for input sensor value

section .text
    global _start

_start:
    ; Simulate reading the sensor value (here it's hardcoded, can be modified for user input)
    mov al, [sensor_value]    ; Load the water level sensor value into AL

    ; Check water level and control actions
    cmp al, 8                 ; Compare sensor value with threshold (e.g., 8)
    jge water_level_high      ; If water level >= 8, jump to water_level_high

    cmp al, 5                 ; Compare with moderate value (e.g., 5)
    jge moderate_level        ; If water level >= 5 and < 8, jump to moderate_level

    ; If water level is below 5, stop the motor
    jmp stop_motor

water_level_high:
    ; Trigger the alarm and turn on the motor
    mov byte [alarm_status], 1  ; Set alarm status to ON
    mov byte [motor_status], 1  ; Set motor status to ON

    ; Print alarm message
    mov rax, 1                 ; syscall: write
    mov rdi, 1                 ; file descriptor: stdout
    mov rsi, msg_alarm_on      ; message address
    mov rdx, 26                ; message length
    syscall

    ; Print motor ON message
    mov rax, 1                 ; syscall: write
    mov rdi, 1                 ; file descriptor: stdout
    mov rsi, msg_motor_on      ; message address
    mov rdx, 9                 ; message length
    syscall
    jmp end_program

moderate_level:
    ; Motor ON and no alarm
    mov byte [motor_status], 1  ; Set motor status to ON
    mov byte [alarm_status], 0  ; Set alarm status to OFF

    ; Print motor ON message
    mov rax, 1                 ; syscall: write
    mov rdi, 1                 ; file descriptor: stdout
    mov rsi, msg_motor_on      ; message address
    mov rdx, 9                 ; message length
    syscall

    ; Print safe status (no alarm)
    mov rax, 1                 ; syscall: write
    mov rdi, 1                 ; file descriptor: stdout
    mov rsi, msg_no_alarm      ; message address
    mov rdx, 23                ; message length
    syscall
    jmp end_program

stop_motor:
    ; Stop the motor if the water level is low
    mov byte [motor_status], 0  ; Set motor status to OFF

    ; Print motor OFF message
    mov rax, 1                 ; syscall: write
    mov rdi, 1                 ; file descriptor: stdout
    mov rsi, msg_motor_off     ; message address
    mov rdx, 10                ; message length
    syscall

end_program:
    ; Exit the program
    mov rax, 60                ; syscall: exit
    xor rdi, rdi               ; exit code 0
    syscall

