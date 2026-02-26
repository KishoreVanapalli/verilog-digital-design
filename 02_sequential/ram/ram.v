module ram (
    input clk,wr,rd,
    input [7:0] data_in,
    input [7:0] address,
    output [7:0] data_out
);
    reg [7:0] mem [255:0];

    always @(posedge clk ) begin
        if (wr) begin
            mem[address] <= data_in;
        end
    end

    assign data_out = (rd) ? mem[address] : 8'b0;
endmodule