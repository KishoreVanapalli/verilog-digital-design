Study Notes: Introduction to Verilog HDL

Topic: Hardware Description Languages & Digital Design
Level: Engineering / Industry-Oriented
Use: Exam + Interview + RTL Foundation

---

 1. Introduction to Hardware Description Languages (HDL)

Hardware Description Languages (HDLs) are specialized programming languages used to describe, model, simulate, and synthesize digital electronic systems such as logic circuits, processors, and controllers.

Unlike traditional programming languages (C, Java, Python) which execute instructions sequentially on a processor, HDLs are used to describe parallel hardware behavior. In hardware, multiple operations occur simultaneously, and HDLs capture this natural concurrency.

HDLs serve two major purposes:

1. Design – describing how a circuit should function.
2. Verification – checking whether the circuit behaves correctly using simulation.

 Common Hardware Description Languages

1. Verilog HDL

    Syntax similar to C language
    Widely used in industry for ASIC and FPGA design
    Supports behavioral, dataflow, and gate-level modeling

2. VHDL (VHSIC Hardware Description Language)

    Strongly typed and more verbose
    Common in defense, aerospace, and safety-critical systems

---

 2. Levels of Abstraction in Digital Design

Abstraction defines how much hardware detail is shown in the model.

 (a) System Level

Describes complete systems using algorithms and functional behavior without hardware detail.

 (b) Register Transfer Level (RTL)

Describes how data moves between registers under control of clock signals.
This is the most important level for synthesizable design.

RTL focuses on:

 Registers (flip-flops)
 Combinational logic
 Clocked behavior

 (c) Gate Level

Describes the circuit using logic gates (AND, OR, NOT, XOR, etc.).
Mainly used for post-synthesis verification.

---

 3. Modeling Styles in Verilog

A digital circuit can be described using three styles.

 Example: Half Adder

 1. Gate-Level Modeling

Circuit is built using logic gate primitives.

```verilog
xor (sum, a, b);
and (carry, a, b);
```

This represents physical gate connections.

 2. Dataflow Modeling

Uses continuous assignments with boolean expressions.

```verilog
assign sum = a ^ b;
assign carry = a & b;
```

This style shows how outputs are derived mathematically from inputs.

 3. Behavioral Modeling

Describes what the circuit does using procedural blocks.

```verilog
always @() begin
    sum = a ^ b;
    carry = a & b;
end
```

Behavioral style is closer to programming logic and easier for complex designs.

---

 4. Lexical Tokens in Verilog

Lexical tokens are the basic elements of Verilog syntax.

 (a) Identifiers

Names given to modules, signals, and variables.
Rules:

 Must start with a letter or underscore
 Can contain letters, numbers, underscore
 Case sensitive

Example: `clk`, `data_in`, `sum1`

---

 5. Number Representation

Verilog allows multiple number formats.

 General Format

```
<size>'<base><value>
```

Example:
`8'b10101010` → 8-bit binary
`16'h3F2A` → 16-bit hexadecimal
`10'd25` → 10-bit decimal

 Base Symbols

 `b` → Binary
 `o` → Octal
 `d` → Decimal
 `h` → Hexadecimal

If size and base are not specified, default is 32-bit decimal.

---

 6. Logic Value Levels

Verilog supports 4-state logic:

| Symbol | Meaning                                |
| ------ | -------------------------------------- |
| 0      | Logic Low                              |
| 1      | Logic High                             |
| X      | Unknown (uninitialized or conflict)    |
| Z      | High impedance (floating/disconnected) |

These extra values allow accurate simulation of real hardware behavior.

---

 7. Data Types in Verilog

 (a) Nets – `wire`

 Represents physical connections
 Cannot store values
 Must be continuously driven
 Default value is `Z`

Example:

```verilog
wire a, b, y;
assign y = a & b;
```

 (b) Registers – `reg`

 Used inside procedural blocks
 Can store values
 Do not necessarily mean physical registers unless clocked

Example:

```verilog
reg y;
always @() begin
    y = a & b;
end
```

---

 8. Continuous Assignment

Used with nets (`wire`).

```verilog
assign y = a & b;
```

This means whenever `a` or `b` changes, `y` updates automatically.

---

 9. Procedural Blocks

 The `always` Block

Used to describe behavior.

 Sensitivity List

 `always @(posedge clk)` → triggers on rising edge
 `always @(negedge clk)` → triggers on falling edge
 `always @()` → triggers on any input change

Example (combinational):

```verilog
always @() begin
    y = a & b;
end
```

Example (sequential):

```verilog
always @(posedge clk) begin
    q <= d;
end
```

---

 10. Blocking vs Non-Blocking Assignments

| Feature   | Blocking (`=`)      | Non-Blocking (`<=`) |
| --------- | ------------------- | ------------------- |
| Execution | Sequential          | Parallel            |
| Update    | Immediate           | End of time step    |
| Use       | Combinational logic | Sequential logic    |

 Blocking Example

```verilog
a = b;
c = a;
```

`c` gets new value of `a`.

 Non-Blocking Example

```verilog
a <= b;
c <= a;
```

`c` gets old value of `a`.

---

 11. Module Structure

A Verilog design is written inside a module.

```verilog
module my_logic(
    input a, b,
    output reg y
);
    always @() begin
        y = a & b;
    end
endmodule
```

A module contains:

 Port list (inputs, outputs)
 Internal signals
 Behavioral or structural logic

---

 12. Common Verilog Constructs

 If-Else

```verilog
if (a > b)
    y = a;
else
    y = b;
```

 Case Statement

```verilog
case(sel)
    2'b00: y = a;
    2'b01: y = b;
    2'b10: y = c;
    default: y = 0;
endcase
```

---

 13. Applications of Verilog

Verilog is widely used in:

1. ASIC Design – Custom chip development
2. FPGA Design – Reconfigurable hardware
3. DSP Systems – Filters, FFTs, codecs
4. Automotive Electronics – Engine control, ADAS
5. Networking Equipment – Routers, switches
6. Consumer Electronics – Cameras, phones, TVs

---

 14. Why Verilog is Important

 Industry-standard for RTL design
 Supports simulation and synthesis
 Bridges software logic with hardware implementation
 Required for VLSI, FPGA, and chip design careers


