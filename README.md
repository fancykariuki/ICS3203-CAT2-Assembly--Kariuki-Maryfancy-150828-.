# Assembly Tasks

This repository contains a series of assembly programs designed to implement various concepts, including control flow, array manipulation, modular programming, and simulation of a data monitoring system. Each task is accompanied by an explanation of its purpose, the compilation and execution process, and any insights or challenges encountered.

## 1. Control Flow and Conditional Logic

### Purpose:
This program prompts the user to enter a number and classifies it as "POSITIVE", "NEGATIVE", or "ZERO" using conditional branching logic.

### Code Walkthrough:
- The program uses both conditional jumps (`je`, `jg`, `jl`) and unconditional jumps (`jmp`) to direct the flow based on the user input.
- `je` (jump if equal) is used to check if the number is zero.
- `jg` (jump if greater) and `jl` (jump if less) are used to check for positive or negative values, respectively.
- **Unconditional jump** is used in situations where we want to skip the rest of the code if a condition is met.

### Instructions to Compile and Run:
1. **Compile the code:**
    ```bash
    nasm -f elf64 task1_control_flow.asm
    ld -o task1_control_flow task1_control_flow.o
    ```

2. **Run the program:**
    ```bash
    ./task1_control_flow
    ```

### Challenges:
- Handling the conditional and unconditional jumps properly.
- Making sure each jump is effectively implemented without disrupting other parts of the code.
---

## 2. Array Manipulation with Looping and Reversal

### Purpose:
This program accepts an array of integers and reverses it in place without using additional memory.

### Code Walkthrough:
- The program uses loops (for, while, or equivalent in assembly) to swap elements of the array.
- It swaps the first element with the last, then the second element with the second-last, and so on until the middle of the array is reached.
- The **challenge** lies in avoiding extra memory usage and modifying the array directly by manipulating memory addresses.

### Instructions to Compile and Run:
1. **Compile the code:**
    ```bash
    nasm -f elf64 task2_array_reverse.asm
    ld -o task2_array_reverse task2_array_reverse.o
    ```

2. **Run the program:**
    ```bash
    ./task2_array_reverse
    ```

### Challenges:
- Setting up the front and back pointers for the reversal logic of the array to work correctly.
- Maintaining memory integrity required while carefully tracking the array indices.

---

## 3. Modular Program with Subroutines for Factorial Calculation

### Purpose:
This program calculates the factorial of a number using a subroutine (function-like code block) and utilizes the stack to preserve registers.

### Code Walkthrough:
- The program defines a **subroutine** to calculate the factorial of a number.
- It uses the **stack** to preserve registers before calling the subroutine and restores them afterward.
- The result is placed in a general-purpose register to be used later.

### Instructions to Compile and Run:
1. **Compile the code:**
    ```bash
    nasm -f elf64 task3_factorial.asm
    ld -o task3_factorial task3_factorial.o
    ```

2. **Run the program:**
    ```bash
    ./task3_factorial
    ```

### Challenges:
- Using the stack to save and restore registers allowing for recursive function calls and proper register management.
- Managing the stack and registers effectively.

---

## 4. Data Monitoring and Control Using Port-Based Simulation

### Purpose:
This program simulates a control system that reads a "sensor value" and performs actions like turning on a motor or triggering an alarm based on the value.

### Code Walkthrough:
- The program reads from a simulated **sensor value** (memory location or port).
- Based on the sensor value, the program will:
    - Turn on a motor by setting a bit in a specific memory location.
    - Trigger an alarm if the water level is too high.
    - Stop the motor if the water level is moderate.

### Instructions to Compile and Run:
1. **Compile the code:**
    ```bash
    nasm -f elf64 task4_data_monitoring.asm
    ld -o task4_data_monitoring task4_data_monitoring.o
    ```

2. **Run the program:**
    ```bash
    ./task4_data_monitoring
    ```

### Challenges:
- Simulating input ports and determining how to interact with them to simulate real-world hardware behavior.
- Determining which action to take based on sensor values, whuch had to be carefully implemented using conditional jumps.

---


