module mod_10_counter_jk (
    input clk, rst,
    output reg [3:0] q
);
    wire [3:0] j, k;

    assign j[0] = 1'b1;
    assign k[0] = 1'b1;
    
    assign j[1] = q[0] & ~q[3]; 
    assign k[1] = q[0];
    
    assign j[2] = q[0] & q[1];
    assign k[2] = q[0] & q[1];
    
    assign j[3] = q[0] & q[1] & q[2];
    assign k[3] = q[0] | q[3]; 

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 4'b0000;
        end else begin
            q[0] <= (j[0] & ~q[0]) | (~k[0] & q[0]);
            q[1] <= (j[1] & ~q[1]) | (~k[1] & q[1]);
            q[2] <= (j[2] & ~q[2]) | (~k[2] & q[2]);
            q[3] <= (j[3] & ~q[3]) | (~k[3] & q[3]);
        end
    end
endmodule