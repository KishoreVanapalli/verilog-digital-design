# 4x1 MUX using 2x1

## Description
This module implements a 4x1 multiplexer using hierarchical 2x1 multiplexers using Verilog HDL.  
It is designed and verified using a self-written testbench.

## Files
- mux_4x2_using_2x1.v        → RTL design  
- mux_4x2_using_2x1_tb.v     → Testbench  
- mux_4x2_using_2x1.vcd      → Waveform dump  

## Concepts Covered
- Hierarchical design
- Structural modeling

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







