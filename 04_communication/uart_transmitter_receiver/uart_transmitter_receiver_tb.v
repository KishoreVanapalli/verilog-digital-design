`timescale 1ns / 1ps

module uart_transmitter_receiver_tb ;
    
    reg clk,rst,tx_en,enb;
    reg [7:0] data_in_t;

    wire tx_en_b,rx_en_b;
    wire data_out_t;
    wire [7:0] data_out_r;

    always #20 clk = ~clk;

    baud_rate_generater baud_instance(
        .clk(clk),
        .tx_en(tx_en_b),
        .rx_en(rx_en_b)
    );
    
    uart_transmitter transmitter_instance(
        .clk(clk),
        .rst(rst),
        .tx_en(tx_en_b),
        .enb(enb),
        .data_in(data_in_t),
        .data_out(data_out_t)
    );

    uart_receiver receiver_instance(
        .clk(clk),
        .rst(rst),
        .rx_en(rx_en_b),
        .data_in(data_out_t),
        .data_out(data_out_r)
    );

    initial begin
        clk = 0;
        rst = 1;
        enb = 0;
        data_in_t = 8'h00;

        #100;
        rst = 0;
        enb = 1;

        data_in_t = 8'h67;

        #20000000;
        rst = 0;
        enb = 1;

        data_in_t = 8'hf1;

        #20000000 $finish;
    end

    initial begin
        $dumpfile("uart_transmitter_receiver.vcd");
        $dumpvars(0,uart_transmitter_receiver_tb);
    end
endmodule