# Combinational Logic Modules

This folder contains fundamental combinational digital circuits implemented using Verilog HDL.  
These designs produce outputs that depend only on current inputs (no clock or memory).

## Modules Included
- Logic gates (AND, OR, XOR, NOT)
- Half Adder
- Full Adder
- Multiplexers (2x1, 4x1)
- Encoders and Decoders
- ALU (basic arithmetic and logical operations)

## Concepts Covered
- Boolean logic implementation
- Continuous assignments and always @(*) blocks
- Data path modeling
- Modular design using smaller blocks
- Structural vs behavioral modeling

## Verification
Each module is verified using a dedicated testbench:
- Exhaustive input combinations where possible
- Waveform dumping using `$dumpfile` and `$dumpvars`

## Tools Used
- Icarus Verilog (iverilog)
- GTKWave

## Purpose
This folder demonstrates my understanding of:
✔ Digital logic  
✔ Verilog syntax  
✔ Combinational circuit design  
✔ Simulation and waveform debugging  

These modules form the foundation for all higher-level digital systems. 
