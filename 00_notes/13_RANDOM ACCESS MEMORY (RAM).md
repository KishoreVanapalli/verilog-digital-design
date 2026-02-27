# Random Access Memory (RAM)

---

## 1. What is RAM?

**RAM (Random Access Memory)** is a storage block used to store data temporarily while a system operates.

It allows:

* Read data
* Write data
* Access any location directly (**random access**)

---

## 2. RAM Structure

RAM consists of:

* Memory cells
* Address decoder
* Data input/output
* Control signals

Conceptual view:

```text id="ramstruct"
Address → Memory Array → Data Out
           ↑
        Write Enable
```

---

## 3. RAM Organization

RAM is described as:

```text id="ramorg"
Depth × Width
```

Example:

* **256 × 8 RAM**

  * 256 locations
  * each location is 8 bits

Address bits = log₂(depth)

```text id="addrbits"
256 locations → 8 address bits
```

---

## 4. RAM Signals

Typical RAM interface:

* Address bus
* Data input bus
* Data output bus
* Write enable
* Clock (for synchronous RAM)

---

## 5. RAM Operations

### Write Operation

* Occurs on clock edge
* Data stored at given address
* Requires write enable

### Read Operation

Two types:

1. **Asynchronous read** – output follows address
2. **Synchronous read** – output updates on clock

---

## 6. Nature of RAM (Sequential)

RAM is:

* Sequential logic
* Has memory
* Uses clock for writing
* Stores previous values

Mathematical form:

```text id="rammath"
Memory_next = f(Memory_current, data, address, control)
```

---

## 7. RAM vs Register

| Feature | Register    | RAM          |
| ------- | ----------- | ------------ |
| Size    | Small       | Large        |
| Speed   | Fast        | Slower       |
| Storage | Single word | Many words   |
| Use     | Temporary   | Bulk storage |

---

## 8. Address Decoding

In hardware:

* Decoder selects one row from memory

In Verilog:

```verilog
memory[address]
```

This hides the physical decoding logic.

---

## 9. RAM in Digital Systems

RAM is used for:

* Program storage
* Data storage
* Buffers
* FIFOs
* Lookup tables

---

## ⚖️ ALU vs RAM (Conceptual Difference)

| Feature  | ALU           | RAM            |
| -------- | ------------- | -------------- |
| Function | Compute       | Store          |
| Type     | Combinational | Sequential     |
| Clock    | Not needed    | Needed (write) |
| Memory   | No            | Yes            |
| Output   | Result        | Data           |

---

## 🧠 ALU + RAM Together

In a real system:

```text id="aluram"
RAM → ALU → RAM
```

Process:

1. Read data from RAM
2. ALU processes it
3. Write result back to RAM

This requires:

* Clock
* Registers
* FSM controller

---

## 🚨 Important Concept: Feedback Loop

If ALU output is directly connected back to RAM **without a clock**:

* ❌ Unstable
* ❌ Oscillation
* ❌ Invalid hardware

So:
**RAM breaks feedback using a clock.**

---

### Bottom Line

ALU computes.
RAM remembers.

Without RAM → no state.
Without ALU → no processing.

---
