# 2x1 Multiplexer

## Description
This module implements a selection one of two inputs based on a select signal using Verilog HDL.  
It is designed and verified using a self-written testbench.

## Inputs
- a
- b
- sel

## Outputs
- y

## Files
- half_adder.v        → RTL design  
- half_adder_tb.v     → Testbench  
- half_adder.vcd      → Waveform dump  

## Concepts Covered
- Data selection logic

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






