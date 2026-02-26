`timescale 1ns / 1ps

module alu_flags_tb;

    // Inputs to the ALU
    reg [7:0] oparand1, oparand2;
    reg [3:0] opcode;
    reg       enable;

    // Outputs from the ALU
    wire [15:0] result;
    wire [3:0]  status; // [Carry, Overflow, Zero, Negative]

    // Instantiate the Unit Under Test (UUT)
    alu_flags uut (
        .oparand1(oparand1),
        .oparand2(oparand2),
        .opcode(opcode),
        .enable(enable),
        .result(result),
        .status(status)
    );

    // Opcode Parameters (Matching your design)
    parameter ADD=4'b0100, SUB=4'b0101, AND=4'b0110, OR=4'b0111,
              NOT=4'b0000, NAND=4'b0001, NOR=4'b0010, XOR=4'b0011,
              XNOR=4'b1100, INC=4'b1101, DEC=4'b1110, 
              LEFT=4'b1111, RIGHT=4'b1000, ARTH=4'b1001;

    initial begin
        // Initialize Inputs
        enable = 0; oparand1 = 0; oparand2 = 0; opcode = 0;
        #10 enable = 1;

        // Monitor results in console [ASIC World Test Plan](https://www.asic-world.com/verilog/art_testbench_writing1.html)
        $monitor("Time=%0t | Op=%b | A=%d B=%d | Res=%d | Flags[C V Z N]=%b", 
                 $time, opcode, oparand1, oparand2, result, status);

        // --- TEST CASES ---

        // 1. ADD: Normal and Carry/Overflow check
        oparand1 = 8'd127; oparand2 = 8'd1; opcode = ADD; #10; // Result 128, should trigger Overflow (V)
        oparand1 = 8'd255; oparand2 = 8'd1; opcode = ADD; #10; // Result 0, should trigger Carry (C) and Zero (Z)

        // 2. SUB: Zero Flag check
        oparand1 = 8'd50; oparand2 = 8'd50; opcode = SUB; #10; // Result 0, Zero (Z) set

        // 3. LOGIC: AND/OR/XOR
        oparand1 = 8'b10101010; oparand2 = 8'b11110000; opcode = AND; #10;
        oparand1 = 8'b10101010; oparand2 = 8'b11110000; opcode = XOR; #10;

        // 4. SHIFTS: Left and Right
        oparand1 = 8'b10000001; opcode = LEFT; #10; // Shift out 1, Carry (C) should trigger
        oparand1 = 8'b10000000; opcode = ARTH; #10; // Arithmetic Right Shift (Should preserve sign)

        // 5. INC/DEC
        oparand1 = 8'd255; opcode = INC; #10; // Wrap around to 0
        
        // 6. Disable Check
        enable = 0; #10; // Result should go to 0 regardless of inputs

        $display("Simulation Finished");
        $finish;
    end

    initial begin
        $dumpfile("alu_flags.vcd");
        $dumpvars(0,alu_flags_tb);
    end
endmodule