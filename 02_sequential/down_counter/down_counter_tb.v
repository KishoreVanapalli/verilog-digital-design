module down_counter_tb ;
    
    reg clk,rst;

    wire [2:0] q;

    down_counter dut(
        .clk(clk),
        .rst(rst),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1;
        rst = 1;
        #10
        rst = 0;

        #100 $finish;
    end

    initial begin
        $dumpfile("down_counter.vcd");
        $dumpvars(0,down_counter_tb);
    end
endmodule