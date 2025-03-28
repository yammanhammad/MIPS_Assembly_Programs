.data
# Menu and user prompt messages
menu: .asciiz "\n\n\t======= CALCULATOR =======\n1) Addition\n2) Subtraction\n3) Multiplication\n4) Division\n5) Exit\nPlease enter the number of operation you want to perform: "
numOfOperandsMsg: .asciiz "Please enter the number of operands you want to perform this operation upon: "
operandInputMsg: .asciiz "Please enter a number: "
resultMsg: .asciiz "The result is "
continue: .asciiz "\nPlease press enter to continue..."

# Error messages
divisionByZeroErrorMsg: .asciiz "Error: Division by zero.\nPlease enter a number other than 0.\n"
menuSelectionErrorMsg: .asciiz "Error: Invalid Input.\nPlease enter a number greater than 0 and less than 6."
numOfOperandsErrorMsg: .asciiz "Error: Invalid Input.\nPlease enter a whole number greater than 1 and less than 11.\n"
invalidInputMsg: .asciiz "Error: Invalid input. Please try again.\n"

.align 3
# Storage for operands (10 doubles = 80 bytes)
operandsArray: .space 80

# Constants
zero: .double 0.0
one: .double 1.0
epsilon: .double 0.000000001  # For comparing doubles close to zero

.text
.globl main

main:
    j displayMenu    # Start program by displaying menu

# Display calculator menu and get operation choice
displayMenu:
    # Display menu options
    li $v0, 4
    la $a0, menu
    syscall

    # Read user's menu selection
    li $v0, 5
    syscall
    move $t0, $v0    # Store operation code in $t0

    # Validate menu selection (must be between 1 and 5)
    li $t1, 1
    blt $t0, $t1, menuSelectionError
    li $t1, 5
    bgt $t0, $t1, menuSelectionError
    
    # Check if user wants to exit
    li $t1, 5
    beq $t0, $t1, exitProgram

# Get number of operands from user
getOperandCount:
    li $v0, 4
    la $a0, numOfOperandsMsg
    syscall
    
    li $v0, 5
    syscall
    move $t1, $v0    # Store number of operands in $t1
    
    # Validate operand count (must be between 2 and 10)
    li $t2, 1
    ble $t1, $t2, numOfOperandsError
    li $t2, 10
    bgt $t1, $t2, numOfOperandsError
    
    # Calculate total size needed for operands array
    mul $t1, $t1, 8  # Each double is 8 bytes
    li $t2, 0        # Initialize array index to 0
    
    # Check if division operation to handle special case
    li $t3, 4
    beq $t0, $t3, getFirstOperandForDivision
    
    # For non-division operations, get all operands normally
    j getOperands

# Get operands from user and store in array
getOperands:
    li $v0, 4
    la $a0, operandInputMsg
    syscall
    
    # Read double from user
    li $v0, 7
    syscall
    
    # Store in operands array
    s.d $f0, operandsArray($t2)
    addi $t2, $t2, 8
    
    # Check if we have all operands
    blt $t2, $t1, getOperands
    
    # Prepare for computation based on selected operation
    j prepareComputation

# Special handling for division operation's first operand
getFirstOperandForDivision:
    li $v0, 4
    la $a0, operandInputMsg
    syscall
    
    li $v0, 7
    syscall
    
    # Store first operand normally (no zero check needed)
    s.d $f0, operandsArray($t2)
    addi $t2, $t2, 8
    
    # Continue with remaining operands that need zero checks
    j getDivisionOperands

# Get operands for division with zero-check
getDivisionOperands:
    beq $t2, $t1, prepareComputation  # If we have all operands, proceed to calculation
    
    li $v0, 4
    la $a0, operandInputMsg
    syscall
    
    li $v0, 7
    syscall
    
    # Check if operand is zero (not allowed for division)
    l.d $f2, zero
    l.d $f4, epsilon
    abs.d $f6, $f0         # Get absolute value
    c.lt.d $f6, $f4        # Check if |value| < epsilon
    bc1t divisionByZeroError
    
    # Store valid operand
    s.d $f0, operandsArray($t2)
    addi $t2, $t2, 8
    
    j getDivisionOperands

# Prepare for calculation based on operation type
prepareComputation:
    li $t3, 0    # Reset array index
    
    # Branch to appropriate operation
    li $t2, 1
    beq $t0, $t2, addition
    
    li $t2, 2
    beq $t0, $t2, subtraction
    
    li $t2, 3
    beq $t0, $t2, multiplication
    
    li $t2, 4
    beq $t0, $t2, division
    
    # Should never reach here
    j displayMenu

# Addition operation
addition:
    # Start with zero
    l.d $f2, zero
    
additionLoop:
    l.d $f4, operandsArray($t3)
    add.d $f2, $f2, $f4
    addi $t3, $t3, 8
    blt $t3, $t1, additionLoop
    
    j displayResult

# Subtraction operation
subtraction:
    # Start with first element
    l.d $f2, operandsArray($t3)
    addi $t3, $t3, 8
    
subtractionLoop:
    l.d $f4, operandsArray($t3)
    sub.d $f2, $f2, $f4
    addi $t3, $t3, 8
    blt $t3, $t1, subtractionLoop
    
    j displayResult

# Multiplication operation
multiplication:
    # Start with one
    l.d $f2, one
    
multiplicationLoop:
    l.d $f4, operandsArray($t3)
    mul.d $f2, $f2, $f4
    addi $t3, $t3, 8
    blt $t3, $t1, multiplicationLoop
    
    j displayResult

# Division operation
division:
    # Start with first element
    l.d $f2, operandsArray($t3)
    addi $t3, $t3, 8
    
divisionLoop:
    l.d $f4, operandsArray($t3)
    div.d $f2, $f2, $f4
    addi $t3, $t3, 8
    blt $t3, $t1, divisionLoop
    
    j displayResult

# Display calculation result
displayResult:
    li $v0, 4
    la $a0, resultMsg
    syscall
    
    # Print double result
    mov.d $f12, $f2
    li $v0, 3
    syscall
    
    # Wait for user to press enter before continuing
    li $v0, 4
    la $a0, continue
    syscall
    
    li $v0, 8
    syscall
    
    # Return to menu
    j displayMenu

# Handle division by zero error
divisionByZeroError:
    li $v0, 4
    la $a0, divisionByZeroErrorMsg
    syscall
    
    # Try again for the same operand
    j getDivisionOperands

# Handle menu selection error
menuSelectionError:
    li $v0, 4
    la $a0, menuSelectionErrorMsg
    syscall
    
    j displayMenu

# Handle number of operands error
numOfOperandsError:
    li $v0, 4
    la $a0, numOfOperandsErrorMsg
    syscall
    
    j getOperandCount

# Exit the program
exitProgram:
    li $v0, 10
    syscall
