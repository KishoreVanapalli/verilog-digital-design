module uart_receiver (
    input clk, rst, rx_en,
    input data_in,
    output reg [7:0] data_out
);
    parameter s1 = 2'b00, s2 = 2'b10, s3 = 2'b11;

    reg [1:0] state;
    reg [3:0] count;  
    reg [3:0] sample; 

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= s1;
            count <= 0;
            sample <= 0;
            data_out <= 0;
        end else if (rx_en) begin
            case (state)
                s1: begin 
                    if (data_in == 1'b0) begin
                        if (sample == 4'd7) begin 
                            state <= s2;
                            sample <= 0;
                            count <= 0;
                        end else begin
                            sample <= sample + 1;
                        end
                    end else begin
                        sample <= 0; 
                    end
                end

                s2: begin 
                    if (sample == 4'd15) begin 
                        sample <= 0;
                        data_out[count] <= data_in; 
                        
                        if (count == 4'd7)
                            state <= s3;
                        else
                            count <= count + 1;
                    end else begin
                        sample <= sample + 1;
                    end
                end

                s3: begin 
                    if (sample == 4'd15) begin
                        state <= s1;
                        sample <= 0;
                    end else begin
                        sample <= sample + 1;
                    end
                end

                default: state <= s1;
            endcase
        end
    end
endmodule