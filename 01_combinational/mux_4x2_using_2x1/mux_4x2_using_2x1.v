module mux_4x2_using_2x1 (
    input a,b,c,d,s0,s1,
    output x,y,z
);
    wire w1, w2;

    mux_2x1 M1 (.x(a), .y(b), .s0(s0), .z(w1));
    mux_2x1 M2 (.x(c), .y(d), .s0(s0), .z(w2));
    mux_2x1 M3 (.x(w1), .y(w2), .s0(s1), .z(z));
endmodule