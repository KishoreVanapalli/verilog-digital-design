module mux_2x1_tb;
    
    reg x,y,s0;
    
    wire z;

    mux_2x1 dut(
        .x(x),
        .y(y),
        .s0(s0),
        .z(z)
    );
    
    initial begin
        x = 0; y = 1; s0 = 0;
        #5 x = 0; y = 1; s0 = 1;
        #5 $finish;
    end

    initial begin
        $dumpfile("mux_2x1.vcd");
        $dumpvars(0,mux_2x1_tb);
    end

endmodule