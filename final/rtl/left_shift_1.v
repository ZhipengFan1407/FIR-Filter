`timescale 1us/1ns
// 32 bit input, 32 bit output, left shift by 1 bit, asynchronous
module left_shift_1(
    input [31 : 0] data_in,
    output reg [31 : 0] data_out
);
	initial begin
		data_out <= 32'd0;
	end
	always @(*) begin    
		data_out <= data_in << 1;
	end

endmodule
