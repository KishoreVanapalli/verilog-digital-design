module right_shift_tb ;
    
    reg a,clk, rst;

    wire [3:0] q;

    right_shift dut(
        .a(a),
        .clk(clk),
        .rst(rst),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        a = 0;
        #5
        rst = 0;

        a = 1;
        #10 a = 0;
        #10 a = 1;
        #10 a = 1;

        #10 $finish;

    end

    initial begin
        $dumpfile("right_shift.vcd");
        $dumpvars(0,right_shift_tb);
    end
endmodule