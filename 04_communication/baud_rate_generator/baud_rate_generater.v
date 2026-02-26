module baud_rate_generater (
	input clk,
	output tx_en,rx_en
);
	reg [11:0] tx_counter = 12'b0; 
    reg [7:0] rx_counter = 8'b0;

	always @(posedge clk ) begin
		if (tx_counter == 12'b101000101101) begin
			tx_counter <= 12'b0;
		end else begin
			tx_counter <= tx_counter + 12'b000000000001;
		end
	end

	always @(posedge clk ) begin
		if (rx_counter == 8'b10100011) begin
			rx_counter <= 8'b0;
		end else begin
			rx_counter <= rx_counter + 8'b00000001;
		end
	end

	assign tx_en = (tx_counter == 0) ? 1'b1 : 1'b0;
	assign rx_en = (rx_counter == 0) ? 1'b1 : 1'b0;
endmodule