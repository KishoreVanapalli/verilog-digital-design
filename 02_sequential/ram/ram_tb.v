module ram_tb ;
    
    reg clk,wr,rd;
    reg [7:0] data_in;
    reg [7:0] address;

    wire [7:0] data_out;

    ram dut(
        .clk(clk),
        .wr(wr),
        .rd(rd),
        .data_in(data_in),
        .address(address),
        .data_out(data_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1;

        #10 wr = 1'b1;
        data_in = 8'b11010111;
        address = 8'b00010011;

        #100 rd = 1'b1;
        address = 8'b00010011;

        #100 $finish;
    end

    initial begin
        $dumpfile("ram.vcd");
        $dumpvars(0,ram_tb);
    end
endmodule