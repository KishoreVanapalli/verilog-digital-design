module counter (
    input clk,rst,
    output reg [2:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 3'b000;
        end else begin
            if (q == 3'b111) begin
                q <= 3'b000;
            end else begin
                q <= q + 3'b001;
            end
        end
    end
endmodule