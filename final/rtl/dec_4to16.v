`timescale 1ns/1ps

module dec_4to16(input [3:0] d_in, output reg [15:0] d_out);

	parameter one_hot = 16'b0000000000000001;

	always @(*) begin
		case (d_in)
		4'd0:	d_out = ~one_hot;
		4'd1:   d_out = ~(one_hot << 1);
		4'd2:   d_out = ~(one_hot << 2);
		4'd3:   d_out = ~(one_hot << 3);
		4'd4:   d_out = ~(one_hot << 4);
		4'd5:   d_out = ~(one_hot << 5);
		4'd6:   d_out = ~(one_hot << 6);
		4'd7:   d_out = ~(one_hot << 7);
		4'd8:   d_out = ~(one_hot << 8);
		4'd9:   d_out = ~(one_hot << 9);
		4'd10:   d_out = ~(one_hot << 10);
		4'd11:   d_out = ~(one_hot << 11);
		4'd12:   d_out = ~(one_hot << 12);
		4'd13:   d_out = ~(one_hot << 13);
		4'd14:   d_out = ~(one_hot << 14);
		4'd15:   d_out = ~(one_hot << 15);
		default: d_out = ~16'b0;
		endcase
	end

endmodule
