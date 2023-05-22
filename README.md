# Computer-Architecture
Projects I made in Computer Architecture. I use emu8086 for my projects


## Table of Contents
- [Computer Architecture](#computer-architecture)
- [Processor](#processor)
- [Memory](#memory)
- [Data Bus & Data Sizes](#data-bus--data-sizes)
- [Applications](#applications)
  - [Logical-Arithmetic](#logical-arithmetic)

# Computer Architecture

> Computer architecture is the organisation of the components which make up a computer system and the meaning of the operations which guide its function. It defines what is seen on the machine interface, which is targeted by programming languages and their compilers. 

### Where Does It Live?

#### Processor
- Current instruction being executed

#### Memory
- Global variables
- Local variables
- Running program code

#### Disk Drive
- Source code
- Compiled executable (before it executes)


# Processor

> Processor or processing unit is an electrical component (digital circuit) that performs operations on an external data source, usually memory or some other data stream.

#### Instruction Cycle
- Fetch -> a instruction from memory
- Decode -> the instruction
- Execute -> perform the operation

![image](https://user-images.githubusercontent.com/102357822/232050296-974a6a4b-ef9e-4303-94a8-4f57a16f79ea.png)

## Processor Components
- ALU -> performs arithmetic and logical instructions
- Registers -> fast and temporary storage locations (because memory is slow) (store input and output)
- Control Circuitry -> decode instruction, control alu and select registers to be used

Connects to memory and I/O via **address**, **data** and **control** buses. (bus=group of wires)

![Screenshot 2023-04-14 155615](https://user-images.githubusercontent.com/102357822/232049838-8e3ae109-0321-4358-8079-662ddacc3c1e.png)

#### Other Registers
- Program Counter/Instruction Pointer (PC/IP) Reg -> holds the address of the next instruction to fetch


# Memory

> Set of cells that each store a group of bits. (usually 1 byte (8 bits) per cell)

> Unique address (number) assigned to each cell. (used to reference the value in that location)

> **Data** and **instructions** are both stored in memory.

> Have an **address**, **data** and **conrol** bus to perform operations.

#### Performs two Operations
- Read -> retrieves data value in a particular location
- Write -> changes data in a location to a new value

> Processor perform reads and writes to communicate with memory and I/O devices.

> I/O devices have memory locations that contain data that processor can access.


# Data Bus & Data Sizes

> More transistors meant greater bit-widhts (data bus widht)

> Processors can use 8, 16, 32, 64 bits of the bus in asingle accesss based on the size of data

### x86-64 Data Sizes
> Instructions generally specify what size data to access from memory and then operate upon.

#### Integer              
- Byte (B) -> 8 bits        
- Word (W) -> 16 bits
- Double Word (L) -> 32 bits
- Quad Word (Q) -> 64 bits


#### Floating Point
 - Single (S) -> 32 bits
 - Double (D) -> 64 bits


# Applications
# Logical-Arithmetic
