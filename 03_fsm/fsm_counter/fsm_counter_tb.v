module fsm_counter_tb ;
    
    reg clk,rst,start;

    wire out;

    fsm_counter dut(
        .clk(clk),
        .rst(rst),
        .start(start),
        .out(out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1;
        rst = 1;
        #10
        rst = 0;
        start = 1;

        #200
        $finish;
    end

    initial begin
        $dumpfile("fsm_counter.vcd");
        $dumpvars(0,fsm_counter_tb);
    end
endmodule