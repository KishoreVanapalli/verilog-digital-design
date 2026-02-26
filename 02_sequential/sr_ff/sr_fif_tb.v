module sr_fif_tb ;

    reg s,r,clk,rst;

    wire q;
    
    sr_fif dut(
        .s(s),
        .r(r),
        .clk(clk),
        .rst(rst),
        .q(q)
    );

    always #5 clk =~ clk;

    initial begin
        clk = 0;
        rst = 1;
        #5
        rst = 0;

        s = 0; r = 0;
        #10 s = 0; r = 1;
        #10 s = 1; r = 0;
        #10 s = 1; r = 1;
        #10 $finish;
    end

    initial begin
        $dumpfile("sr_fif.vcd");
        $dumpvars(0,sr_fif_tb);
    end
    
endmodule