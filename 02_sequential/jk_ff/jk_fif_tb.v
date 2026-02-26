module jk_fif_tb ;
    
    reg j,k,clk,rst;

    wire q;

    jk_fif dut(
        .j(j),
        .k(k),
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

        j = 0; k = 0;
        #10 j = 0; k = 1;
        #10 j = 1; k = 0;
        #10 j = 1; k = 1;
        #10 $finish;
    end

    initial begin
        $dumpfile("jk_fif.vcd");
        $dumpvars(0,jk_fif_tb);
    end
endmodule