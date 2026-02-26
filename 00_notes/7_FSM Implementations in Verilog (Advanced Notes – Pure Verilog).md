FSM Implementations in Verilog (Advanced Notes – Pure Verilog)

---

 1. FSM with Counter

 Concept

An FSM with a counter is used when:

 A state must last for a fixed number of clock cycles
 Timing control is required

Example: stay in a state for 10 clocks, then go to DONE.

---

 FSM that counts 0 to 9 then goes to DONE (Pure Verilog)

```verilog
module fsm_with_counter (
    input clk, rst, start,
    output reg done
);

    // State encoding
    parameter IDLE = 2'b00,
              COUNT = 2'b01,
              DONE  = 2'b10;

    reg [1:0] state, next_state;
    reg [3:0] count;

    // State register
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Counter logic
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 0;
        else if (state == COUNT)
            count <= count + 1;
        else
            count <= 0;
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE  : if (start) next_state = COUNT;
            COUNT : if (count == 9) next_state = DONE;
            DONE  : next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        done = (state == DONE);
    end

endmodule
```

✔ FSM controls counter
✔ Counter affects next state

---

 2. FSM with Shift Register

 Concept

FSM controls when data should:

 Load
 Shift
 Stop

Used in:

 Serial communication
 Data framing
 Encryption

---

 FSM controlling a 4-bit left shift register (Pure Verilog)

```verilog
module fsm_shift_reg (
    input clk, rst, load,
    input [3:0] data_in,
    output reg [3:0] q
);

    // State encoding
    parameter IDLE  = 2'b00,
              LOAD  = 2'b01,
              SHIFT = 2'b10;

    reg [1:0] state, next_state;

    // State register
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Shift register operation
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 0;
        else begin
            case (state)
                LOAD  : q <= data_in;
                SHIFT : q <= {q[2:0], 1'b0};
                default: q <= q;
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE  : if (load) next_state = LOAD;
            LOAD  : next_state = SHIFT;
            SHIFT : next_state = SHIFT;
            default: next_state = IDLE;
        endcase
    end

endmodule
```

FSM controls when to load and when to shift.

---

 3. FSM with Serial Input (Sequence Detector)

 Concept

FSM reads input bit-by-bit and detects a pattern.

Example: detect 1011

---

 Moore FSM: Serial 1011 Detector (Pure Verilog)

```verilog
module fsm_serial (
    input clk, rst, in,
    output reg detected
);

    // State encoding
    parameter IDLE  = 3'b000,
              S1    = 3'b001,
              S10   = 3'b010,
              S101  = 3'b011,
              S1011 = 3'b100;

    reg [2:0] state, next_state;

    // State register
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = IDLE;
        case (state)
            IDLE  : if (in) next_state = S1;
            S1    : if (!in) next_state = S10; else next_state = S1;
            S10   : if (in) next_state = S101;
            S101  : if (in) next_state = S1011; else next_state = S10;
            S1011 : next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        detected = (state == S1011);
    end

endmodule
```

✔ Serial input
✔ FSM detects pattern
✔ Used in UART, protocols

---

 4. Testbench for FSMs (Pure Verilog)

 Purpose

Testbench should:

 Generate clock
 Apply reset
 Drive inputs
 Observe outputs

---

 Universal FSM Testbench Template

```verilog
module fsm_tb;

    reg clk, rst, in, start, load;
    reg [3:0] data_in;
    wire detected, done;
    wire [3:0] q;

    // Uncomment ONE DUT at a time

    //fsm_serial dut(clk, rst, in, detected);
    //fsm_with_counter dut(clk, rst, start, done);
    //fsm_shift_reg dut(clk, rst, load, data_in, q);

    always 5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        in = 0; start = 0; load = 0; data_in = 0;

        10 rst = 0;

        // For serial FSM
        in = 1; 10;
        in = 0; 10;
        in = 1; 10;
        in = 1; 10;

        // For shift register FSM
        load = 1; data_in = 4'b1010; 10;
        load = 0; 50;

        // For counter FSM
        start = 1; 10;
        start = 0; 200;

        $finish;
    end

    initial begin
        $dumpfile("fsm.vcd");
        $dumpvars(0,fsm_tb);
    end

endmodule
```

---

 Summary

| FSM Type             | Purpose                |
| -------------------- | ---------------------- |
| FSM + Counter        | Delay, timing, control |
| FSM + Shift Register | Serial data handling   |
| FSM + Serial Input   | Pattern detection      |
| FSM + Testbench      | Verification           |

FSM + Datapath = Complete digital system

---

 Design Rules (Important)

✔ Two-always block FSM
✔ Non-blocking (`<=`) in sequential logic
✔ Blocking (`=`) in combinational logic
✔ Always reset
✔ Always define default state
✔ Always simulate


