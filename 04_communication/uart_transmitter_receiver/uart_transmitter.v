module uart_transmitter (
    input clk,rst,tx_en,enb,
    input [7:0] data_in,
    output reg data_out
);
    parameter s1 = 2'b00, s2 = 2'b01, s3 = 2'b10, s4 = 2'b11;

    reg [1:0] state;
    reg [3:0] count = 4'b0000;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= s1;
        end else begin
            if (tx_en) begin
            case (state)
                s1: begin
                    if (enb) begin
                        data_out <= 1'b1;
                        state <= s2;
                        count <= 4'b0000;
                    end else begin
                        state <= s1;
                    end
                end
                s2: begin
                    data_out <= 1'b0;
                    state <= s3;
                end
                s3: begin
                    if (count == 4'b1000) begin
                        state <= s4;
                        data_out <= 1'b1;
                        count <= 4'b0000;
                    end else begin
                        data_out <= data_in[count];
                        state <= s3;
                        count <= count + 4'b0001;
                    end
                end
                s4: begin
                    data_out <= 1'b1;
                    state <= s1;
                end
                default: begin
                        state <= s1;
                        count <= 4'b0000;
                end
            endcase
            end
        end
    end
endmodule