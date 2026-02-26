module right_shift_rot ( 
    input [3:0] a,
    input clk, rst,
    output reg [3:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= a;
        end else begin
            q <= {q[0], q[3:1]};
        end
    end
endmodule