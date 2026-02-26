# Full Adder

## Description
This module implements a 1-bit full adder which performs addition of two input bits and a carry-in using Verilog HDL.  
It is designed and verified using a self-written testbench.

## Inputs
- a : First bit  
- b : Second bit  
- cin : Carry input  

## Outputs
- sum : Sum output  
- cout : Carry output

## Files
- full_adder.v        → RTL design  
- full_adder_tb.v     → Testbench  
- full_adder.vcd      → Waveform dump  

## Concepts Covered
- Combinational logic
- Boolean equations

## Simulation
Tool used: Icarus Verilog + GTKWave  

Commands:
iverilog -o sim <module>.v <module>_tb.v  
vvp sim  
gtkwave <module>.vcd  

## Verification
All input combinations were tested through the testbench and verified using waveform analysis.

## Author
Kishore Vanapalli 
