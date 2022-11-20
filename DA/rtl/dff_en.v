`timescale 1ns/1ps
// 32 bit input, 32 bit output, D Flip Flop with Enable feature, Enable is not used for
// the scale accumulation, but the output sum since only output after all 16 bits of
// all inputs are processed
module dff_en(
    input enable,
    input clk,
    input [31 : 0] data_in,
    output reg [31: 0] data_out
);

    always @(posedge clk) begin
        if (enable == 1'b1) begin
            data_in <= data_out;
        end
    end

endmodule
