UART and Baud Rate – Complete Notes

---

 1. What is UART?

UART (Universal Asynchronous Receiver Transmitter) is a hardware communication block used to transmit and receive data serially.

It is:

 Universal – works between many devices
 Asynchronous – no clock line is shared
 Serial – data is sent one bit at a time

UART is not a bus like USB or Ethernet.
It is a peripheral circuit inside microcontrollers, FPGAs, or ICs.

---

 2. Physical Connection

UART uses only two data wires:

1. TX (Transmit)
2. RX (Receive)
3. GND (Ground)

Connection rule:

TX of device A → RX of device B
RX of device A → TX of device B

Ground must be common.

This allows full-duplex communication.

---

 3. Parallel to Serial Conversion

UART performs:

 Parallel → Serial at transmitter
 Serial → Parallel at receiver

Transmitter:

 Takes an 8-bit word
 Adds start, parity, stop bits
 Sends bits one by one

Receiver:

 Reads serial bits
 Removes overhead bits
 Reconstructs the byte

---

 4. UART Frame Format

Since UART has no clock line, framing bits are required.

Typical frame:

```id="5lfk2p"
| Start | Data Bits | Parity | Stop |
```

 Start Bit

 Line normally HIGH (1)
 Start bit is LOW (0)
 Signals beginning of data

 Data Bits

 5 to 9 bits (usually 8)
 Sent LSB first

 Parity Bit (optional)

 Error checking
 Even parity or Odd parity

 Stop Bit

 1 or 2 bits
 Line returns HIGH

---

 5. Baud Rate

Baud Rate = number of symbols per second

It defines how fast the line changes state.

Common values:

 9600
 19200
 38400
 57600
 115200

---

 6. Bit Rate vs Baud Rate

| Feature | Bit Rate        | Baud Rate          |
| ------- | --------------- | ------------------ |
| Meaning | Bits per second | Symbols per second |
| Focus   | Data speed      | Signal speed       |

Formula:

Bit Rate = Baud Rate × Bits per Symbol

For UART:
Bits per symbol = 1
So:
Bit Rate = Baud Rate

---

 7. Importance of Baud Rate

1. Synchronization
   UART has no clock → timing depends on baud rate

2. Sampling
   Receiver must sample at center of bit

3. Error prevention
   Mismatch > ~3% causes framing errors

---

 8. Oversampling

Receiver samples faster than baud rate:

 Usually 16× baud rate

Purpose:

 Detect start bit edge
 Align sampling to middle of bit
 Reduce noise impact

So internal tick = Baud × 16

---

 9. Baud Rate Generation

System clock is fast (e.g., 50 MHz)
Baud rate is slow (e.g., 9600)

So clock must be divided.

Formula:

```text
DIV = Clock_Frequency / (Baud_Rate × 16)
```

Example:

50 MHz, 9600 baud:

```text
DIV = 50,000,000 / (9600 × 16) ≈ 326
```

---

 10. Baud Rate Generator (Verilog)

```verilog id="m4xq8t"
module baud_gen (
    input clk,
    input rst,
    output reg tick
);

    parameter CLK_FREQ = 50000000;
    parameter BAUD = 9600;
    parameter DIV = CLK_FREQ / (BAUD  16);

    reg [15:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            tick <= 0;
        end
        else if (count == DIV-1) begin
            count <= 0;
            tick <= 1;
        end
        else begin
            count <= count + 1;
            tick <= 0;
        end
    end

endmodule
```

This produces a tick instead of a new clock.

---

 11. Use of Tick

Transmitter:

 Sends one bit per baud tick

Receiver:

 Uses 16 ticks per bit
 Samples in middle

UART = FSM + Shift Register + Baud Generator

---

 12. Advantages and Disadvantages

 Advantages

 Simple wiring
 No clock needed
 Widely supported
 Cheap

 Disadvantages

 Slower than SPI/I2C
 Must match baud rate
 No multi-master
 Limited frame size

---

 13. Serial vs Parallel

| Serial        | Parallel       |
| ------------- | -------------- |
| One wire      | Multiple wires |
| Slower        | Faster         |
| Cheaper       | Expensive      |
| Long distance | Short distance |

UART is serial → reliable for distance.

---

 14. Hardware View

```id="6ewp2h"
System Clock
     ↓
Baud Generator
     ↓
FSM (TX/RX control)
     ↓
Shift Register
     ↓
TX / RX Pin
```

---

 15. Key Points (Exam / Interview)

✔ UART is asynchronous
✔ Needs baud rate match
✔ Uses start and stop bits
✔ Receiver oversamples
✔ Baud generator divides clock
✔ FSM controls TX and RX

---

 Final Statement

UART communication depends entirely on:

1. Correct baud rate
2. Correct frame format
3. Accurate sampling

Without baud synchronization:
Data becomes meaningless.

