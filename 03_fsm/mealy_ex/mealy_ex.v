module mealy_ex (
    input a,clk,rst,
    output reg out
);
    parameter s1 = 1'b0, s2 = 1'b1; ;

    reg next,present;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            present <= s1;
        end else begin
            present <= next;
        end
    end

    always @(*) begin
        next <= s1;
        case (present)
            s1: begin
                if (~a) begin 
                        next = s2;
                        out = 1'b1;
                end else  begin  
                        next = s1;
                        out = 1'b0;
                end
            end
            s2: begin
                if (a) begin 
                        next = s1;
                        out = 1'b0;
                end else  begin  
                        next = s2;
                        out = 1'b1;
                end
            end
            default: begin
                next = s1;
                out = 1'b1;
            end
        endcase
    end
endmodule