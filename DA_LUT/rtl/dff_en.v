























`timescale 1ns/1ps
module dff_en(
    input enable,
    input reset,
    input clk,
    input [31 : 0] data_in,
    output reg [31: 0] data_out
);
	initial begin
		data_out <= 32'd0;
	end
       always @(posedge clk, posedge reset) begin
        data_out <= reset == 1'b1 ? 32'd0 : enable == 1'b1 ? data_in : 32'd0;
    end


endmodule
