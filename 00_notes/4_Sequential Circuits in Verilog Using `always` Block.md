# 🔄 Sequential Circuits in Verilog using `always` Block

**Topics Covered:**
* D Flip-Flop
* Reset
* Counter
* Shift Register

**Purpose:**
To understand how clocked `always` blocks model real hardware storage elements such as registers, counters, and shift registers.

---

## 1. Sequential Logic Overview

Sequential logic differs from combinational logic because:

* It has **memory**
* Output depends on **current input + previous state**
* Controlled by a **clock signal**

Implemented using:

* Flip-flops
* Registers
* Feedback logic

In Verilog, sequential logic is modeled using:

```verilog
always @(posedge clk)
```

This tells the synthesis tool to infer **edge-triggered flip-flops**.

---

## 2. D Flip-Flop (DFF)

### Definition

A D Flip-Flop stores **1 bit of data**.
On every active clock edge:

```
q ← d
```

Between clock edges, `q` holds its value.

---

### Verilog Code

```verilog
module dff(
    input clk,
    input d,
    output reg q
);

always @(posedge clk) begin
    q <= d;
end

endmodule
```

---

### Hardware Inferred

* One D flip-flop
* Rising-edge triggered
* Memory element

---

### Important Rule

✔ Always use **non-blocking (`<=`)** for flip-flops.

---

## 3. Reset in Sequential Circuits

Reset forces registers into a known state (usually 0).

### Why Reset is Needed

* Avoids `X` (unknown) states
* Initializes hardware
* Ensures predictable startup

---

### 3.1 Asynchronous Reset

Reset acts immediately (independent of clock).

```verilog
always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 1'b0;
    else
        q <= d;
end
```

**Hardware:**

* Flip-flop with async clear pin

**Characteristics:**

* Fast response
* Used for power-on reset
* Can cause timing issues if not synchronized

---

### 3.2 Synchronous Reset

Reset works only on clock edge.

```verilog
always @(posedge clk) begin
    if (rst)
        q <= 1'b0;
    else
        q <= d;
end
```

**Hardware:**

* Reset logic inside data path
* More timing-safe

---

## 4. Counter

### Definition

A counter is a register that increments or decrements on each clock edge.

---

### 4.1 4-Bit Up Counter

```verilog
module up_counter(
    input clk,
    input rst,
    output reg [3:0] count
);

always @(posedge clk) begin
    if (rst)
        count <= 4'b0000;
    else
        count <= count + 1;
end

endmodule
```

**Hardware:**

* 4 flip-flops
* Adder logic
* Feedback path

**Sequence:**

```
0000 → 0001 → 0010 → ... → 1111 → 0000
```

---

### 4.2 Down Counter

```verilog
always @(posedge clk) begin
    if (rst)
        count <= 4'b1111;
    else
        count <= count - 1;
end
```

---

### 4.3 Enable-Controlled Counter

```verilog
always @(posedge clk) begin
    if (rst)
        count <= 0;
    else if (en)
        count <= count + 1;
    else
        count <= count;
end
```

**Hardware:**

* Multiplexer before flip-flops
* Holds value when disabled

---

### 4.4 MOD-N Counter (MOD-10 Example)

```verilog
always @(posedge clk) begin
    if (rst)
        count <= 0;
    else if (count == 9)
        count <= 0;
    else
        count <= count + 1;
end
```

---

## 5. Shift Register

### Definition

A shift register moves data left or right by one bit on each clock edge.

Used in:

* Serial-to-parallel conversion
* Data buffering
* Communication systems

---

### 5.1 Right Shift Register (4-bit)

```verilog
module shift_right(
    input clk,
    input rst,
    input sin,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (rst)
        q <= 4'b0000;
    else
        q <= {sin, q[3:1]};
end

endmodule
```

**Operation:**

```
q[3] ← sin  
q[2] ← q[3]  
q[1] ← q[2]  
q[0] ← q[1]  
```

---

### 5.2 Left Shift Register

```verilog
always @(posedge clk) begin
    if (rst)
        q <= 0;
    else
        q <= {q[2:0], sin};
end
```

---

### 5.3 Parallel Load Shift Register

```verilog
module shift_load(
    input clk,
    input rst,
    input load,
    input [3:0] data,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (rst)
        q <= 0;
    else if (load)
        q <= data;
    else
        q <= {q[2:0], 1'b0};
end

endmodule
```

**Hardware:**

* Multiplexer selects load or shift
* Flip-flops store data

---

## 6. Common Rules for Sequential Circuits

1. Use `always @(posedge clk)`
2. Use non-blocking (`<=`)
3. Always handle reset
4. One register group per always block
5. No delays (`#`) in RTL
6. No blocking assignment in clocked logic

---

## 7. Hardware Mapping Summary

| Code Pattern         | Hardware        |
| -------------------- | --------------- |
| `q <= d`             | D Flip-Flop     |
| `if (rst)`           | Reset control   |
| `count <= count + 1` | Counter         |
| `{q[2:0], sin}`      | Shift register  |
| `<=`                 | Register update |
| `posedge clk`        | Clocked storage |

---

## 8. Importance of These Blocks

These structures form the basis of:

* Registers
* Timers
* FSMs
* Pipelines
* FIFOs
* UARTs
* Memory controllers

---
