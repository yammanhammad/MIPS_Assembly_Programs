.data
program_title:   .asciiz "\n===== Combination Calculator (nCr) =====\n"
input1:          .asciiz "Please Enter the value of 'n': "
input2:          .asciiz "Please Enter the value of 'r': "
result:          .asciiz "\nResult (nCr): "
error_negative:  .asciiz "\nError: Input values must be positive integers."
error_r_gt_n:    .asciiz "\nError: 'r' cannot be greater than 'n'."
continue_prompt: .asciiz "\n\nCalculate another combination? (1 for yes, 0 for no): "
goodbye_msg:     .asciiz "\nThank you for using the Combination Calculator!\n"

.text
main:
    # Display program title
    li $v0, 4
    la $a0, program_title
    syscall

input_loop:
    # Get value of n
    li $v0, 4
    la $a0, input1
    syscall
    
    li $v0, 5
    syscall
    move $s0, $v0    # $s0 = n value
    
    # Get value of r
    li $v0, 4
    la $a0, input2
    syscall
    
    li $v0, 5
    syscall
    move $s1, $v0    # $s1 = r value
    
    # Validate inputs
    # Check if n > 0
    blez $s0, input_error_negative
    
    # Check if r > 0
    blez $s1, input_error_negative
    
    # Check if n >= r
    blt $s0, $s1, input_error_r_gt_n
    
    # Calculate nCr
    jal calculate_combination
    
    # Display result
    li $v0, 4
    la $a0, result
    syscall
    
    li $v0, 1
    move $a0, $s2    # $s2 = result of combination
    syscall
    
    j prompt_continue
    
input_error_negative:
    li $v0, 4
    la $a0, error_negative
    syscall
    j prompt_continue
    
input_error_r_gt_n:
    li $v0, 4
    la $a0, error_r_gt_n
    syscall
    j prompt_continue
    
prompt_continue:
    # Ask if user wants to continue
    li $v0, 4
    la $a0, continue_prompt
    syscall
    
    li $v0, 5
    syscall
    
    # If input is 1, continue with another calculation
    beq $v0, 1, main
    
    # Otherwise exit with goodbye message
    li $v0, 4
    la $a0, goodbye_msg
    syscall
    
    # Terminate program
    li $v0, 10
    syscall

# Function to calculate combination using (n!) / (r! * (n-r)!)
calculate_combination:
    # Special case: if r = 0 or r = n, result is 1
    beq $s1, $zero, return_one
    beq $s0, $s1, return_one
    
    # Special case: if r = 1, result is n
    li $t0, 1
    beq $s1, $t0, return_n
    
    # Calculate n!
    move $t0, $s0    # $t0 = n
    li $t3, 1        # $t3 = factorial result
    
    factorial_n:
        mul $t3, $t3, $t0
        subi $t0, $t0, 1
        bgtz $t0, factorial_n
    
    move $s3, $t3    # $s3 = n!
    
    # Calculate r!
    move $t0, $s1    # $t0 = r
    li $t3, 1        # $t3 = factorial result
    
    factorial_r:
        mul $t3, $t3, $t0
        subi $t0, $t0, 1
        bgtz $t0, factorial_r
    
    move $s4, $t3    # $s4 = r!
    
    # Calculate (n-r)!
    sub $t0, $s0, $s1  # $t0 = n-r
    li $t3, 1          # $t3 = factorial result
    
    factorial_n_minus_r:
        mul $t3, $t3, $t0
        subi $t0, $t0, 1
        bgtz $t0, factorial_n_minus_r
    
    move $s5, $t3    # $s5 = (n-r)!
    
    # Calculate nCr = n! / (r! * (n-r)!)
    mul $t0, $s4, $s5
    div $s2, $s3, $t0
    
    jr $ra
    
return_one:
    li $s2, 1
    jr $ra
    
return_n:
    move $s2, $s0
    jr $ra