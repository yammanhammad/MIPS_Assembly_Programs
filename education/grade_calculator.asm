.data
# Program messages
welcome:  .asciiz "===== Student Grade Calculator =====\n"
midin:    .asciiz "\nPlease enter the midterm marks out of 40:\n"
finalin:  .asciiz "\nPlease enter the final marks out of 60:\n"
sub:      .asciiz "Subject #"
marks:    .asciiz " marks: "
error1:   .asciiz "Error: Midterm marks must be between 0 and 40. Try again.\n"
error2:   .asciiz "Error: Final marks must be between 0 and 60. Try again.\n"
result:   .asciiz "\n===== Results =====\n"
totalMsg: .asciiz "Total marks: "
grade1:   .asciiz "\nCGPA: 4.0\nGrade: A\nExcellent"
grade2:   .asciiz "\nCGPA: 3.5\nGrade: B+\nVery Good"
grade3:   .asciiz "\nCGPA: 3.0\nGrade: B\nGood"
grade4:   .asciiz "\nCGPA: 2.5\nGrade: C+\nAverage"
grade5:   .asciiz "\nCGPA: 2.0\nGrade: C\nBelow Average"
grade6:   .asciiz "\nCGPA: 0.0\nGrade: F\nFailure (course repeat)"
continueMsg: .asciiz "\n\nDo you want to calculate another grade? (1 for Yes, 0 for No): "
newline:  .asciiz "\n"

.align 2
# Array to store 5 midterm marks, 5 final marks, and 5 total marks (60 bytes)
array:    .space 60

.text
main:
    # Display welcome message
    li $v0, 4
    la $a0, welcome
    syscall
    
    # Initialize array indices
    # $s0 = midterm index, $s1 = final index, $s2 = total index
    li $s0, 0       # Start of midterm marks
    li $s1, 20      # Start of final marks (5 words * 4 bytes)
    li $s2, 40      # Start of total marks (10 words * 4 bytes)
    
    # Constant values
    li $s3, 5       # Number of subjects
    li $s4, 0       # Subject counter
    
    # Display midterm prompt
    li $v0, 4
    la $a0, midin
    syscall
    
    # Get midterm marks for all subjects
midterm_loop:
    # Display subject number
    li $v0, 4
    la $a0, sub
    syscall
    
    addi $t0, $s4, 1    # Subject number (1-based)
    li $v0, 1
    move $a0, $t0
    syscall
    
    li $v0, 4
    la $a0, marks
    syscall
    
    # Get midterm mark
get_midterm:
    li $v0, 5
    syscall
    
    # Validate input (0 <= mark <= 40)
    blt $v0, 0, midterm_error
    bgt $v0, 40, midterm_error
    
    # Store valid midterm mark
    sw $v0, array($s0)
    addi $s0, $s0, 4    # Move to next midterm slot
    j midterm_next
    
midterm_error:
    li $v0, 4
    la $a0, error1
    syscall
    j get_midterm
    
midterm_next:
    addi $s4, $s4, 1    # Increment subject counter
    blt $s4, $s3, midterm_loop    # Loop if more subjects
    
    # Reset subject counter for finals
    li $s4, 0
    
    # Display final exam prompt
    li $v0, 4
    la $a0, finalin
    syscall
    
    # Get final marks for all subjects
final_loop:
    # Display subject number
    li $v0, 4
    la $a0, sub
    syscall
    
    addi $t0, $s4, 1    # Subject number (1-based)
    li $v0, 1
    move $a0, $t0
    syscall
    
    li $v0, 4
    la $a0, marks
    syscall
    
    # Get final mark
get_final:
    li $v0, 5
    syscall
    
    # Validate input (0 <= mark <= 60)
    blt $v0, 0, final_error
    bgt $v0, 60, final_error
    
    # Store valid final mark
    sw $v0, array($s1)
    addi $s1, $s1, 4    # Move to next final slot
    j final_next
    
final_error:
    li $v0, 4
    la $a0, error2
    syscall
    j get_final
    
final_next:
    addi $s4, $s4, 1    # Increment subject counter
    blt $s4, $s3, final_loop    # Loop if more subjects
    
    # Calculate total marks for each subject
    li $s0, 0       # Reset midterm index
    li $s1, 20      # Reset final index
    li $s2, 40      # Reset total index
    li $s4, 0       # Reset subject counter
    
calculate_totals:
    lw $t1, array($s0)      # Load midterm mark
    lw $t2, array($s1)      # Load final mark
    add $t3, $t1, $t2       # Calculate total
    sw $t3, array($s2)      # Store total
    
    addi $s0, $s0, 4        # Next midterm
    addi $s1, $s1, 4        # Next final
    addi $s2, $s2, 4        # Next total
    addi $s4, $s4, 1        # Increment counter
    blt $s4, $s3, calculate_totals
    
    # Calculate average of totals
    li $s2, 40              # Reset total index
    li $t0, 0               # Sum of totals
    li $s4, 0               # Reset counter
    
sum_totals:
    lw $t1, array($s2)      # Load total
    add $t0, $t0, $t1       # Add to sum
    addi $s2, $s2, 4        # Next total
    addi $s4, $s4, 1        # Increment counter
    blt $s4, $s3, sum_totals
    
    # Display results
    li $v0, 4
    la $a0, result
    syscall
    
    # Display total marks
    li $v0, 4
    la $a0, totalMsg
    syscall
    
    li $v0, 1
    move $a0, $t0
    syscall
    
    # Calculate average (divide by number of subjects)
    div $t0, $t0, $s3
    
    # Determine grade based on average
    li $t1, 88
    bge $t0, $t1, grade_A
    
    li $t1, 81
    bge $t0, $t1, grade_B_plus
    
    li $t1, 74
    bge $t0, $t1, grade_B
    
    li $t1, 67
    bge $t0, $t1, grade_C_plus
    
    li $t1, 60
    bge $t0, $t1, grade_C
    
    j grade_F
    
grade_A:
    li $v0, 4
    la $a0, grade1
    syscall
    j ask_continue
    
grade_B_plus:
    li $v0, 4
    la $a0, grade2
    syscall
    j ask_continue
    
grade_B:
    li $v0, 4
    la $a0, grade3
    syscall
    j ask_continue
    
grade_C_plus:
    li $v0, 4
    la $a0, grade4
    syscall
    j ask_continue
    
grade_C:
    li $v0, 4
    la $a0, grade5
    syscall
    j ask_continue
    
grade_F:
    li $v0, 4
    la $a0, grade6
    syscall
    
ask_continue:
    # Ask if user wants to continue
    li $v0, 4
    la $a0, continueMsg
    syscall
    
    li $v0, 5
    syscall
    
    # If input is 1, restart the program
    beq $v0, 1, main
    
    # Otherwise terminate
    li $v0, 10
    syscall
