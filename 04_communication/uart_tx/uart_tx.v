module urat_tx (
    input clk,rst,send,
    input [7:0] tx,
    output reg out
);
    parameter  s1 = 2'b00, s2 = 2'b01, s3 = 2'b10, s4 = 2'b11;

    reg [1:0] present;

    reg [3:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            present <= s1;
            count <= 4'b0000;
        end else begin
            if (count == 4'b1010) begin
                count <= 4'b0000;
            end else begin
                case (present)
                    s1: begin
                        if (send) begin
                            present <= s2;
                        end else begin
                            present <= s1;
                        end
                    end
                    s2: begin
                            present <= s3;
                    end
                    s3: begin
                        if (count == 4'b1001) begin
                            out <= 1'b1;
                            count <= count + 1;
                            present <= s4;
                        end else if (count == 4'b0000) begin
                            out <= 1'b0;
                            count <= count + 1;
                            present <= s3;
                        end else begin
                            present <= s3;
                            out <= tx[count - 1];
                            count <= count + 1;
                        end
                    end
                    s4: begin
                        present <= s1;
                    end 
                endcase
            end
        end
    end
endmodule