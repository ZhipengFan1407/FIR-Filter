`timescale 1ns/1ps
// this register is controlled by clk2, it is used for the delay chain for x
module clk2_reg (
    input clk2,
    input [15 : 0] reg_in,
    output reg [15 : 0] reg_out
);

    always @(posedge clk2) begin
       reg_out <= reg_in; 
    end

endmodule