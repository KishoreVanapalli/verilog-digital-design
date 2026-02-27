# UART and Baud Rate – Complete Notes

This document explains **UART communication** and **baud rate generation** from a hardware and system perspective.

---

## 1. What is UART?

**UART (Universal Asynchronous Receiver Transmitter)** is a hardware communication block used to transmit and receive data serially.

It is:

* **Universal** – works with many devices
* **Asynchronous** – no shared clock line
* **Serial** – data sent one bit at a time

UART is **not a bus** like USB or Ethernet.
It is a **peripheral circuit** inside microcontrollers, FPGAs, or SoCs.

---

## 2. Physical Connection

UART uses only two data wires:

1. **TX** – Transmit
2. **RX** – Receive
3. **GND** – Common ground

### Connection Rule

```
TX (Device A) → RX (Device B)
RX (Device A) → TX (Device B)
```

Ground must be common.

This enables **full-duplex communication**.

---

## 3. Parallel to Serial Conversion

UART performs:

* **Parallel → Serial** at transmitter
* **Serial → Parallel** at receiver

### Transmitter

* Takes an 8-bit word
* Adds start, parity, and stop bits
* Sends bits one by one

### Receiver

* Reads serial bits
* Removes framing bits
* Reconstructs the byte

---

## 4. UART Frame Format

Since UART has no clock line, framing bits are required.

```
| Start | Data Bits | Parity | Stop |
```

### Start Bit

* Line is normally HIGH (1)
* Start bit is LOW (0)
* Indicates beginning of data

### Data Bits

* 5 to 9 bits (usually 8)
* Sent **LSB first**

### Parity Bit (Optional)

* Error detection
* Even or Odd parity

### Stop Bit

* 1 or 2 bits
* Line returns to HIGH

---

## 5. Baud Rate

**Baud Rate = number of symbols per second**

It defines how fast the signal changes.

Common values:

* 9600
* 19200
* 38400
* 57600
* 115200

---

## 6. Bit Rate vs Baud Rate

| Feature | Bit Rate        | Baud Rate          |
| ------- | --------------- | ------------------ |
| Meaning | Bits per second | Symbols per second |
| Focus   | Data speed      | Signal speed       |

Formula:

```
Bit Rate = Baud Rate × Bits per Symbol
```

For UART:

```
Bits per Symbol = 1
Bit Rate = Baud Rate
```

---

## 7. Importance of Baud Rate

1. **Synchronization**
   UART has no clock → timing depends only on baud rate

2. **Sampling**
   Receiver must sample at the center of each bit

3. **Error Prevention**
   Baud mismatch > ~3% causes framing errors

---

## 8. Oversampling

Receiver samples faster than baud rate:

* Typically **16× baud rate**

Purpose:

* Detect start bit edge
* Align sampling to middle of bit
* Reduce noise effects

So internal tick =

```
Baud × 16
```

---

## 9. Baud Rate Generation

System clock is fast (e.g., 50 MHz).
Baud rate is slow (e.g., 9600).

So clock must be divided.

Formula:

```
DIV = Clock_Frequency / (Baud_Rate × 16)
```

Example:

```
Clock = 50 MHz
Baud  = 9600

DIV ≈ 326
```

---

## 10. Baud Rate Generator (Verilog)

```verilog
module baud_gen (
    input clk,
    input rst,
    output reg tick
);

    parameter CLK_FREQ = 50000000;
    parameter BAUD = 9600;
    parameter DIV = CLK_FREQ / (BAUD * 16);

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

This generates a **tick pulse**, not a new clock.

---

## 11. Use of Tick

### Transmitter

* Sends one bit per baud tick

### Receiver

* Uses 16 ticks per bit
* Samples at middle of bit

```
UART = FSM + Shift Register + Baud Generator
```

---

## 12. Advantages and Disadvantages

### Advantages

* Simple wiring
* No clock required
* Widely supported
* Low cost

### Disadvantages

* Slower than SPI or I²C
* Baud rate must match
* No multi-master
* Limited frame size

---

## 13. Serial vs Parallel

| Serial        | Parallel       |
| ------------- | -------------- |
| One wire      | Multiple wires |
| Slower        | Faster         |
| Cheaper       | Expensive      |
| Long distance | Short distance |

UART is serial → better for distance.

---

## 14. Hardware View

```
System Clock
     ↓
Baud Generator
     ↓
FSM (TX/RX Control)
     ↓
Shift Register
     ↓
TX / RX Pin
```

---

## 15. Key Points (Exam / Interview)

* ✔ UART is asynchronous
* ✔ Baud rate must match
* ✔ Uses start and stop bits
* ✔ Receiver oversamples
* ✔ Baud generator divides clock
* ✔ FSM controls TX and RX

---

## Final Statement

UART communication depends entirely on:

1. Correct baud rate
2. Correct frame format
3. Accurate sampling

**Without baud synchronization, data becomes meaningless.**

---
