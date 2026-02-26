module uart_rx (
    input clk,rst,rx,
    output reg [7:0] data,
    output reg run
);
    parameter  s1 = 2'b00, s2 = 2'b01, s3 = 2'b10, s4 = 2'b11;

    reg [7:0] shift;
    reg [3:0] count;

    reg [1:0] present;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            present = s1;
            count <= 4'b0000;
            run <= 0;
        end else begin
            case (present)
                s1: begin if (!rx) begin
                    present <= s2;
                end 
                    run <= 0;
                end
                s2: begin
                    present <= s3;
                    count <= 4'b0000;
                end
                s3: begin if (count == 4'b1000) begin
                    present <= s4;
                end else begin
                    count <= count + 4'b0001;
                    shift <= {rx,shift[7:1]};
                end 
                end
                s4: begin 
                    present <= s1;
                    data <= shift;
                    run <= 1;
                end
            endcase
        end
    end
endmodule