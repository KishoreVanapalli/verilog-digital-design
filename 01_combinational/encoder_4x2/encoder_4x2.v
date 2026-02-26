module encoder_4x2 (
    input a,b,c,d,
    output reg x,y
);
    always @(*) begin
        case ({a,b,c,d})
            4'b1000 : {x,y} = 2'b00;
            4'b0100 : {x,y} = 2'b01;
            4'b0010 : {x,y} = 2'b10;
            4'b0001 : {x,y} = 2'b11;
            default: {x,y} = 2'bxx;
        endcase
    end
endmodule