module alu_ram (

    input clk,enb,wr,rd,
    input [7:0] oparand1,oparand2,
    input [3:0] opcode,
    input [3:0] address,address1,address2,address3,
    output reg [15:0] result,
    output [15:0] data_out1,data_out2,data_out3,data_out4
);
    reg [15:0] mem [15:0];

    parameter ADD   = 4'b0000,
              SUB   = 4'b0001,
              AND   = 4'b0010,
              OR    = 4'b0011,
              NOT   = 4'b0100,
              NAND  = 4'b0101,
              NOR   = 4'b0110,
              XOR   = 4'b0111,
              XNOR  = 4'b1000,
              INC   = 4'b1001,
              DEC   = 4'b1010,
              LEFT  = 4'b1011,
              RIGHT = 4'b1100,
              ARTH  = 4'b1101;

    always @(*) begin
        result = 16'b0;   // default to avoid latches

        if (enb) begin
            case (opcode)
                ADD:   result = {8'b0, oparand1 + oparand2};
                SUB:   result = {8'b0, oparand1 - oparand2};
                AND:   result = {8'b0, oparand1 & oparand2};
                OR:    result = {8'b0, oparand1 | oparand2};
                NAND:  result = {8'b0, oparand1 ~& oparand2};
                NOR:   result = {8'b0, oparand1 ~| oparand2};
                XOR:   result = {8'b0, oparand1 ^ oparand2};
                XNOR:  result = {8'b0, oparand1 ~^ oparand2};

                NOT: begin
                    result[15:8] = ~oparand1;
                    result[7:0]  = ~oparand2;
                end

                INC:   result = {8'b0, oparand1 + 8'b1};
                DEC:   result = {8'b0, oparand1 - 8'b1};

                LEFT: begin
                    result[15:8] = oparand1 << 1;
                    result[7:0]  = oparand2 << 1;
                end

                RIGHT: begin
                    result[15:8] = oparand1 >> 1;
                    result[7:0]  = oparand2 >> 1;
                end

                ARTH:  result = {8'b0, $signed(oparand1) >>> 1};

                default: result = 16'b0;
            endcase
        end
    end

    always @(posedge clk ) begin
        if (wr) begin
            mem[address] <= result;
            mem[address1] <= oparand1;
            mem[address2] <= oparand2;
            mem[address3] <= opcode;
        end
    end

    assign data_out1 = (rd) ? mem[address] : 16'b0;
    assign data_out2 = (rd) ? mem[address1] : 16'b0;
    assign data_out3 = (rd) ? mem[address2] : 16'b0;
    assign data_out4 = (rd) ? mem[address3] : 16'b0;
endmodule