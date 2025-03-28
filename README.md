# MIPS Assembly Programs Collection

## Table of Contents
1. [Overview](#overview)
2. [Key Features](#-key-features)
3. [Repository Structure](#-repository-structure)
4. [Program Descriptions](#-program-descriptions)
5. [Sample Outputs](#-sample-outputs)
6. [Learning Path](#-learning-path)
7. [Technical Skills Demonstrated](#-technical-skills-demonstrated)
8. [Usage Instructions](#-usage-instructions)
9. [Why This Project Matters](#-why-this-project-matters)
10. [Performance Considerations](#-performance-considerations)
11. [Author](#-author)
12. [Contributing](#-contributing)
13. [License](#-license)

## Overview

This repository contains a comprehensive collection of MIPS assembly language programs developed to demonstrate proficiency in low-level programming, computer architecture concepts, and algorithm implementation. The programs range from basic arithmetic operations to more complex applications like grade calculation and graphical pattern generation.

## 🚀 Key Features

- **Clean, well-commented code** for readability and maintenance
- **Modular design** with proper procedure calls and register management
- **Comprehensive error handling** for robust program execution
- **User-friendly interfaces** with clear instructions and feedback
- **Efficient algorithms** implemented at the assembly level

## 📂 Repository Structure

```
MIPS_Assembly_Programs/ 
├── calculators/ 
│   ├── arithematic_ops.asm
│   ├── calculator.asm
│   ├── combination_calculator.asm
│   └── tax_calculator.asm
├── education/ 
│   └── grade_calculator.asm
├── graphics/ 
│   └── diamond_pattern.asm
└── math/ 
    ├── average.asm
    └── fibonacci.asm
```
## 📋 Program Descriptions

### Calculators

#### Arithmetic Operations ([`arithematic_ops.asm`](calculators/arithematic_ops.asm))
- Basic calculator supporting addition, subtraction, multiplication, and division
- Includes division-by-zero error handling
- Demonstrates fundamental arithmetic operations in MIPS

#### Advanced Calculator ([`calculator.asm`](calculators/calculator.asm))
- Multi-operand calculator with menu-based interface
- Supports operations on variable number of operands (2-10)
- Uses floating-point operations for precise calculations
- Implements comprehensive input validation and error handling

#### Combination Calculator ([`combination_calculator.asm`](calculators/combination_calculator.asm))
- Calculates mathematical combinations (nCr)
- Uses factorial calculations and optimizations for special cases
- Demonstrates advanced mathematical algorithm implementation

#### Tax Calculator ([`tax_calculator.asm`](calculators/tax_calculator.asm))
- Progressive tax calculation system with multiple tax brackets
- Uses floating-point arithmetic for precise tax calculations
- Implements conditional branching for tax bracket determination

### Education

#### Grade Calculator ([`grade_calculator.asm`](education/grade_calculator.asm))
- Calculates student grades based on midterm and final exam scores
- Supports multiple subjects with array-based storage
- Converts numerical scores to letter grades and CGPA
- Demonstrates array manipulation and data aggregation

### Graphics

#### Diamond Pattern Generator ([`diamond_pattern.asm`](graphics/diamond_pattern.asm))
- Generates customizable ASCII art diamond patterns
- Implements dynamic space and star placement algorithms
- Demonstrates nested loops and pattern generation techniques

### Math

#### Average Calculator ([`average.asm`](math/average.asm))
- Calculates the average of a dynamic set of numbers
- Handles array storage and processing
- Converts integer results to floating-point for precise averages

#### Fibonacci Sequence Generator ([`fibonacci.asm`](math/fibonacci.asm))
- Generates and displays Fibonacci sequences of user-specified length
- Implements efficient algorithm for sequence generation
- Handles special cases for small sequence lengths

## 🖥️ Sample Outputs

### Arithmetic Operations
When running the basic calculator (`arithematic_ops.asm`), you'll see:
- Prompts for two numbers
- Calculated result with appropriate formatting
- Error message for division by zero when applicable

```
----- Arithmetic Calculator -----

Please Enter First Number: 2

Please Enter Second Number: 6

Addition: 8
Subtraction: -4
Multiplication: 12
Division: 0

Do you want to continue? (1 for yes, 0 for no): 0

-- program is finished running --
```

### Grade Calculator
The grade calculator (`grade_calculator.asm`) produces:
- Summary of entered scores
- Calculated average for each subject
- Letter grade conversion
- Overall CGPA calculation

```
===== Student Grade Calculator =====

Please enter the midterm marks out of 40:
Subject #1 marks: 37
Subject #2 marks: 38
Subject #3 marks: 33
Subject #4 marks: 39
Subject #5 marks: 40

Please enter the final marks out of 60:
Subject #1 marks: 55
Subject #2 marks: 59
Subject #3 marks: 57
Subject #4 marks: 58
Subject #5 marks: 60

===== Results =====
Total marks: 476
CGPA: 4.0
Grade: A
Excellent

Do you want to calculate another grade? (1 for Yes, 0 for No): 0

-- program is finished running --
```

### Diamond Pattern
The diamond pattern generator (`diamond_pattern.asm`) creates customizable ASCII art:
- User-defined diamond size
- Precisely centered pattern
- Clean, symmetrical output

```
Enter diamond size (even number between 2-20, 0 to exit): 20
          *
         ***
        *****
       *******
      *********
     ***********
    *************
   ***************
  *****************
 *******************
*********************
 *******************
  *****************
   ***************
    *************
     ***********
      *********
       *******
        *****
         ***
          *

Enter diamond size (even number between 2-20, 0 to exit): 0

-- program is finished running --
```

### Fibonacci Sequence
The Fibonacci program (`fibonacci.asm`) displays:
- Sequence up to user-specified length
- Properly formatted number series
- Special handling for first terms

```
====== FIBONACCI SEQUENCE ======

Enter 0 or a negative number to exit the program.

Please enter the value of n (how many Fibonacci numbers to display): 14

Fibonacci Sequence (first 14 numbers):

0	1	1	2	3	5	8	13	21	34	55	89	144	233

```

## 🎓 Learning Path

For those new to MIPS assembly, consider following this progression:

1. Start with [`arithematic_ops.asm`](calculators/arithematic_ops.asm) to understand basic operations
2. Move to [`average.asm`](math/average.asm) to learn array manipulation
3. Try [`diamond_pattern.asm`](graphics/diamond_pattern.asm) for loop structures
4. Progress to more complex programs like [`grade_calculator.asm`](education/grade_calculator.asm)

## 💻 Technical Skills Demonstrated

- **Low-level programming** concepts and practices
- **Memory management** using MIPS registers and memory allocation
- **Floating-point operations** for precise calculations
- **Array manipulation** and dynamic memory usage
- **Subroutine implementation** with proper stack management
- **Input validation** and error handling
- **Bitwise operations** and register manipulation
- **Algorithm implementation** at the assembly level

## 🔧 Usage Instructions

### Prerequisites
- MIPS simulator such as MARS, SPIM, or QtSPIM
- Basic understanding of MIPS assembly language

### Running the Programs
1. Open your preferred MIPS simulator
2. Load the desired `.asm` file
3. Assemble and run the program
4. Follow on-screen instructions for program interaction

Example:
```bash
# To run the Fibonacci program using SPIM
spim -file math/fibonacci.asm
```

## 🌟 Why This Project Matters

This collection demonstrates proficiency in low-level programming and computer architecture concepts, essential skills for roles in:

- Embedded systems development
- System-level programming
- Compiler design
- Performance optimization
- Computer architecture research
- Operating systems development

The ability to work effectively with assembly language shows a deep understanding of how computers function at the hardware level, a valuable skill set for any software engineering role requiring performance optimization or system-level work.

## 📊 Performance Considerations

These programs were designed with efficiency in mind, demonstrating:

- Optimal register usage to minimize memory access
- Efficient loop structures
- Proper branch prediction considerations
- Minimal instruction count for core operations

## 👨‍💻 Author

Developed by a passionate software engineer with interests in low-level programming, computer architecture, and efficient algorithm implementation.

## 🤝 Contributing

Contributions to this MIPS Assembly collection are welcome! Here's how you can contribute:

### Getting Started
1. Fork the repository
2. Create a new branch (`git checkout -b feature/your-feature`)
3. Make your changes

### Coding Standards
- Use clear, descriptive labels for all procedures
- Include comprehensive comments explaining register usage
- Follow the existing formatting style (indentation, spacing)
- Document all procedures with input/output specifications

### Documentation
- Update the README.md with details of your program
- Add sample outputs where applicable
- Explain the purpose and functionality of your code

### Submitting Changes
1. Commit your changes (`git commit -m 'Add feature: description'`)
2. Push to your branch (`git push origin feature/your-feature`)
3. Open a Pull Request with detailed description

### Types of Contributions Welcome
- New MIPS assembly programs
- Optimizations to existing programs
- Documentation improvements
- Bug fixes and error handling enhancements

## 📝 License

This project is available for educational and reference purposes. Feel free to explore, modify, and learn from these examples.

---

*"Programming at the assembly level isn't just about performance; it's about understanding the foundation upon which all higher-level code runs."*