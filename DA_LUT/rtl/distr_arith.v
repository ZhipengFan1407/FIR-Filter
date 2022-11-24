`timescale 1ns/1ps


module distr_arith (
    input clk,
    input reset,
    input [7 : 0] x1_bit,   // 0~7
    input [7 : 0] x2_bit,   // 8~15
    input [7 : 0] x3_bit,   // 16~23
    input [7 : 0] x4_bit,   // 24~31
    input [7 : 0] x5_bit,   // 32~39
    input [7 : 0] x6_bit,   // 40~47
    input [7 : 0] x7_bit,   // 48~55
    input [7 : 0] x8_bit,   // 56~63
    output [31 : 0] sum
);

    // Wire and Bus Definition
    
    wire [31 : 0] LUT0_out;
    wire [31 : 0] LUT1_out;
    wire [31 : 0] LUT2_out;
    wire [31 : 0] LUT3_out;
    wire [31 : 0] LUT4_out;
    wire [31 : 0] LUT5_out;
    wire [31 : 0] LUT6_out;
    wire [31 : 0] LUT7_out;
    wire [31 : 0] add0_out;
    wire [31 : 0] add1_out;
    wire [31 : 0] add2_out;
    wire [31 : 0] add3_out;
    wire [31 : 0] add4_out;
    wire [31 : 0] add5_out;
    wire [31 : 0] add6_out;
    wire [31 : 0] add7_out;
    wire [31 : 0] leftshift_out;
    wire [31 : 0] dff0_out;
    wire counter_reach;
    
	//LUT Instantiation
	lut0 lut_0(.addr(x1_bit), .data_out(LUT0_out));
	lut1 lut_1(.addr(x2_bit), .data_out(LUT1_out));
	lut2 lut_2(.addr(x3_bit), .data_out(LUT2_out));
	lut3 lut_3(.addr(x4_bit), .data_out(LUT3_out));
	lut4 lut_4(.addr(x5_bit), .data_out(LUT4_out));
        lut5 lut_5(.addr(x6_bit), .data_out(LUT5_out));
        lut6 lut_6(.addr(x7_bit), .data_out(LUT6_out));
        lut7 lut_7(.addr(x8_bit), .data_out(LUT7_out));

	// Adder Instantiation
    adder add0 (.in_a(LUT0_out), .in_b(LUT1_out), .out(add0_out));
    adder add1 (.in_a(LUT2_out), .in_b(LUT3_out), .out(add1_out));
    adder add2 (.in_a(LUT4_out), .in_b(LUT5_out), .out(add2_out));
    adder add3 (.in_a(LUT6_out), .in_b(LUT7_out), .out(add3_out));
    adder add4 (.in_a(add0_out), .in_b(add1_out), .out(add4_out));
    adder add5 (.in_a(add2_out), .in_b(add3_out), .out(add5_out));
    adder add6 (.in_a(add4_out), .in_b(add5_out), .out(add6_out));
    adder add7 (.in_a(add6_out), .in_b(leftshift_out), .out(add7_out));


    // Shifter Instantiation
    left_shift_1 ls0 (.data_in(dff0_out), .data_out(leftshift_out));

    // DFF Instatiation
    dff_en dff0 (.enable(1'b1), .clk(clk), .data_in(add7_out), .data_out(dff0_out));
    
    dff_en dff1 (.enable(counter_reach), .clk(clk), .data_in(dff0_out), .data_out(sum));

    // Counter Instantiation
    counter counter0 (.reset(reset), .clk(clk), .count_reach(count_reach));



endmodule
