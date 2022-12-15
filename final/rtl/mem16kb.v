`timescale 1ns/1ps

module mem16kb(input [11:0] address, input [15:0] data_in, input write_enable_n, input clk, output reg [15:0] data_out);
	
	wire [15:0] chip_enable;
	wire [15:0] d_out [15:0];

	dec_4to16 decoder0 (.d_in(address[11:8]), .d_out(chip_enable));
	
    genvar i;
    generate
	for (i = 0; i < 16; i = i + 1) begin		// Generate 16 memory cells
		mem256w16b mem0 (.Q(d_out[i]),
						.CLK(clk),
						.CEN(chip_enable[i]),			// Each cell has its own wire for enable
						.WEN(write_enable_n),
						.A(address[7:0]),		// 16 cells = 4 bits for indexing page, the rest 8 bits are cell address
						.D(data_in));
	end
	endgenerate

	always @(*) begin
		case (address[11:8])
			4'd0:	data_out = d_out[0];
			4'd1:	data_out = d_out[1];
			4'd2:	data_out = d_out[2];
			4'd3:	data_out = d_out[3];
			4'd4:	data_out = d_out[4];
			4'd5:	data_out = d_out[5];
			4'd6:	data_out = d_out[6];
			4'd7:	data_out = d_out[7];
			4'd8:	data_out = d_out[8];
			4'd9:	data_out = d_out[9];
			4'd10:	data_out = d_out[10];
			4'd11:	data_out = d_out[11];
			4'd12:	data_out = d_out[12];
			4'd13:	data_out = d_out[13];
			4'd14:	data_out = d_out[14];
			4'd15:	data_out = d_out[15];
		endcase
	end

endmodule
