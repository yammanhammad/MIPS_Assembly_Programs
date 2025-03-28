# MIPS Assembly Programs Collection

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

## 📝 License

This project is available for educational and reference purposes. Feel free to explore, modify, and learn from these examples.

---

*"Programming at the assembly level isn't just about performance; it's about understanding the foundation upon which all higher-level code runs."*