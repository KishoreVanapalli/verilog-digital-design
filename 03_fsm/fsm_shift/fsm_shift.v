module fsm_shift (
    input clk,rst,load,
    input [3:0] data,
    output reg [3:0] out
);
   parameter s1 = 2'b00, s2 = 2'b01, s3 = 2'b10;

   reg [1:0] next,present;

   always @(posedge clk or posedge rst) begin
    if (rst) begin
        present <= s1;
    end else begin
        present <= next;
    end
   end

   always @(posedge clk or posedge rst) begin
    if (rst) begin
        out <= 4'b0000;
    end  else if (present == s3) begin
        out <= {1'b0,data[3:1]}; 
    end else if (present == s2) begin
        out <= data; 
    end else begin
        out <= out;
    end
   end

   always @(*) begin
    next = present;
    case (present)
        s1: if(load) next = s2; 
        s2: if(!load) next = s3;
        default: next = s1;
    endcase
   end
   
endmodule