module decoder_2x4_tb ;
    
    reg a,b;

    wire w,x,y,z;

    decoder_2x4 dut (
        .a(a),
        .b(b),
        .w(w),
        .x(x),
        .y(y),
        .z(z)
    );

    initial begin
        a = 0; b = 0;
        #5 a = 0; b = 1;
        #5 a = 1; b = 0;
        #5 a = 1; b = 1;
        #5 $finish;
    end

    initial begin
        $dumpfile("decoder_2x4.vcd");
        $dumpvars(0,decoder_2x4_tb);
    end
endmodule