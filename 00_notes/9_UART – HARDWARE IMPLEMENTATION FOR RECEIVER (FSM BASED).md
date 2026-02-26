UART – HARDWARE IMPLEMENTATION FOR RECEIVER (FSM BASED)

 1. UART Receiver Blocks

```
RX pin → FSM → Shift Register → Data Register
              ↑
         Baud Counter
```

Blocks:

 FSM (controls states)
 Counter (baud timing)
 Shift register (stores bits)

---

 2. UART RX FSM States

| State | Function               |
| ----- | ---------------------- |
| IDLE  | Wait for start bit     |
| START | Align to middle of bit |
| DATA  | Receive 8 bits         |
| STOP  | Check stop bit         |

---

 3. UART Receiver FSM (Verilog – no SystemVerilog)

```verilog
module uart_rx (
    input clk, rst,
    input rx,
    output reg [7:0] data_out,
    output reg data_ready
);

    reg [1:0] state;
    reg [3:0] bit_cnt;
    reg [7:0] shift_reg;

    parameter IDLE=2'b00, START=2'b01, DATA=2'b10, STOP=2'b11;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            bit_cnt <= 0;
            data_ready <= 0;
        end else begin
            case(state)
                IDLE: begin
                    data_ready <= 0;
                    if (!rx)
                        state <= START;
                end

                START: begin
                    state <= DATA;
                    bit_cnt <= 0;
                end

                DATA: begin
                    shift_reg <= {rx, shift_reg[7:1]};
                    bit_cnt <= bit_cnt + 1;
                    if (bit_cnt == 7)
                        state <= STOP;
                end

                STOP: begin
                    data_out <= shift_reg;
                    data_ready <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
```

---

 4. Baud Rate Generator

Formula:

Divider = Clock / Baud

Example:
Clock = 50 MHz
Baud = 9600

Divider ≈ 5208

```verilog
module baud_gen(
    input clk,
    output reg tick
);
    reg [12:0] count;
    parameter DIV = 5208;

    always @(posedge clk) begin
        if (count == DIV-1) begin
            count <= 0;
            tick <= 1;
        end else begin
            count <= count + 1;
            tick <= 0;
        end
    end
endmodule
```

---

 5. UART Testbench (Basic)

```verilog
module uart_tb;
    reg clk, rst, rx;
    wire [7:0] data_out;
    wire data_ready;

    uart_rx dut(clk, rst, rx, data_out, data_ready);

    always 5 clk = ~clk;

    initial begin
        clk=0; rst=1; rx=1;
        20 rst=0;

        // Send start bit
        rx=0; 100;
        // Send 10101010 (LSB first)
        rx=0; 100;
        rx=1; 100;
        rx=0; 100;
        rx=1; 100;
        rx=0; 100;
        rx=1; 100;
        rx=0; 100;
        rx=1; 100;
        // Stop bit
        rx=1; 100;

        200 $finish;
    end
endmodule
```

---

 6. Design Rule (Very Important)

✔ FSM = control
✔ Shift register = data
✔ Counter = timing
✔ UART = FSM + Counter + Shift register

---

 Bottom Line (No sugarcoating)

If you know only:

> start bit, stop bit

→ You know theory

