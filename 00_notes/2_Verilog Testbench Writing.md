# 🧪 Verilog Testbench Writing

* **Topic:** Functional Verification using Testbenches
* **Level:** Engineering / Industry Foundation
* **Purpose:** Verify correctness of RTL designs before synthesis

---

## 1. Introduction to Testbench

A **testbench** is a Verilog module used to apply stimulus (inputs) to a **Design Under Test (DUT)** and observe its outputs.
It is **not synthesized** into hardware and exists only for simulation and verification.

### Main Objectives

1. Generate input signals
2. Apply test vectors
3. Monitor outputs
4. Check correctness
5. Report pass/fail

A testbench models the **environment around the circuit**, not the circuit itself.

---

## 2. Characteristics of a Testbench

A testbench:

* Has **no ports**
* Uses `reg` to drive DUT inputs
* Uses `wire` to receive DUT outputs
* Uses timing delays (`#`)
* Uses system tasks like:

  * `$display`
  * `$monitor`
  * `$dumpfile`
* Instantiates the DUT

Testbench is:

* ❌ Non-synthesizable
* ✅ Used only for simulation
* ❌ Not hardware logic

---

## 3. Basic Structure of a Testbench

A testbench consists of:

1. Signal declarations
2. DUT instantiation
3. Stimulus generation
4. Output observation
5. Simulation control

### General Template

```verilog
module tb_example;

    // Input signals to DUT
    reg a, b;

    // Output signals from DUT
    wire y;

    // Instantiate DUT
    my_module dut (
        .a(a),
        .b(b),
        .y(y)
    );

    // Stimulus block
    initial begin
        a = 0; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 0;
        #10 a = 1; b = 1;
    end

endmodule
```

---

## 4. `initial` Block in Testbench

The `initial` block:

* Executes once
* Allows delays
* Applies stimulus

Example:

```verilog
initial begin
    a = 0;
    b = 0;
    #10 a = 1;
    #10 b = 1;
end
```

Multiple `initial` blocks can be used.

---

## 5. Clock Generation

Clock is generated manually.

```verilog
reg clk;

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
```

Clock period = **10 time units**

---

## 6. Reset Generation

```verilog
reg rst;

initial begin
    rst = 1;
    #20 rst = 0;
end
```

Reset is asserted first, then deasserted.

---

## 7. Applying Test Vectors

```verilog
initial begin
    a = 0; b = 0;
    #10 a = 0; b = 1;
    #10 a = 1; b = 0;
    #10 a = 1; b = 1;
end
```

Simulates real-time signal behavior.

---

## 8. Monitoring Output

### Using `$monitor`

```verilog
initial begin
    $monitor("Time=%0t a=%b b=%b y=%b", $time, a, b, y);
end
```

### Using `$display`

```verilog
$display("Output = %b", y);
```

---

## 9. Waveform Dumping

```verilog
initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb_example);
end
```

Viewed using **GTKWave** or similar tools.

---

## 10. Self-Checking Testbench

```verilog
initial begin
    a = 0; b = 0; #10;
    if (y != (a & b)) $display("Error");

    a = 0; b = 1; #10;
    if (y != (a & b)) $display("Error");

    a = 1; b = 0; #10;
    if (y != (a & b)) $display("Error");

    a = 1; b = 1; #10;
    if (y != (a & b)) $display("Error");
end
```

Automatically checks correctness.

---

## 11. Delays in Testbench

* `#10` → Wait 10 time units
* `#5 clk = ~clk` → Toggle after 5 units

❌ Delays are **not synthesizable**

---

## 12. Sequential Circuit Testbench

```verilog
reg clk, d;
wire q;

always #5 clk = ~clk;

initial begin
    clk = 0;
    d = 0;
    #10 d = 1;
    #10 d = 0;
    #10 d = 1;
end
```

---

## 13. Task in Testbench

```verilog
task apply_input;
    input x, y;
    begin
        a = x;
        b = y;
        #10;
    end
endtask
```

Call:

```verilog
apply_input(0,1);
```

Improves reuse and readability.

---

## 14. Random Testing

```verilog
a = $random;
b = $random;
```

Useful for stress testing.

---

## 15. Ending Simulation

```verilog
#100 $finish;
```

or

```verilog
$stop;
```

---

## 16. Common Mistakes

1. Using `wire` for inputs
2. No clock generation
3. No reset
4. No waveform dump
5. Manual checking
6. Wrong port mapping

---

## 17. RTL vs Testbench

| RTL                          | Testbench         |
| ---------------------------- | ----------------- |
| Synthesizable                | Non-synthesizable |
| Hardware logic               | Stimulus logic    |
| Uses `always @(posedge clk)` | Uses `initial`    |
| No `#` delays                | Uses `#` delays   |

---

## 18. Importance of Testbench

* Finds logic errors early
* Prevents costly chip respins
* Enables waveform debugging
* Essential for verification engineers

---

## 19. Types of Testbenches

1. Directed
2. Random
3. Self-checking
4. Behavioral
5. Regression

---

## 20. Conclusion

A testbench is as important as RTL.

✔ Improves RTL quality
✔ Builds debugging skill
✔ Prepares for VLSI jobs
✔ Foundation for SystemVerilog & UVM

---
