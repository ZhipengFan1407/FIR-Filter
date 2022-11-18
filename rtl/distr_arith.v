`timescale 1ns/1ps

module distr_arith (
    input clk3,
    input [7 : 0] x1_bit,   // 0~7
    input [7 : 0] x2_bit,   // 8~15
    input [7 : 0] x3_bit,   // 16~23
    input [7 : 0] x4_bit,   // 24~31
    input [7 : 0] x5_bit,   // 32~39
    input [7 : 0] x6_bit,   // 40~47
    input [7 : 0] x7_bit,   // 48~55
    input [7 : 0] x8_bit,   // 56~63
    output reg [31 : 0] sum
);

    // Wire and Bus Definition

    // Look-Up Table Instantiation

    // Adder Instantiation

    // Shifter Instantiation

    // DFF Instatiation

    // Counter Instantiation

    // Sum Assignment until Counter done

endmodule