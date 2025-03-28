.data
# User interface messages
welcomeMsg: .asciiz "\n--- Tax Calculator ---\n"
promptMsg: .asciiz "Enter your salary (0 or negative to exit): "
resultMsg: .asciiz "Your tax amount: "
invalidMsg: .asciiz "Invalid input! Salary must be positive.\n"
exitMsg: .asciiz "\nExiting tax calculator. Goodbye!\n"
newlineMsg: .asciiz "\n"

# Tax rates for different brackets
taxRate1: .double 0.028  # 2.8% for first bracket
taxRate2: .double 0.035  # 3.5% for second bracket
taxRate3: .double 0.05   # 5.0% for third bracket
taxRate4: .double 0.062  # 6.2% for fourth bracket
taxRate5: .double 0.037  # 3.7% for fifth bracket

# Salary thresholds for tax brackets
bracketThreshold2: .double 5000
bracketThreshold3: .double 10000
bracketThreshold4: .double 30000
bracketThreshold5: .double 40000
bracketThreshold6: .double 80000

# Fixed tax amounts for each bracket
fixedTaxAmount2: .double 140
fixedTaxAmount3: .double 490
fixedTaxAmount4: .double 1990
fixedTaxAmount5: .double 4470
fixedTaxAmount6: .double 8470

# Constants
zero: .double 0.0

.text
main:
    # Display welcome message
    li $v0, 4
    la $a0, welcomeMsg
    syscall

input_loop:
    # Prompt for salary input
    li $v0, 4
    la $a0, promptMsg
    syscall
    
    # Read salary as double
    li $v0, 7
    syscall
    mov.d $f4, $f0  # Store user salary in $f4
    
    # Check if user wants to exit (salary <= 0)
    l.d $f6, zero
    c.le.d $f4, $f6
    bc1t exit_program
    
    # Calculate tax based on salary bracket
    l.d $f6, bracketThreshold2
    c.lt.d $f4, $f6
    bc1t bracket1
    
    l.d $f6, bracketThreshold3
    c.lt.d $f4, $f6
    bc1t bracket2
    
    l.d $f6, bracketThreshold4
    c.lt.d $f4, $f6
    bc1t bracket3
    
    l.d $f6, bracketThreshold5
    c.lt.d $f4, $f6
    bc1t bracket4
    
    l.d $f6, bracketThreshold6
    c.lt.d $f4, $f6
    bc1t bracket5
    
    j bracket6

bracket1:
    # Tax for salary < 5000 (2.8% of salary)
    l.d $f8, taxRate1
    mul.d $f10, $f4, $f8  # tax = salary * 0.028
    j display_result

bracket2:
    # Tax for salary 5000-10000
    l.d $f6, bracketThreshold2
    sub.d $f10, $f4, $f6       # (salary - 5000)
    l.d $f8, taxRate2
    mul.d $f10, $f10, $f8      # (salary - 5000) * 0.035
    l.d $f2, fixedTaxAmount2
    add.d $f10, $f10, $f2      # tax = ((salary - 5000) * 0.035) + 140
    j display_result

bracket3:
    # Tax for salary 10000-30000
    l.d $f6, bracketThreshold3
    sub.d $f10, $f4, $f6       # (salary - 10000)
    l.d $f8, taxRate3
    mul.d $f10, $f10, $f8      # (salary - 10000) * 0.05
    l.d $f2, fixedTaxAmount3
    add.d $f10, $f10, $f2      # tax = ((salary - 10000) * 0.05) + 490
    j display_result

bracket4:
    # Tax for salary 30000-40000
    l.d $f6, bracketThreshold4
    sub.d $f10, $f4, $f6       # (salary - 30000)
    l.d $f8, taxRate4
    mul.d $f10, $f10, $f8      # (salary - 30000) * 0.062
    l.d $f2, fixedTaxAmount4
    add.d $f10, $f10, $f2      # tax = ((salary - 30000) * 0.062) + 1990
    j display_result

bracket5:
    # Tax for salary 40000-80000
    l.d $f6, bracketThreshold5
    sub.d $f10, $f4, $f6       # (salary - 40000)
    l.d $f8, taxRate5          
    mul.d $f10, $f10, $f8      # (salary - 40000) * 0.037
    l.d $f2, fixedTaxAmount5
    add.d $f10, $f10, $f2      # tax = ((salary - 40000) * 0.037) + 4470
    j display_result

bracket6:
    # Tax for salary > 80000
    l.d $f6, bracketThreshold6
    sub.d $f10, $f4, $f6       # (salary - 80000)
    l.d $f8, taxRate5          
    mul.d $f10, $f10, $f8      # (salary - 80000) * 0.037
    l.d $f2, fixedTaxAmount6
    add.d $f10, $f10, $f2      # tax = ((salary - 80000) * 0.037) + 8470

display_result:
    # Display tax result message
    li $v0, 4
    la $a0, resultMsg
    syscall
    
    # Print calculated tax amount
    mov.d $f12, $f10
    li $v0, 3
    syscall
    
    # Print newline
    li $v0, 4
    la $a0, newlineMsg
    syscall
    
    # Go back to start of the loop
    j input_loop

exit_program:
    # Display exit message
    li $v0, 4
    la $a0, exitMsg
    syscall
    
    # Exit program
    li $v0, 10
    syscall
