`timescale 1ns / 1ps

module baud_rate_generater_tb ;

    reg clk;

    wire tx_en,rx_en;

    always #20 clk = ~clk;

    baud_rate_generater dut(
        .clk(clk),
        .tx_en(tx_en),
        .rx_en(rx_en)
    );


    initial begin
        clk = 0;

        #200000 $finish;
    end

    initial begin
        $dumpfile("baud_rate_generater.vcd");
        $dumpvars(0,baud_rate_generater_tb);
    end
endmodule