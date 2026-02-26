module mod_10_counter_jk_tb ;
    
    reg [3:0] j,k;
    reg clk,rst;

    wire [3:0] q;

    mod_10_counter_jk dut(
        .clk(clk),
        .rst(rst),
        .q(q)
    );

    always #5 clk =~ clk;

    initial begin
        clk = 1;
        rst = 1;
        #10
        rst = 0;

        #180 $finish;
    end

    initial begin
        $dumpfile("mod_10_counter_jk.vcd");
        $dumpvars(0,mod_10_counter_jk_tb);
    end
endmodule