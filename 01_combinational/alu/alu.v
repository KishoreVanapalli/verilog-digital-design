module alu (
    input  [7:0] oparand1, oparand2,
    input  [3:0] opcode,
    input        enable,
    output reg [15:0] result
);

    parameter ADD   = 4'b0100,
              SUB   = 4'b0101,
              AND   = 4'b0110,
              OR    = 4'b0111,
              NOT   = 4'b0000,
              NAND  = 4'b0001,
              NOR   = 4'b0010,
              XOR   = 4'b0011,
              XNOR  = 4'b1100,
              INC   = 4'b1101,
              DEC   = 4'b1110,
              LEFT  = 4'b1111,
              RIGHT = 4'b1000,
              ARTH  = 4'b1001;   // arithmetic right shift

    always @(*) begin
        result = 16'b0;   // default to avoid latches

        if (enable) begin
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

endmodule