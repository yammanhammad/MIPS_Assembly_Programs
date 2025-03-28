.data
    titleMsg:   .asciiz "====== FIBONACCI SEQUENCE ======\n"
    inputMsg:   .asciiz "Please enter the value of n (how many Fibonacci numbers to display): "
    exitMsg:    .asciiz "Enter 0 or a negative number to exit the program.\n"
    resultMsg:  .asciiz "Fibonacci Sequence (first "
    resultMsg2: .asciiz " numbers):\n"
    nextLine:   .asciiz "\n"
    tab:        .asciiz "\t"
    errorMsg:   .asciiz "Error: Invalid Input.\nInput must be a whole number (greater than zero).\n"
    goodbyeMsg: .asciiz "Thank you for using the Fibonacci calculator. Goodbye!\n"

.text
main:
    # Display program title and instructions
    li $v0, 4
    la $a0, titleMsg
    syscall
    
    la $a0, exitMsg
    syscall

program_loop:
    # Prompt for input
    li $v0, 4
    la $a0, inputMsg
    syscall
    
    # Read integer input
    li $v0, 5
    syscall
    move $t0, $v0       # $t0 = n (number of terms)
    
    # Check if user wants to exit
    ble $t0, $zero, exit_program
    
    # Display result message
    li $v0, 4
    la $a0, resultMsg
    syscall
    
    li $v0, 1
    move $a0, $t0
    syscall
    
    li $v0, 4
    la $a0, resultMsg2
    syscall
    
    # Handle different cases based on n
    li $t1, 1           # $t1 = comparison value
    beq $t0, $t1, print_first_number  # if n == 1, print only first number
    
    # Print first two Fibonacci numbers for n >= 2
    li $v0, 1
    li $a0, 0           # First Fibonacci number (F0 = 0)
    syscall
    
    li $v0, 4
    la $a0, tab
    syscall
    
    li $v0, 1
    li $a0, 1           # Second Fibonacci number (F1 = 1)
    syscall
    
    # If n == 2, we're done after printing 0, 1
    li $t1, 2
    beq $t0, $t1, fib_complete
    
    # Initialize for Fibonacci calculation
    li $t1, 0           # $t1 = previous number (F0)
    li $t2, 1           # $t2 = current number (F1)
    li $t4, 2           # $t4 = counter (already printed 2 numbers)
    
    # Calculate and print remaining Fibonacci numbers
fibonacci_loop:
    # Tab separator
    li $v0, 4
    la $a0, tab
    syscall
    
    # Calculate next Fibonacci number
    add $t3, $t1, $t2   # $t3 = $t1 + $t2 (new Fibonacci number)
    move $t1, $t2       # $t1 = $t2 (update previous)
    move $t2, $t3       # $t2 = $t3 (update current)
    
    # Print the number
    li $v0, 1
    move $a0, $t3
    syscall
    
    # Increment counter and check if we're done
    addi $t4, $t4, 1
    blt $t4, $t0, fibonacci_loop

fib_complete:
    # Print newline and go back to start
    li $v0, 4
    la $a0, nextLine
    syscall
    la $a0, nextLine
    syscall
    j program_loop

print_first_number:
    # Special case: Print only first Fibonacci number (F0 = 0) when n == 1
    li $v0, 1
    li $a0, 0
    syscall
    
    li $v0, 4
    la $a0, nextLine
    syscall
    la $a0, nextLine
    syscall
    j program_loop

exit_program:
    # Display goodbye message
    li $v0, 4
    la $a0, goodbyeMsg
    syscall
    
    # Exit program
    li $v0, 10
    syscall