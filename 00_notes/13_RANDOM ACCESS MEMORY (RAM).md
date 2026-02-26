RANDOM ACCESS MEMORY (RAM)

---

 1. What is RAM?

RAM (Random Access Memory) is a storage block used to store data temporarily while a system operates.

It allows:

 Read data
 Write data
 Access any location directly (random access)

---

 2. RAM Structure

RAM consists of:

 Memory cells
 Address decoder
 Data input/output
 Control signals

Conceptually:

```text
Address → Memory Array → Data Out
           ↑
        Write Enable
```

---

 3. RAM Organization

RAM is described as:

```text
Depth × Width
```

Example:

 256 × 8 RAM
  = 256 locations
  = each location is 8 bits

Address bits = log₂(depth)

256 locations → 8 address bits

---

 4. RAM Signals

RAM typically has:

 Address bus
 Data input bus
 Data output bus
 Write enable
 Clock (for synchronous RAM)

---

 5. RAM Operations

 Write Operation:

 Occurs on clock edge
 Data is stored at given address
 Requires write enable

 Read Operation:

Two types:

1. Asynchronous read (output follows address)
2. Synchronous read (output updates on clock)

---

 6. Nature of RAM (Sequential)

RAM is:

 Sequential logic
 Has memory
 Uses clock for writing
 Stores previous values

Mathematically:

```text
Memory_next = f(Memory_current, data, address, control)
```

---

 7. RAM vs Register

| Feature | Register    | RAM          |
| ------- | ----------- | ------------ |
| Size    | Small       | Large        |
| Speed   | Fast        | Slower       |
| Storage | Single word | Many words   |
| Use     | Temporary   | Bulk storage |

---

 8. Address Decoding

In hardware:

 Decoder selects one row from memory
 Verilog does this using index:
  `memory[address]`

This hides physical decoding logic.

---

 9. RAM in Digital Systems

RAM is used for:

 Program storage
 Data storage
 Buffers
 FIFOs
 Lookup tables

---

 ⚖️ ALU vs RAM (Conceptual Difference)

| Feature  | ALU           | RAM            |
| -------- | ------------- | -------------- |
| Function | Compute       | Store          |
| Type     | Combinational | Sequential     |
| Clock    | Not needed    | Needed (write) |
| Memory   | No            | Yes            |
| Output   | Result        | Data           |

---

 🧠 ALU + RAM Together

In a real system:

```text
RAM → ALU → RAM
```

Process:

1. Read data from RAM
2. ALU processes it
3. Write result back to RAM

This requires:

 Clock
 Registers
 FSM controller

---

 🚨 Important Concept: Feedback Loop

If ALU output is directly connected back to RAM without clock:
→ Unstable
→ Oscillation
→ Invalid hardware

So:
RAM breaks feedback using clock

