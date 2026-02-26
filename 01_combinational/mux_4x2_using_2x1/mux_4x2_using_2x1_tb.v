module mux_4x2_using_2x1_tb;

    reg a,b,c,d,s0,s1;

    wire z;

    mux_4x2_using_2x1 dut(
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .s0(s0),
        .s1(s1),
        .z(z)
    );

    initial begin
        a = 1; b = 0; c = 1; d = 0; s0 = 0; s1 = 0;
        #5 a = 1; b = 0; c = 1; d = 0; s0 = 1; s1 = 0;
        #5 a = 1; b = 0; c = 1; d = 0; s0 = 0; s1 = 1;
        #5 a = 1; b = 0; c = 1; d = 0; s0 = 1; s1 = 1;
        #5 $finish;
    end
    
    initial begin
        $dumpfile("mux_4x2_using_2x1.vcd");
        $dumpvars(0,mux_4x2_using_2x1_tb);
    end
endmodule