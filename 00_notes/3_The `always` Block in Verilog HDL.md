# 🔁 The `always` Block in Verilog HDL

* **Topic:** Procedural Modeling of Hardware
* **Level:** RTL / Industry Foundation
* **Purpose:** Understand how Verilog `always` blocks map to real hardware

---

## 1. Introduction to the `always` Block

The `always` block is a **procedural block** in Verilog used to describe hardware behavior based on events such as signal changes or clock edges.

Unlike continuous assignments (`assign`), which are always active, an `always` block executes **only when an event in its sensitivity list occurs**.

### General Syntax

```verilog
always @(sensitivity_list) begin
    // procedural statements
end
```

The sensitivity list defines **when** the block is triggered.

---

## 2. Types of Hardware Modeled Using `always`

The `always` block can model:

1. **Combinational Logic**
2. **Sequential Logic (Flip-Flops / Registers)**

The inferred hardware depends on:

* Sensitivity list
* Assignment type (`=` or `<=`)
* Coding style

---

## 3. Sequential Logic Using `always`

Sequential logic stores state and changes only on clock edges.

### Flip-Flop Modeling

```verilog
always @(posedge clk) begin
    q <= d;
end
```

### Hardware Inference

* D flip-flop
* Triggered on rising edge
* `q` holds value between edges

### Key Points

* Must use `posedge` or `negedge`
* Must use **non-blocking (`<=`)**
* Represents memory

---

## 4. Combinational Logic Using `always`

Combinational logic depends only on current inputs.

```verilog
always @(*) begin
    y = (a & b) | c;
end
```

### Hardware Inference

* Logic gates (AND, OR, etc.)
* No memory

### Key Points

* Use `always @(*)`
* Use blocking (`=`)
* Assign output in **all paths**

---

## 5. Sensitivity List

Defines when the block runs.

### Types

**Edge-based**

```verilog
always @(posedge clk)
```

**Level-based**

```verilog
always @(a or b or c)
```

**Wildcard**

```verilog
always @(*)
```

### Importance

* Missing signals → simulation mismatch
* Wrong sensitivity → latches or stale outputs

---

## 6. Blocking vs Non-Blocking

| Feature     | Blocking (`=`) | Non-Blocking (`<=`) |
| ----------- | -------------- | ------------------- |
| Execution   | Sequential     | Parallel            |
| Update      | Immediate      | End of timestep     |
| Typical use | Combinational  | Sequential          |
| Hardware    | Gates          | Flip-flops          |

---

## 7. Why Non-Blocking for Sequential Logic

### Correct

```verilog
always @(posedge clk) begin
    q1 <= ~q2;
    q2 <= q1;
end
```

✔ Two flip-flops
✔ Sample old values
✔ Update together

---

### Incorrect

```verilog
always @(posedge clk) begin
    q1 = ~q2;
    q2 = q1;
end
```

❌ Race-through
❌ Second FF removed
❌ Hardware behavior wrong

---

## 8. Latch Inference

A latch is inferred when output is **not assigned in all paths**.

### Bad

```verilog
always @(*) begin
    if (sel)
        y = a;
end
```

→ Latch inferred

---

### Correct

```verilog
always @(*) begin
    if (sel)
        y = a;
    else
        y = b;
end
```

or

```verilog
always @(*) begin
    y = b;
    if (sel)
        y = a;
end
```

---

## 9. Multiplexer Example

```verilog
always @(*) begin
    case (sel)
        2'b00: y = a;
        2'b01: y = b;
        2'b10: y = c;
        2'b11: y = d;
        default: y = 1'b0;
    endcase
end
```

✔ 4:1 MUX
✔ No memory
✔ Default avoids latch

---

## 10. Clock + Reset

```verilog
always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 1'b0;
    else
        q <= d;
end
```

Hardware:

* Flip-flop with **async reset**

---

## 11. `always` vs `assign`

| Feature    | always             | assign          |
| ---------- | ------------------ | --------------- |
| Style      | Procedural         | Continuous      |
| Timing     | Event-based        | Always active   |
| Complexity | if/case/loops      | Expression only |
| Used for   | Seq & complex comb | Simple comb     |

---

## 12. Common Coding Errors

1. Blocking (`=`) in clocked logic
2. Missing signals in sensitivity list
3. Output not assigned in all paths
4. Mixing `=` and `<=` randomly
5. Unintended latches
6. Using `#` delays in RTL

---

## 13. Best Practices

✔ `always @(posedge clk)` for registers
✔ `always @(*)` for combinational
✔ `<=` for sequential
✔ `=` for combinational
✔ Assign outputs in all paths
✔ Separate comb & seq logic
✔ Never rely on simulation order

---

## 14. Hardware Mapping Summary

| Coding Style                   | Hardware    |
| ------------------------------ | ----------- |
| `always @(posedge clk)` + `<=` | Flip-flops  |
| `always @(*)` + `=`            | Logic gates |
| Missing assignment             | Latches     |
| Blocking in clocked            | Corruption  |

---

## 15. Importance of `always` Block

* Core of RTL design
* Maps code to hardware
* Controls timing & storage
* Used in FSMs, counters, pipelines
* Foundation for SystemVerilog & UVM

---

✅ This README is:

* Recruiter-readable
* Interview useful
* PD/RTL aligned
* GitHub ready

---
