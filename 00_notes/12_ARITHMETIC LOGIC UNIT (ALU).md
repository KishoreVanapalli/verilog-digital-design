# Arithmetic Logic Unit (ALU)

---

## 1. What is an ALU?

An **ALU (Arithmetic Logic Unit)** is a **combinational digital circuit** that performs arithmetic and logical operations on binary data.

It is the core computation block inside:

* CPU
* Microcontroller
* DSP
* FPGA datapath

**Important:**
An ALU **does not store data**.
It only processes inputs and produces outputs.

---

## 2. Inputs and Outputs of an ALU

### Inputs

* Operand A (e.g., 8-bit)
* Operand B (e.g., 8-bit)
* Control signal / **Opcode** (selects operation)

### Outputs

* Result (same width as inputs)
* Status flags

---

## 3. ALU Operations

### Arithmetic Operations

* Addition (A + B)
* Subtraction (A − B)
* Increment / Decrement
* Compare

### Logical Operations

* AND
* OR
* XOR
* NOT

### Shift Operations (optional)

* Logical shift left
* Logical shift right
* Arithmetic shift

---

## 4. ALU Control (Opcode)

The ALU does **not** decide what to do by itself.
It is controlled by an opcode from a controller or FSM.

Example:

| Opcode | Operation |
| ------ | --------- |
| 00     | Add       |
| 01     | Subtract  |
| 10     | AND       |
| 11     | OR        |

Opcode works like a **MUX select line** inside the ALU.

---

## 5. ALU Flags (Status Bits)

ALU produces flags describing the result:

* **Zero (Z):** Result = 0
* **Carry (C):** Carry out from MSB
* **Negative (N):** MSB = 1
* **Overflow (V):** Signed overflow

Used for:

* Branching
* Comparisons
* Decision making

---

## 6. Nature of ALU (Combinational)

ALU is:

* Pure combinational logic
* No clock required
* Output changes immediately with input

Mathematically:

```text
Output = f(A, B, Opcode)
```

There is:

* No memory
* No state
* No timing dependency

---

## 7. Hardware View of ALU

Internally contains:

* Adders
* Logic gates
* Shifters
* Multiplexers

Final output is selected by:
→ **MUX controlled by opcode**

So conceptually:

```text
Many operations → One selector → Output
```

---

## 8. Role of ALU in a System

ALU is part of the datapath:

```text
Register → ALU → Register
```

ALU never works alone.
It is always surrounded by:

* Registers
* RAM
* Controller (FSM)

---

### Bottom Line

ALU = **calculator of digital hardware**
It computes, but never remembers.

---

