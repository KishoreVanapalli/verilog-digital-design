module alu_tb ;

    reg [7:0] oparand1,oparand2;
    reg [3:0] opcode;
    reg enable;

    wire [15:0] result;

    alu dut(
        .oparand1(oparand1),
        .oparand2(oparand2),
        .opcode(opcode),
        .enable(enable),
        .result(result)
    );


    initial begin
        enable = 1'b1;
        oparand1 = 8'h66;
        oparand2 = 8'h54;
        

        opcode = 4'b0100;
        #10 opcode = 4'b0101;
        #10 opcode = 4'b0110;
        #10 opcode = 4'b0111;
        #10 opcode = 4'b0000;
        #10 opcode = 4'b0001;
        #10 opcode = 4'b0010;
        #10 opcode = 4'b0011;
        #10 opcode = 4'b1100;
        #10 opcode = 4'b1101;
        #10 opcode = 4'b1110;
        #10 opcode = 4'b1111;
        #10 opcode = 4'b1000;
        #10 opcode = 4'b1001;  

        #10 $finish;
    end

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0,alu_tb);
    end
endmodule