module left_shift ( 
    input a,clk, rst,
    output reg [3:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 4'b0000;
        end else begin
            q <= {q[2:0], a};
        end
    end
endmodule