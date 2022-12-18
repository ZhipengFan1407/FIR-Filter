`timescale 1us/1ns
// 32 bit inputs, 32 bit outputs, ignore overflow, asynchronous
module adder_reg (
    input [31 : 0] in_a,
    input [31 : 0] in_b,
    output reg [31 : 0] out
);
    // too much work for writing a 32-bit adder with parallel structure, let verilog decide
	initial begin
		out <= 32'd0;
	end
    always @(*) begin
		out <= in_a + in_b;
	end

endmodule
