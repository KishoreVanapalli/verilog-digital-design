# Logic Gates

## Description
This module implements a all logic gates using Verilog HDL.  
It is designed and verified using a self-written testbench.

## Files
- logic_gates.v        → RTL design  
- logic_gates_tb.v     → Testbench  
- logic_gates.vcd      → Waveform dump  

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
