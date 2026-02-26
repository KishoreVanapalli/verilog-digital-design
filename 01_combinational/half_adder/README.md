# Half Adder

## Description
This module implements a half adder to add two 1-bit inputs without carry-in using Verilog HDL.  
It is designed and verified using a self-written testbench.

## Inputs
- a
- b

## Outputs
- sum
- carry

## Files
- half_adder.v        → RTL design  
- half_adder_tb.v     → Testbench  
- half_adder.vcd      → Waveform dump  

## Concepts Covered
- XOR, AND logic

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









