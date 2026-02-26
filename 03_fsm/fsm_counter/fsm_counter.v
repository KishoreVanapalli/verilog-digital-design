module fsm_counter (
    input clk,rst,start,
    output reg out
);
   parameter s1 = 2'b00, s2 = 2'b01, s3 = 2'b10;

   reg [1:0] next,present;
   reg [3:0] count;

   always @(posedge clk or posedge rst) begin
    if (rst) begin
        present <= s1;
    end else begin
        present <= next;
    end
   end

   always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 4'b0000;
    end else if (present == s2) begin
        count <= count + 4'b0001;
    end  else begin
        count <= 4'b0000; 
    end
   end

   always @(*) begin
    next = present;
    case (present)
        s1: if(start) next = s2;
        s2: if(count == 4'b1000) next = s3;
        s3: next = s1; 
    endcase
   end
   
   always @(*) begin
    out = (present == s3);
   end
endmodule