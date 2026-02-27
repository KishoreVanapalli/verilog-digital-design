# 🧪 Testbench Writing for Sequential Circuits in Verilog

**Topic:** Verification of Clocked Digital Circuits

**Circuits Covered:**
* D Flip-Flop
* Reset
* Counter
* Shift Register

**Purpose:**
To verify correct timing, state transitions, and output behavior of sequential circuits using simulation.

---

## 1. Role of Testbench for Sequential Circuits

Sequential circuits depend on:

* Clock edges
* Reset behavior
* Previous state

So a testbench must:

1. Generate a clock
2. Apply reset
3. Apply input changes
4. Observe outputs at clock edges
5. Check correct state transitions

Unlike combinational logic, stimulus must be synchronized with the clock.

---

## 2. General Structure of a Sequential Testbench

```verilog
module tb_seq;

    reg clk;
    reg rst;
    reg inputs;
    wire outputs;

    // DUT instantiation
    dut_module dut (
        .clk(clk),
        .rst(rst),
        .inputs(inputs),
        .outputs(outputs)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        // reset
        // input changes
    end

endmodule
```

**Main components:**

1. Signal declarations
2. DUT instantiation
3. Clock generator
4. Reset sequence
5. Input stimulus
6. Observation

---

## 3. Clock Generation

Clock is mandatory for sequential circuits.

```verilog
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
```

* Period = 10 time units
* Drives flip-flops, counters, and shift registers

---

## 4. Reset Handling in Testbench

Reset must be asserted at start.

```verilog
initial begin
    rst = 1;
    #20 rst = 0;
end
```

**Why reset is needed:**

* Avoids `X` states
* Initializes registers
* Matches real hardware behavior

---

## 5. Testbench for D Flip-Flop

**DUT Behavior:**
On every rising edge:

```
q <= d
```

### Testbench Code

```verilog
module tb_dff;

reg clk, rst, d;
wire q;

dff dut (.clk(clk), .rst(rst), .d(d), .q(q));

// Clock
always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    d = 0;

    #10 rst = 0;

    #10 d = 1;
    #10 d = 0;
    #10 d = 1;

    #50 $finish;
end

initial begin
    $monitor("T=%0t clk=%b d=%b q=%b", $time, clk, d, q);
end

endmodule
```

**What to check:**

* `q` changes only at clock edge
* `q` equals previous `d`
* Reset forces `q = 0`

---

## 6. Testbench for Counter

**DUT:** 4-bit up counter

```verilog
module tb_counter;

reg clk, rst;
wire [3:0] count;

up_counter dut (.clk(clk), .rst(rst), .count(count));

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;

    #12 rst = 0;
    #100 $finish;
end

initial begin
    $monitor("T=%0t count=%b", $time, count);
end

endmodule
```

**What to verify:**

```
0000 → 0001 → 0010 → … → 1111 → 0000
```

* Increments each clock
* Resets correctly
* Wraps properly

---

## 7. Testbench for MOD-N Counter (MOD-10)

```verilog
initial begin
    rst = 1;
    #10 rst = 0;

    repeat(15) begin
        @(posedge clk);
        $display("Count = %d", count);
    end

    $finish;
end
```

**Verify:**

* Resets at 9
* Returns to 0

---

## 8. Testbench for Shift Register

**DUT:** 4-bit right shift register

```verilog
module tb_shift;

reg clk, rst, sin;
wire [3:0] q;

shift_right dut (.clk(clk), .rst(rst), .sin(sin), .q(q));

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    sin = 0;

    #10 rst = 0;

    sin = 1; #10;
    sin = 0; #10;
    sin = 1; #10;
    sin = 1; #10;

    #50 $finish;
end

initial begin
    $monitor("T=%0t sin=%b q=%b", $time, sin, q);
end

endmodule
```

**Expected behavior:**

```
sin=1 → q=1000  
sin=0 → q=0100  
sin=1 → q=1010  
sin=1 → q=1101  
```

---

## 9. Event Control for Accurate Sampling

Better than using `#10`:

```verilog
@(posedge clk);
```

Example:

```verilog
d = 1;
@(posedge clk);
d = 0;
```

Ensures:

* Input stable before clock
* Sampling matches real hardware

---

## 10. Self-Checking Testbench (Counter Example)

```verilog
initial begin
    rst = 1; #10 rst = 0;
    repeat(16) begin
        @(posedge clk);
        if (count !== expected)
            $display("ERROR: count=%b expected=%b", count, expected);
        expected = expected + 1;
    end
end
```

Eliminates manual waveform checking.

---

## 11. Dumping Waveforms

```verilog
initial begin
    $dumpfile("seq.vcd");
    $dumpvars(0, tb_seq);
end
```

Used with GTKWave to visualize:

* Clock
* Reset
* Inputs
* Outputs

---

## 12. Common Testbench Mistakes

1. No clock generation
2. No reset applied
3. Changing input at clock edge
4. Not observing outputs at posedge
5. Forgetting `$finish`
6. Testing only one case

---

## 13. Combinational vs Sequential Testbench

| Feature       | Combinational | Sequential |
| ------------- | ------------- | ---------- |
| Clock         | Not required  | Required   |
| Reset         | Not needed    | Required   |
| Input timing  | Any time      | Clock sync |
| Output change | Immediate     | Clock edge |

---

## 14. Best Practices

1. Generate clean clock
2. Apply reset first
3. Change inputs between clock edges
4. Sample outputs at posedge
5. Use `$monitor` and waveforms
6. Prefer self-checking

---

## 15. Hardware Meaning of Testbench Stimulus

| Testbench Action     | Hardware Meaning |
| -------------------- | ---------------- |
| `always #5 clk=~clk` | Oscillator       |
| `rst=1`              | Reset line       |
| `@(posedge clk)`     | Flip-flop sample |
| `sin=1`              | Serial input     |
| `count`              | Register output  |

---

## 16. Why This is Important

If you can write testbenches for:
✔ D Flip-Flop
✔ Counter
✔ Shift Register

You can test:

* FSMs
* FIFOs
* UARTs
* Pipelines

---
