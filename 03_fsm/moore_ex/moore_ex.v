module moore_ex (
    input a,clk,rst,
    output reg out
);
    parameter s1 = 1'b0, s2 = 1'b1 ;

    reg next,present;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            present <= s1;
        end else begin
            present <= next;
        end
    end

    always @(*) begin
        next = s1;
        case (present)
            s1: begin
                if (~a) next = s2;
                else    next = s1;
            end
            s2: begin
                if (a)  next = s1;
                else    next = s2;
            end
            default: next = s1;
        endcase
    end

    always @(*) begin
        out = (present == s2);
    end
endmodule