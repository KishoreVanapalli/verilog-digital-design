module fsm_shift_tb ;
    
    reg clk,rst,load;
    reg [3:0] data;

    wire [3:0] out;

    fsm_shift dut(
        .clk(clk),
        .rst(rst),
        .load(load),
        .data(data),
        .out(out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1;
        rst = 1;
        #10
        rst = 0;
        load = 1;

        data = 4'b1101;
        #100

        load = 0;

        #90 $finish;
    end

    initial begin
        $dumpfile("fsm_shift.vcd");
        $dumpvars(0,fsm_shift_tb);
    end
endmodule