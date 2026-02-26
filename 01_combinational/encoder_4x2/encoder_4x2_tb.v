module encoder_4x2_tb ;
    
    reg a,b,c,d;

    wire x,y;

    encoder_4x2 dut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .x(x),
        .y(y)
    );

    initial begin
        a = 1; b = 0; c = 0; d = 0;
        #5 a = 0; b = 1; c = 0; d = 0;
        #5 a = 0; b = 0; c = 1; d = 0;
        #5 a = 0; b = 0; c = 0; d = 1;
        #5 $finish;
    end

    initial begin
        $dumpfile("encoder_4x2.vcd");
        $dumpvars(0,encoder_4x2_tb);
    end
endmodule