`timescale 1ns/1ps
// 32 bit input, 32 bit output, left shift by 1 bit, asynchronous
module left_shift_1(
    input [31 : 0] data_in,
    output [31 : 0] data_out
);

    assign data_out = data_in << 1;

endmodule