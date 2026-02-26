module left_shift_rot_tb ;
    
    reg [3:0] a;
    reg clk, rst;

    wire [3:0] q;

    left_shift_rot dut(
        .a(a),
        .clk(clk),
        .rst(rst),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        
        a = 4'b1011;
        #10
        rst = 0;

        #50 $finish;

    end

    initial begin
        $dumpfile("left_shift_rot.vcd");
        $dumpvars(0,left_shift_rot_tb);
    end
endmodule