`timescale 1ns/1ps
`define SD #0.010
`define HALF_CLOCK_PERIOD #5
`define QSIM_OUT_FN "./qsim.out"
`define INPUT_DATA "./input.results"
`define OUTPUT_DATA "./out.results"


module distr_arith (
    input clk3,
    input reset,
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

	integer input_file;
	integer qsim_out_file;
	integer out_file;
	integer i;
	integer ret_read;

        reg signed [20:0] out_file_reg;
        reg signed [20:0] lfsr_out_qsim;
        reg signed [20:0] input_out_file;

    // Look-Up Table Instantiation

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
    dff_en dff0 (.enable(1'b1), .clk(clk3), .data_in(add7_out), .data_out(dff0_out));
    dff_en dff1 (.enable(counter_reach), .clk(clk3), .data_in(dff0_out), .data_out(sum));

    // Counter Instantiation
    counter counter0 (.reset(reset), .clk(clk3), .count_reach(count_reach));


        always begin
                `HALF_CLOCK_PERIOD;
                clk3 = ~clk3;
        end


	initial begin

                input_file = $fopen(`INPUT_DATA, "rb"); //LOAD IN THE INPUT LUT DATA
                if(!input_file) begin
                $display("Couldn't open the input file.");
                $finish;
                end

                out_file = $fopen(`OUTPUT_DATA, "rb"); //LOAD IN OUTPUT FILE TO COMPARE ANSWERS WITH
                if(!matlab_out_file) begin
                $display("Couldn't open the output file.");
                $finish;
                end


                qsim_out_file = $fopen(`QSIM_OUT_FN, "w"); //LOAD A QSIM FILE SO WE CAN WRITE TO IT
                if(!qsim_out_file) begin
                $display("Couldn't create the output file.");
                $finish;
                end


		clk3 <= 0;

		@(posedge clk);

                for(i = 0; i < 2; i=i+1) begin
                $display("i: %0d", i);

                ret_read = $fscanf(input_file, "%0d\n", LUT0_out);
                $display("LUT0: %0d", LUT0_out);
                ret_read = $fscanf(input_file, "%0d\n", LUT1_out);
                $display("LUT1: %0d", LUT1_out);

                ret_read = $fscanf(input_file, "%0d\n", LUT2_out);
                $display("LUT2: %0d", LUT2_out);
                ret_read = $fscanf(input_file, "%0d\n", LUT3_out);
                $display("LUT3: %0d", LUT3_out);


                ret_read = $fscanf(input_file, "%0d\n", LUT4_out);
                $display("LUT4: %0d", LUT4_out);
                ret_read = $fscanf(input_file, "%0d\n", LUT5_out);
                $display("LUT5: %0d", LUT5_out);


                ret_read = $fscanf(input_file, "%0d\n", LUT6_out);
                $display("LUT6: %0d", LUT6_out);
                ret_read = $fscanf(input_file, "%0d\n", LUT7_out);
                $display("LUT7: %0d", LUT7_out);

                //compare with results from the simulation
                ret_read = $fscanf(out_file,"%0d\n",out_file_reg);
                $display("output:%0d", out_file_reg);
		
//posedge clocks here
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);	

                lfsr_out_qsim = S;
                $display("s: %0d", S);
		$fwrite(qsim_out_file, "%0d\n", lfsr_out_qsim);

		end
	
		$fclose(qsim_out_file);
		$finish;

	end




endmodule
