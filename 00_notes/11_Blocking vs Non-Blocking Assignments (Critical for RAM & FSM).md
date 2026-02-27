# Blocking vs Non-Blocking Assignments

**(Critical for RAM & FSM Design)**

This document explains the difference between **blocking (`=`)** and **non-blocking (`<=`)** assignments in Verilog and why using the wrong one breaks hardware.

---

## 1. Blocking Assignment (`=`)

### Meaning

* Executes **immediately**
* Statements run **line by line**
* Next line sees the **updated value**

### Used For

* ✔ Combinational logic
* ✔ ALU
* ✔ MUX
* ✔ `always @(*)`

---

### Example (Combinational Logic)

```verilog
always @(*) begin
    c = a + b;
    d = c + 1;
end
```

### Hardware Meaning

```
a,b → adder → c → adder → d
```

Works correctly because:

* No clock
* No storage
* Pure logic

---

## 2. Non-Blocking Assignment (`<=`)

### Meaning

* RHS evaluated **now**
* LHS updated **after clock edge**

### Used For

* ✔ Flip-flops
* ✔ RAM write
* ✔ FSM state
* ✔ `always @(posedge clk)`

---

### Example (Sequential Logic)

```verilog
always @(posedge clk) begin
    a <= b;
    b <= a;
end
```

### Hardware Meaning

Two flip-flops swap values on the same clock edge.

---

## 3. What Goes Wrong If You Mix Them (Race Condition)

### ❌ Wrong: Blocking in Sequential Logic

```verilog
always @(posedge clk) begin
    a = b;
    b = a;
end
```

### Simulation Behavior

* `a` updated first
* `b` reads new `a`
* Both become equal

### Hardware Result

* One register optimized away
* Design breaks

---

## 4. RAM Example (Correct)

```verilog
always @(posedge clk) begin
    if (we)
        mem[addr] <= data_in;
end
```

Why `<=`?

* RAM stores state
* Write must occur on clock edge

---

## 5. RAM Example (Wrong)

```verilog
always @(posedge clk) begin
    mem[addr] = data_in;
end
```

### Problems

* ❌ Read/write race
* ❌ Simulation ≠ hardware
* ❌ Unstable behavior

---

## 6. ALU Example (Correct)

```verilog
always @(*) begin
    case(opcode)
        2'b00: out = a + b;
        2'b01: out = a - b;
        2'b10: out = a & b;
        2'b11: out = a | b;
    endcase
end
```

Why `=`?

* No memory
* No clock
* Pure logic

---

## 7. Golden Rule (No Exceptions)

```text
always @(*)         → use =
always @(posedge)  → use <=
```

Break this rule → expect bugs.

---

## 8. ALU + RAM Feedback Loop (Conceptual Trap)

### Safe (Sequential)

```verilog
always @(posedge clk) begin
    mem[addr] <= mem[addr] + 1;
end
```

Hardware sequence:

* Read
* ALU computes
* Write on next edge

---

### ❌ Unsafe (Combinational Feedback)

```verilog
assign mem[addr] = mem[addr] + 1;
```

Hardware meaning:

```
mem → adder → mem → adder → mem → ...
```

Result:

* ❌ Oscillation
* ❌ Not synthesizable
* ❌ Unstable hardware

---

## 9. Summary (No Sugarcoating)

| Situation | Operator |
| --------- | -------- |
| ALU       | `=`      |
| MUX       | `=`      |
| FSM state | `<=`     |
| RAM write | `<=`     |
| Counter   | `<=`     |
| Register  | `<=`     |

If you violate this:

* Simulation might pass
* FPGA will fail

---

**Bottom line:**
Blocking is for **logic**.
Non-blocking is for **memory**.

Confuse them → you are not designing hardware, you are writing lies.

---
