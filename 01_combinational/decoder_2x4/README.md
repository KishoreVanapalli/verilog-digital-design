# 2x4 Decoder

## Description
This module implements a decodes 2-bit input into one-hot 4-bit output using Verilog HDL.  
It is designed and verified using a self-written testbench.

## Files
- decoder_2x4.v        → RTL design  
- decoder_2x4_tb.v     → Testbench  
- decoder_2x4.vcd      → Waveform dump  

## Concepts Covered
- One-hot encoding

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





