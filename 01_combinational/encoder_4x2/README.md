# 4x2 Encoder

## Description
This module implements a encodes 4 input lines into 2-bit binary output using Verilog HDL.  
It is designed and verified using a self-written testbench.

## Files
- encoder_4x2.v        → RTL design  
- encoder_4x2_tb.v     → Testbench  
- encoder_4x2.vcd      → Waveform dump  

## Concepts Covered
- Priority logic

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




