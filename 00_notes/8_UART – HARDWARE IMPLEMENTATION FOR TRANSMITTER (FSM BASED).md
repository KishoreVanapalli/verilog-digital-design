UART – HARDWARE IMPLEMENTATION FOR TRANSMITTER (FSM BASED)

---

 1. UART Transmitter Blocks

```
Data Register → Shift Register → TX pin
                    ↑
               FSM Controller
                    ↑
               Baud Counter
```

Blocks:

FSM → controls transmission sequence
Counter → provides baud timing
Shift register → shifts data bits out serially

---

 2. UART TX FSM States

| State | Function             |
| ----- | -------------------- |
| IDLE  | Line high, wait send |
| START | Send start bit (0)   |
| DATA  | Send 8 data bits     |
| STOP  | Send stop bit (1)    |

---

 3. UART Transmitter FSM (Verilog – no SystemVerilog)

```verilog
module uart_tx (
    input clk, rst,
    input send,
    input [7:0] data_in,
    output reg tx,
    output reg busy
);

    reg [1:0] state;
    reg [3:0] bit_cnt;
    reg [7:0] shift_reg;

    parameter IDLE=2'b00, START=2'b01, DATA=2'b10, STOP=2'b11;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            tx <= 1'b1;
            bit_cnt <= 0;
            busy <= 0;
        end else begin
            case(state)
                IDLE: begin
                    tx <= 1'b1;
                    busy <= 0;
                    if (send) begin
                        shift_reg <= data_in;
                        state <= START;
                        busy <= 1;
                    end
                end

                START: begin
                    tx <= 1'b0;      // start bit
                    bit_cnt <= 0;
                    state <= DATA;
                end

                DATA: begin
                    tx <= shift_reg[0];
                    shift_reg <= shift_reg >> 1;
                    bit_cnt <= bit_cnt + 1;
                    if (bit_cnt == 7)
                        state <= STOP;
                end

                STOP: begin
                    tx <= 1'b1;     // stop bit
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
```

---

 4. Baud Rate Generator (Transmitter)

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

FSM advances only on tick (baud timing).

---

 5. UART Transmitter Testbench (Basic)

```verilog
module uart_tx_tb;

    reg clk, rst, send;
    reg [7:0] data_in;
    wire tx;
    wire busy;

    uart_tx dut(clk, rst, send, data_in, tx, busy);

    always 5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; send = 0; data_in = 8'h00;
        20 rst = 0;

        data_in = 8'b10101010;
        send = 1; 10;
        send = 0;

        1000 $finish;
    end
endmodule
```

---

 6. Design Rule (Very Important)

✔ FSM → controls sequence
✔ Shift register → outputs bits
✔ Counter → controls timing
✔ UART TX = FSM + Counter + Shift register

---

 Hardware Meaning

 IDLE → TX = 1
 START → TX = 0
 DATA → TX = each bit
 STOP → TX = 1

Transmission format:

```
1 (idle) → 0 (start) → b0 b1 b2 b3 b4 b5 b6 b7 → 1 (stop)
```

LSB sent first.
