module alu_flags (
    input  [7:0] oparand1, oparand2,
    input  [3:0] opcode,
    input        enable,
    output reg [15:0] result,
    output reg [3:0]  status // [Carry, Overflow, Zero, Negative]
);

    parameter ADD=4'b0100, SUB=4'b0101, AND=4'b0110, OR=4'b0111,
              NOT=4'b0000, NAND=4'b0001, NOR=4'b0010, XOR=4'b0011,
              XNOR=4'b1100, INC=4'b1101, DEC=4'b1110, 
              LEFT=4'b1111, RIGHT=4'b1000, ARTH=4'b1001;

    reg [8:0] tmp; // 9th bit captures Carry/Borrow

    always @(*) begin
        result = 16'b0;
        status = 4'b0;
        tmp    = 9'b0;

        if (enable) begin
            case (opcode)
                ADD: begin
                    tmp = oparand1 + oparand2;
                    result = {8'b0, tmp[7:0]};
                    // Status: Carry, Overflow (Same sign in, different sign out), Zero, Negative
                    status[3] = tmp[8]; 
                    status[2] = (oparand1[7] == oparand2[7]) && (tmp[7] != oparand1[7]);
                end

                SUB: begin
                    tmp = oparand1 - oparand2;
                    result = {8'b0, tmp[7:0]};
                    // Status: Borrow (Carry), Overflow
                    status[3] = tmp[8];
                    status[2] = (oparand1[7] != oparand2[7]) && (tmp[7] != oparand1[7]);
                end

                INC: begin
                    tmp = oparand1 + 1'b1;
                    result = {8'b0, tmp[7:0]};
                    status[3] = tmp[8];
                    status[2] = (oparand1[7] == 0 && tmp[7] == 1);
                end

                DEC: begin
                    tmp = oparand1 - 1'b1;
                    result = {8'b0, tmp[7:0]};
                    status[3] = tmp[8];
                    status[2] = (oparand1[7] == 1 && tmp[7] == 0);
                end

                // Logical operations generally only affect Z and N flags
                AND:  result = {8'b0, oparand1 & oparand2};
                OR:   result = {8'b0, oparand1 | oparand2};
                NAND: result = {8'b0, oparand1 ~& oparand2};
                NOR:  result = {8'b0, oparand1 ~| oparand2};
                XOR:  result = {8'b0, oparand1 ^ oparand2};
                XNOR: result = {8'b0, oparand1 ~^ oparand2};
                
                NOT: begin
                    result[15:8] = ~oparand1;
                    result[7:0]  = ~oparand2;
                end

                LEFT: begin
                    result[15:8] = oparand1 << 1;
                    result[7:0]  = oparand2 << 1;
                    status[3] = oparand1[7]; // Carry is the bit shifted out
                end

                RIGHT: begin
                    result[15:8] = oparand1 >> 1;
                    result[7:0]  = oparand2 >> 1;
                    status[3] = oparand2[0];
                end

                ARTH: begin
                    result = {8'b0, $signed(oparand1) >>> 1};
                    status[3] = oparand1[0];
                end

                default: result = 16'b0;
            endcase

            // Global Flag Assignment (Zero and Negative)
            if (result == 16'b0) status[1] = 1'b1; // Zero Flag
            if (result[7] == 1'b1) status[0] = 1'b1; // Negative Flag (based on LSB byte)
        end
    end
endmodule
