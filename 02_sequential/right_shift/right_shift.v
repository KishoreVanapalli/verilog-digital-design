module right_shift ( 
    input a,clk, rst,
    output reg [3:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 4'b0000;
        end else begin
            q <= {a, q[3:1]};
        end
    end
endmodule