module mux_2x1(
    input x,y,s0,
    output reg z
);
always @(*) begin
    if (s0) begin
        z = x;
    end else begin
        z = y;
    end
end
endmodule