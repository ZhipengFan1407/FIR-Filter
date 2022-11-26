`timescale 1ns/1ps
`define HALF_CLOCK_PERIOD #10

module test_da();

	reg clk3;
	reg reset;
	wire [31:0] sum;
	wire [31:0] dff0_out;
	wire [31:0] add6_out;
	wire [31:0] add7_out;
	wire [31:0] leftshift_out;
	wire counter_reach;
	reg [7:0] x1_bit, x2_bit, x3_bit, x4_bit, x5_bit, x6_bit, x7_bit, x8_bit;

	distr_arith da0 (.clk3(clk3), .reset(reset), .x1_bit(x1_bit), .x2_bit(x2_bit), .x3_bit(x3_bit), .x4_bit(x4_bit),
		.x5_bit(x5_bit), .x6_bit(x6_bit), .x7_bit(x7_bit), .x8_bit(x8_bit), 
		.sum(sum), .dff0_out(dff0_out), .count_reach(count_reach), .add6_out(add6_out), .add7_out(add7_out), .leftshift_out(leftshift_out));

	always begin
        `HALF_CLOCK_PERIOD;
        clk3 = ~clk3;
    end


	initial begin

		clk3 = 1'b0;
		reset = 1'b1;
		#5;
		reset = 1'b0;

		@(posedge clk3);
		x1_bit <= 8'b00000001;
		x2_bit <= 8'b00000010;
		x3_bit <= 8'b00000100;
		x4_bit <= 8'b00001000;
		x5_bit <= 8'b00010000;
		x6_bit <= 8'b00100000;
		x7_bit <= 8'b01000000;
		x8_bit <= 8'b10000000;
		@(posedge clk3);
		x1_bit <= 8'b00000011;
		x2_bit <= 8'b00000110;
		x3_bit <= 8'b00001100;
		x4_bit <= 8'b00011000;
		x5_bit <= 8'b00110000;
		x6_bit <= 8'b01100000;
		x7_bit <= 8'b11000000;
		x8_bit <= 8'b10000001;
		@(posedge clk3);
		x1_bit <= 8'b00001111;
		x2_bit <= 8'b00011110;
		x3_bit <= 8'b00111100;
		x4_bit <= 8'b01111000;
		x5_bit <= 8'b11110000;
		x6_bit <= 8'b11100001;
		x7_bit <= 8'b11000011;
		x8_bit <= 8'b10000111;
		@(posedge clk3);
		x1_bit <= 8'b10001111;
		x2_bit <= 8'b01011110;
		x3_bit <= 8'b00111101;
		x4_bit <= 8'b01111010;
		x5_bit <= 8'b11110100;
		x6_bit <= 8'b11101001;
		x7_bit <= 8'b11001011;
		x8_bit <= 8'b10100111;
		@(posedge clk3);
		x1_bit <= 8'b00011010;
		x2_bit <= 8'b01100110;
		x3_bit <= 8'b00100000;
		x4_bit <= 8'b00010001;
		x5_bit <= 8'b01010000;
		x6_bit <= 8'b10101001;
		x7_bit <= 8'b00000001;
		x8_bit <= 8'b10000001;
		@(posedge clk3);
		x1_bit <= 8'b00001111;
		x2_bit <= 8'b00011110;
		x3_bit <= 8'b00111100;
		x4_bit <= 8'b01111000;
		x5_bit <= 8'b11110000;
		x6_bit <= 8'b11100001;
		x7_bit <= 8'b11000011;
		x8_bit <= 8'b10000111;
		@(posedge clk3);
		x1_bit <= 8'b00011111;
		x2_bit <= 8'b00111110;
		x3_bit <= 8'b01111100;
		x4_bit <= 8'b11111000;
		x5_bit <= 8'b11110000;
		x6_bit <= 8'b11100011;
		x7_bit <= 8'b11000111;
		x8_bit <= 8'b10001111;
		@(posedge clk3);
		x1_bit <= 8'b00111111;
		x2_bit <= 8'b01111110;
		x3_bit <= 8'b11111100;
		x4_bit <= 8'b11111001;
		x5_bit <= 8'b11110011;
		x6_bit <= 8'b11100111;
		x7_bit <= 8'b11001111;
		x8_bit <= 8'b10011111;
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		reset = 1'b1;
		#5;
		reset = 1'b0;
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		@(posedge clk3);
		$finish;
	end

endmodule
