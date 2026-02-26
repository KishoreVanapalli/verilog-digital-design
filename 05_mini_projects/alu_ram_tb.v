module alu_ram_tb ;
    
    reg clk,enb,wr,rd;
    reg [7:0] oparand1,oparand2;
    reg [3:0] opcode;
    reg [3:0] address,address1,address2,address3;

    wire [15:0] result;
    wire [15:0] data_out1,data_out2,data_out3,data_out4;

    always #5 clk = ~clk;

    alu_ram dut(
        .clk(clk),
        .enb(enb),
        .wr(wr),
        .rd(rd),
        .oparand1(oparand1),
        .oparand2(oparand2),
        .opcode(opcode),
        .address(address),
        .address1(address1),
        .address2(address2),
        .address3(address3),
        .result(result),
        .data_out1(data_out1),
        .data_out2(data_out2),
        .data_out3(data_out3),
        .data_out4(data_out4)
    );

    initial begin
        clk = 0;
        enb = 0;
        wr = 0;
        rd = 0;
        oparand1 = 0; 
        oparand2 = 0; 
        opcode = 0;
        address = 0; 
        address1 = 0; 
        address2 = 0; 
        address3 = 0;

        #10
        clk = 1;
        enb  = 1'b1;
        wr = 1'b1;
        oparand1 = 8'h66;
        oparand2 = 8'h54;
        address = 4'b1001;
        address1 = 4'b0001;
        address2 = 4'b0011;
        address3 = 4'b1011;
        opcode = 4'b0101;
        
        #100 wr = 1'b0;

        #100 rd = 1'b1;
        #100 $finish;
    end

    initial begin
        $dumpfile("alu_ram.vcd");
        $dumpvars(0,alu_ram_tb);
    end
endmodule