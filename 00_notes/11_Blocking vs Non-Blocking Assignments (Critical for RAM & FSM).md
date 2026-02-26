Blocking vs Non-Blocking Assignments (Critical for RAM & FSM)

---

 1. Blocking Assignment (`=`)

 Meaning

➡ Executes immediately, line by line
➡ Next statement sees the new value

 Used for:

✔ Combinational logic
✔ ALU
✔ `always @()`

---

 Example (Combinational)

```verilog
always @(*) begin
    c = a + b;
    d = c + 1;
end
```

Hardware meaning:

```
a,b → adder → c → adder → d
```

Works correctly because:

 No clock
 No storage
 Pure logic

---

 2. Non-Blocking Assignment (`<=`)

 Meaning

➡ RHS is evaluated now
➡ LHS is updated after the clock edge

 Used for:

✔ Flip-flops
✔ RAM write
✔ FSM state
✔ `always @(posedge clk)`

---

 Example (Sequential)

```verilog
always @(posedge clk) begin
    a <= b;
    b <= a;
end
```

Hardware meaning:
Two flip-flops swap values on clock edge.

---

 3. What Goes Wrong If You Mix Them (Race Condition)

 ❌ Wrong (using blocking in sequential logic)

```verilog
always @(posedge clk) begin
    a = b;
    b = a;
end
```

Simulation:

 `a` updated first
 `b` gets NEW `a`
 Both become same value

Hardware:
Synthesis removes one register
Logic breaks

---

 4. RAM Example (Correct)

```verilog
always @(posedge clk) begin
    if (we)
        mem[addr] <= data_in;
end
```

Why `<=`?
Because RAM stores state
Write must happen on clock edge

---

 5. RAM Example (Wrong)

```verilog
always @(posedge clk) begin
    mem[addr] = data_in;
end
```

Problems:
❌ Race between write and read
❌ Simulation ≠ hardware
❌ Unstable behavior

---

 6. ALU Example (Correct)

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
Because:
✔ No memory
✔ No clock
✔ Pure logic

---

 7. Golden Rule (No Excuses)

```text
always @(*)        → use =
always @(posedge) → use <=
```

---

 8. ALU + RAM Feedback Loop (Your Conceptual Challenge)

If you do:

```verilog
always @(posedge clk) begin
    mem[addr] <= mem[addr] + 1;
end
```

This is safe because:

 Read happens
 ALU computes
 Write happens next edge

But if you try combinational feedback:

```verilog
assign mem[addr] = mem[addr] + 1;
```

That is:

```
mem → adder → mem → adder → mem → ...
```

That is:
❌ Oscillation
❌ Not synthesizable
❌ Unstable hardware

---

 9. Summary (No Sugarcoating)

| Situation | Operator |
| --------- | -------- |
| ALU       | `=`      |
| MUX       | `=`      |
| FSM state | `<=`     |
| RAM write | `<=`     |
| Counter   | `<=`     |
| Register  | `<=`     |

If you violate this:
➡ Your simulation may pass
➡ Your FPGA will fail


