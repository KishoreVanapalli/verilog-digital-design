module urat_tx_tb ;
    
    reg clk,rst,send;
    reg [7:0] tx;

    wire out;

    urat_tx dut(
        .clk(clk),
        .rst(rst),
        .send(send),
        .tx(tx),
        .out(out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1;
        rst = 1;
        send = 0;
        #10

        rst = 0;
        send = 1;

        tx = 8'h67;

        #1000 $finish;
    end

    initial begin
        $dumpfile("uart_tx.vcd");
        $dumpvars(0,urat_tx_tb);
    end
endmodule