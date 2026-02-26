Study Notes: The `always` Block in Verilog HDL

Topic: Procedural Modeling of Hardware
Level: RTL / Industry Foundation
Purpose: To understand how Verilog `always` blocks map to real hardware

---

 1. Introduction to the `always` Block

The `always` block is a procedural block in Verilog used to describe hardware behavior that depends on events such as signal changes or clock edges.

Unlike continuous assignments (`assign`), which are always active, an `always` block executes only when an event in its sensitivity list occurs.

General syntax:

```verilog
always @(sensitivity_list) begin
    // procedural statements
end
```

The sensitivity list defines when the block is triggered.

---

 2. Types of Hardware Modeled Using `always`

The `always` block can model two major categories of hardware:

1. Combinational Logic
2. Sequential Logic (Flip-Flops / Registers)

The type of hardware inferred depends entirely on:

 Sensitivity list
 Assignment type (`=` or `<=`)
 Coding style

---

 3. Sequential Logic Using `always`

Sequential logic stores state and changes only on clock edges.

 Syntax for Flip-Flop Modeling:

```verilog
always @(posedge clk) begin
    q <= d;
end
```

 Hardware Inference:

 A D flip-flop is inferred
 Triggered on rising edge of clock
 `q` holds its value between clock edges

 Key Points:

 Must use edge-based sensitivity list (`posedge` or `negedge`)
 Must use non-blocking assignment (`<=`)
 Represents memory (register)

---

 4. Combinational Logic Using `always`

Combinational logic output depends only on current inputs.

 Syntax:

```verilog
always @() begin
    y = (a & b) | c;
end
```

 Hardware Inference:

 Logic gates (AND, OR, etc.)
 No memory elements

 Key Points:

 Use `always @(*)` or list all inputs manually
 Use blocking assignment (`=`)
 Output must be assigned in all paths

---

 5. Sensitivity List

The sensitivity list defines the signals that trigger execution.

 Types:

1. Edge-based

```verilog
always @(posedge clk)
```

2. Level-based

```verilog
always @(a or b or c)
```

3. Wildcard

```verilog
always @(*)
```

 Importance:

 Missing signals cause simulation mismatch
 Incorrect sensitivity causes unintended latches or stale outputs

---

 6. Blocking vs Non-Blocking Assignments

| Feature         | Blocking (`=`)      | Non-Blocking (`<=`) |
| --------------- | ------------------- | ------------------- |
| Execution order | Sequential          | Parallel            |
| Update time     | Immediate           | End of timestep     |
| Typical use     | Combinational logic | Sequential logic    |
| Hardware type   | Logic gates         | Flip-flops          |

---

 7. Why Non-Blocking is Required for Sequential Logic

Consider two registers in a shift structure.

 Correct (Non-Blocking):

```verilog
always @(posedge clk) begin
    q1 <= ~q2;
    q2 <= q1;
end
```

 Hardware:

 Two flip-flops
 Both sample old values at clock edge
 Values update simultaneously

---

 Incorrect (Blocking):

```verilog
always @(posedge clk) begin
    q1 = ~q2;
    q2 = q1;
end
```

 Effect:

 `q2` uses new `q1` immediately
 Synthesis collapses logic
 Second flip-flop is removed
 Hardware behavior is wrong

This causes race-through, which cannot exist physically.

---

 8. Latch Inference in `always`

A latch is inferred when:

 Output is not assigned in all execution paths

 Example (Bad):

```verilog
always @(*) begin
    if (sel)
        y = a;
end
```

 Hardware:

 Level-sensitive latch inferred
 `y` holds old value when `sel = 0`

---

 Correct:

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
always @() begin
    y = b;
    if (sel)
        y = a;
end
```

---

 9. Modeling a Multiplexer Using `always`

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

 Hardware:

 4-to-1 multiplexer
 No memory
 Pure combinational logic

Default case prevents latch creation.

---

 10. Clock + Reset in `always`

Sequential logic with reset:

```verilog
always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 1'b0;
    else
        q <= d;
end
```

 Hardware:

 D flip-flop with asynchronous reset

---

 11. `always` vs `assign`

| Feature    | always                          | assign            |
| ---------- | ------------------------------- | ----------------- |
| Style      | Procedural                      | Continuous        |
| Timing     | Event-based                     | Always active     |
| Complexity | Can contain if/case/loops       | Expression only   |
| Used for   | Sequential & complex comb logic | Simple comb logic |

---

 12. Common Coding Errors

1. Using blocking (`=`) in clocked logic
2. Missing signals in sensitivity list
3. Not assigning outputs in all paths
4. Mixing `=` and `<=` randomly
5. Creating unintended latches
6. Using delays (``) in `always` for RTL

---

 13. Best Practices

1. Use `always @(posedge clk)` for registers
2. Use `always @()` for combinational logic
3. Use `<=` for sequential logic
4. Use `=` for combinational logic
5. Initialize or assign outputs in all paths
6. Separate combinational and sequential blocks
7. Never rely on simulation order

---

 14. Hardware Interpretation Summary

| Coding Style                   | Hardware Created |
| ------------------------------ | ---------------- |
| `always @(posedge clk)` + `<=` | Flip-flops       |
| `always @(*)` + `=`            | Logic gates      |
| Missing assignments            | Latches          |
| Blocking in clocked logic      | Logic corruption |

---

 15. Importance of the `always` Block

 Core of RTL design
 Maps software-style code to real hardware
 Controls timing and storage
 Essential for FSMs, counters, pipelines
 Foundation for SystemVerilog and UVM
