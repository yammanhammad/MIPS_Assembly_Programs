.data
    asterisk:   .asciiz "*"
    space:      .asciiz " "
    newline:    .asciiz "\n"
    prompt:     .asciiz "\nEnter diamond size (even number between 2-20, 0 to exit): "
    errorMsg:   .asciiz "Invalid input! Please enter an even number between 2-20.\n"

.text
main:
    # Main program loop
    programLoop:
        # Prompt for diamond size
        li $v0, 4
        la $a0, prompt
        syscall
        
        # Read integer input
        li $v0, 5
        syscall
        move $s0, $v0     # $s0 = diamondSize
        
        # Check if user wants to exit
        beqz $s0, exitProgram
        
        # Validate input (must be even and between 2-20)
        li $t0, 2
        blt $s0, $t0, invalidInput    # Less than 2
        li $t0, 20
        bgt $s0, $t0, invalidInput    # Greater than 20
        andi $t0, $s0, 1              # Check if odd
        bnez $t0, invalidInput        # If odd, invalid
        
        # Draw the double diamond
        jal drawDoubleDiamond
        j programLoop
        
    invalidInput:
        li $v0, 4
        la $a0, errorMsg
        syscall
        j programLoop
        
    exitProgram:
        li $v0, 10
        syscall

# Procedure to draw the double diamond pattern
drawDoubleDiamond:
    # Save return address
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    # Initialize registers
    move $s1, $s0                 # $s1 = maxSize (from user input)
    li $s2, 0                     # $s2 = currentRow (top half)
    
    # Draw top half of the diamond
    topHalfLoop:
        # Calculate spaces and stars
        move $t0, $s1             # $t0 = maxSize
        sub $t0, $t0, $s2         # $t0 = maxSize - currentRow
        srl $t0, $t0, 1           # Divide by 2 to get the correct number of spaces
        
        # Print spaces
        li $t1, 0                 # $t1 = spaceCounter
        spaceLoop1:
            beq $t1, $t0, endSpaceLoop1
            
            li $v0, 4
            la $a0, space
            syscall
            
            addi $t1, $t1, 1      # Increment space counter
            j spaceLoop1
        endSpaceLoop1:
        
        # Print stars
        li $t1, 0                 # $t1 = starCounter
        addi $t2, $s2, 1          # $t2 = Number of stars to print
        starLoop1:
            beq $t1, $t2, endStarLoop1
            
            li $v0, 4
            la $a0, asterisk
            syscall
            
            addi $t1, $t1, 1      # Increment star counter
            j starLoop1
        endStarLoop1:
        
        # Print newline
        li $v0, 4
        la $a0, newline
        syscall
        
        # Increment row and check if we're done with top half
        addi $s2, $s2, 2          # Increase by 2 for each row
        ble $s2, $s1, topHalfLoop
    
    # Draw bottom half of the diamond
    sub $s2, $s1, 2               # Start from maxSize-2 for bottom half
    
    bottomHalfLoop:
        # Calculate spaces and stars
        move $t0, $s1             # $t0 = maxSize
        sub $t0, $t0, $s2         # $t0 = maxSize - currentRow
        srl $t0, $t0, 1           # Divide by 2 to get the correct number of spaces
        
        # Print spaces
        li $t1, 0                 # $t1 = spaceCounter
        spaceLoop2:
            beq $t1, $t0, endSpaceLoop2
            
            li $v0, 4
            la $a0, space
            syscall
            
            addi $t1, $t1, 1      # Increment space counter
            j spaceLoop2
        endSpaceLoop2:
        
        # Print stars
        li $t1, 0                 # $t1 = starCounter
        addi $t2, $s2, 1          # $t2 = Number of stars to print
        starLoop2:
            beq $t1, $t2, endStarLoop2
            
            li $v0, 4
            la $a0, asterisk
            syscall
            
            addi $t1, $t1, 1      # Increment star counter
            j starLoop2
        endStarLoop2:
        
        # Print newline
        li $v0, 4
        la $a0, newline
        syscall
        
        # Decrement row and check if we're done with bottom half
        subi $s2, $s2, 2          # Decrease by 2 for each row
        bgez $s2, bottomHalfLoop
    
    # Restore return address and return
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
