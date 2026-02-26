`timescale 1ns/10ps

module uart_rx_tb ;
    
    reg clk,rst,rx;

    wire [7:0] data;
    wire run;

    uart_rx dut(
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .data(data),
        .run(run)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1;
        rst = 1;
        #10

        rst = 0;

        rx = 0;
        #10 rx = 1;
        #10 rx = 0;
        #10 rx = 1;
        #10 rx = 0;
        #10 rx = 0;
        #10 rx = 1;
        #10 rx = 0;
        #10 rx = 1;
        #10 rx = 1;
        #10 rx = 1;
        #10 rx = 0;
        #10 rx = 1;
        #10 rx = 1;
        #10 rx = 0;
        #10 rx = 1;
        #10 rx = 0;
        #10 rx = 1;
        #10 rx = 0;
        #10 rx = 1;

        #100 $finish;
    end

    initial begin
        $dumpfile("uart_rx.vcd");
        $dumpvars(0,uart_rx_tb);
    end
endmodule