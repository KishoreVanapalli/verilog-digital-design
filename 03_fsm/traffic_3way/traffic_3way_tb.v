module traffic_3way_tb ;
    
    reg clk,rst,start;

    wire [1:0] l1,l2,l3;

    traffic_3way dut(
        .clk(clk),
        .rst(rst),
        .start(start),
        .l1(l1),
        .l2(l2),
        .l3(l3)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1;
        rst = 1;
        #10
        rst = 0;
        start = 1;

        #1000
        $finish;
    end

    initial begin
        $dumpfile("traffic_3way.vcd");
        $dumpvars(0,traffic_3way_tb);
    end
endmodule