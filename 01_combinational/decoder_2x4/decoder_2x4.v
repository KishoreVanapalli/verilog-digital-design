module decoder_2x4 (
    input a,b,
    output reg w,x,y,z
);
    always @(*) begin
        case ({a,b})
            2'b00 : {w,x,y,z} = 4'b1000;
            2'b01 : {w,x,y,z} = 4'b0100;
            2'b10 : {w,x,y,z} = 4'b0010;
            2'b11 : {w,x,y,z} = 4'b0001;
            default: {w,x,y,z} = 4'bxxxx;
        endcase
    end
endmodule