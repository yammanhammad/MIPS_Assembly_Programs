.data
# Messages for user interaction
msg1: .asciiz "\nEnter the count of numbers you want to find average of (0 to exit): "
msg2: .asciiz "Enter number "
msg3: .asciiz ": "
msg4: .asciiz "\nThe average is: "
msg5: .asciiz "\nError: Count must be between 1 and 100\n"
msg6: .asciiz "\nProgram terminated.\n"
colon: .asciiz ": "

# Ensure 4-byte alignment for the array
.align 2  # 2^2 = 4 byte alignment
# Allocate more space for the array (400 bytes = space for 100 integers)
array: .space 400

.text
main:
    # Main program loop
    jal get_count
    
    # Check if user wants to exit (entered 0)
    beqz $v0, exit_program
    
    # Store count in $s0 for future use
    move $s0, $v0
    
    # Get input numbers
    jal input_numbers
    
    # Calculate and display average
    jal calculate_average
    
    # Loop back to beginning
    j main

# Get count from user and validate
get_count:
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 5
    syscall
    
    # Check if user wants to exit
    beqz $v0, get_count_return
    
    # Validate count (must be between 1 and 100)
    blez $v0, invalid_count
    bgt $v0, 100, invalid_count
    
    j get_count_return
    
invalid_count:
    li $v0, 4
    la $a0, msg5
    syscall
    
    # Try again
    j get_count
    
get_count_return:
    jr $ra

# Input numbers into array
input_numbers:
    # Initialize counters
    li $t0, 0          # Loop counter
    li $t1, 0          # Array index offset
    
input_loop:
    # Display prompt with number index
    li $v0, 4
    la $a0, msg2
    syscall
    
    # Display current number (1-based)
    addi $a0, $t0, 1
    li $v0, 1
    syscall
    
    # Display colon
    li $v0, 4
    la $a0, colon
    syscall
    
    # Read integer
    li $v0, 5
    syscall
    
    # Store in array
    sw $v0, array($t1)
    
    # Increment counters
    addi $t0, $t0, 1
    addi $t1, $t1, 4
    
    # Check if we've reached the count
    blt $t0, $s0, input_loop
    
    jr $ra

# Calculate and display average
calculate_average:
    # Initialize sum
    li $t0, 0          # Sum
    li $t1, 0          # Array index offset
    li $t2, 0          # Loop counter
    
sum_loop:
    # Load number from array
    lw $t3, array($t1)
    
    # Add to sum
    add $t0, $t0, $t3
    
    # Increment counters
    addi $t2, $t2, 1
    addi $t1, $t1, 4
    
    # Check if we've processed all numbers
    blt $t2, $s0, sum_loop
    
    # Calculate average as floating point
    # Convert sum to float
    mtc1 $t0, $f0
    cvt.s.w $f0, $f0
    
    # Convert count to float
    mtc1 $s0, $f1
    cvt.s.w $f1, $f1
    
    # Perform floating point division
    div.s $f12, $f0, $f1
    
    # Display result
    li $v0, 4
    la $a0, msg4
    syscall
    
    # Print floating point result (value already in $f12)
    li $v0, 2
    syscall
    
    jr $ra

# Exit program
exit_program:
    li $v0, 4
    la $a0, msg6
    syscall
    
    li $v0, 10
    syscall
