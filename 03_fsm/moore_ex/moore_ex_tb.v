module moore_ex_tb ;
    reg a,clk,rst;

    wire out;

    moore_ex dut(
        .a(a),
        .clk(clk),
        .rst(rst),
        .out(out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1;
        rst = 1;
        #10
        rst = 0;

        a = 0;
        #10 a = 1;
        #10 a = 0;
        #10 a = 1;
        #10 a = 1;
        #10 a = 0;

        #10 $finish;
    end

    initial begin
        $dumpfile("moore_ex.vcd");
        $dumpvars(0,moore_ex_tb);
    end
endmodule