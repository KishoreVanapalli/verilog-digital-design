module traffic_3way (
    input clk,rst,start,
    output reg [1:0] l1,l2,l3
);
   parameter green = 2'b00, yellow = 2'b01, red = 2'b10;

   parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100, s5 = 3'b101, s6 = 3'b110;

   reg [2:0] next,present;
   reg [3:0] count;

   always @(posedge clk or posedge rst) begin
    if (rst) begin
        present <= s0;
    end else begin
        present <= next;
    end
   end

   always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 4'b0000;
    end else if (present != next) begin
        count <= 4'b0000; 
    end  else begin
        count <= count + 4'b0001;
    end
   end

   always @(*) begin
    next = present;
    case (present)
        s0: if(start) next = s1;
        s1: if(count == 4'b1000) next = s2;
        s2: if(count == 4'b0011) next = s3;
        s3: if(count == 4'b1000) next = s4;
        s4: if(count == 4'b0011) next = s5;
        s5: if(count == 4'b1000) next = s6;
        s6: if(count == 4'b0011) next = s1; 
        default: next = s1;
    endcase
   end
   
   always @(*) begin
    case (present)
        s1: begin l1 = green; l2 = red; l3 = red; end
        s2: begin l1 = yellow; l2 = red; l3 = red; end
        s3: begin l1 = red; l2 = green; l3 = red; end
        s4: begin l1 = red; l2 = yellow; l3 = red; end
        s5: begin l1 = red; l2 = red; l3 = green; end
        s6: begin l1 = red; l2 = red; l3 = yellow; end
        default: begin l1 = red; l2 = red; l3 = red; end
    endcase
   end
endmodule