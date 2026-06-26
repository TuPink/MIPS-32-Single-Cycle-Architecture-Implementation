# 32-bit MIPS Single-Cycle CPU Architecture

##  Overview
This repository contains the Verilog/HDL implementation and simulation of a **MIPS-32 Single-Cycle Architecture Implementation**. The design strictly follows the MIPS architecture principles, where an entire instruction is fetched, decoded, executed, and written back within a single clock cycle.

The implementation explicitly separates the **Control Unit** and the **Datapath**, demonstrating hardware-level data routing using multiplexers and control signals.


##  Hardware Architecture & Datapath Mapping
Based on the datapath schematic, the system is divided into five classic execution stages, mapped directly to the implemented Verilog modules:

### 1. Instruction Fetch (IF)
* **`PC.v` (Program Counter):** A 32-bit register holding the address of the current instruction. A dedicated adder (`PC + 4`) computes the next sequential instruction address.
* **`INSTR_MEM.v` (Instruction Memory):** Receives the 32-bit address from the PC and outputs the 32-bit instruction code (`INSTR[31:0]`).
<img width="1920" height="810" alt="image" src="https://github.com/user-attachments/assets/82c7710c-26ab-4f08-af56-ae1d711b2f97" />

### 2. Instruction Decode (ID) & Register Read
* **`REG_FILE.v` (Register File):** Contains thirty-two 32-bit registers. 
  * Reads from two source registers: `RR1` (`INSTR[25:21]`) and `RR2` (`INSTR[20:16]`).
  * Writes to a destination register (`WR`), which is determined by a multiplexer controlled by the `REGDST` signal (choosing between `INSTR[20:16]` and `INSTR[15:11]`).
* **`SIGN_EXTEND.v`:** Takes the 16-bit immediate value (`INSTR[15:0]`) and sign-extends it to a 32-bit value for ALU operations or address calculations.

### 3. Execute (EX)
* **`ALU_32BIT.v` (Arithmetic Logic Unit):** Performs core mathematical and logical operations.
  * **Input A:** Directly connected to `RD1` from the Register File.
  * **Input B:** Controlled by the `ALUSRC` multiplexer (chooses between `RD2` and the `Sign_Extended` immediate).
  * Controlled by a 3-bit `ALUCONTROL` signal from the Control Unit.

### 4. Memory Access (MEM)
* **`DATA_MEMORY.v`:** Synchronous read/write memory block.
  * **Address:** Provided by the ALU result.
  * **Write Data:** Provided by `RD2` from the Register File.
  * Controlled by `MEMWRITE` and `MEMREAD` signals.

### 5. Write Back (WB)
* **Write Back Multiplexer:** Controlled by the `MEMTOREG` signal. It selects whether the `ALU_RESULT` or the `READ_DATA` (from Data Memory) travels back via the `WD` (Write Data) wire to the Register File.

##  Control Unit Signals
The **Control Unit** decodes the 6-bit Opcode (`INSTR[31:26]`) and generates the following control signals to route data through the multiplexers:
* `REGDST`: Asserts destination register (`rt` vs. `rd`).
* `REGWRITE`: Enables writing data to the Register File.
* `ALUSRC`: Selects ALU operand B (Register vs. Immediate).
* `MEMWRITE` / `MEMREAD`: Controls Data Memory access.
* `MEMTOREG`: Selects the data source for the Register File write-back stage.


**Huỳnh Thị Hồng Tú (Tupink)**
