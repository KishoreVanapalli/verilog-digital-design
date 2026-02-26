# ALU

## Description
This module implements a ALU using Verilog HDL.  
It is designed and verified using a self-written testbench.

## Files
- alu.v        → RTL design  
- alu_tb.v     → Testbench  
- alu.vcd      → Waveform dump  

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
