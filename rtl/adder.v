`timescale 1ns/1ps
// 32 bit inputs, 32 bit outputs, ignore overflow, asynchronous
module adder (
    input [31 : 0] in_a,
    input [31 : 0] in_b,
    output [31 : 0] out
);
    // too much work for writing a 32-bit adder with parallel structure, let verilog decide
    assign out = in_a + in_b;

endmodule