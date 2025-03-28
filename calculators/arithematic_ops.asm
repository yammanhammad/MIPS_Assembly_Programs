.data
msg_welcome: .asciiz "\n----- Arithmetic Calculator -----\n"
msg1: .asciiz "\nPlease Enter First Number: "
msg2: .asciiz "\nPlease Enter Second Number: "
msg3: .asciiz "\nAddition: "
msg4: .asciiz "\nSubtraction: "
msg5: .asciiz "\nMultiplication: "
msg6: .asciiz "\nDivision: "
msg_div_error: .asciiz "\nError: Cannot divide by zero!\n"
msg_continue: .asciiz "\n\nDo you want to continue? (1 for yes, 0 for no): "
newline: .asciiz "\n"
  
.text
main:
    # Display welcome message
    li $v0, 4
    la $a0, msg_welcome
    syscall
    
    # Get first number
    li $v0, 4
    la $a0, msg1
    syscall
    
    li $v0, 5       # syscall 5 reads an integer
    syscall
    move $t0, $v0   # store first number in $t0
    
    # Get second number
    li $v0, 4
    la $a0, msg2
    syscall
    
    li $v0, 5       # syscall 5 reads an integer
    syscall
    move $t1, $v0   # store second number in $t1
    
    # Addition
    add $t2, $t0, $t1
    li $v0, 4
    la $a0, msg3
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    
    # Subtraction
    sub $t2, $t0, $t1
    li $v0, 4
    la $a0, msg4
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    
    # Multiplication
    mul $t2, $t0, $t1
    li $v0, 4
    la $a0, msg5
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    
    # Division (with check for divide by zero)
    beqz $t1, division_error
    div $t0, $t1
    mflo $t2        # quotient
    
    li $v0, 4
    la $a0, msg6
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    j division_done
    
division_error:
    li $v0, 4
    la $a0, msg_div_error
    syscall
    
division_done:
    # Ask if user wants to continue
    li $v0, 4
    la $a0, msg_continue
    syscall
    
    li $v0, 5
    syscall
    
    # If input is 1, loop back to start
    beq $v0, 1, main
    
    # Otherwise exit
    li $v0, 10
    syscall