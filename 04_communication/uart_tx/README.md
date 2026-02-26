# UART Transmitter

## Description
This module implements a UART transmitter using Verilog HDL.  
It is designed and verified using a self-written testbench.

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
