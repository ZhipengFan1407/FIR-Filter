`timescale 1ns/1ps
`define SD #0.010
`define HALF_CLOCK_PERIOD #5
`define QSIM_OUT_FN "./qsim.out"
`define INPUT_DATA "./input.results"
`define OUTPUT_DATA "./out.results"

module testbench();

	reg clk3;
	reg reset;
	wire signed [31:0] sum;
	reg signed [7:0] x1_bit, x2_bit, x3_bit, x4_bit, x5_bit, x6_bit, x7_bit, x8_bit;

   	integer input_file;
        integer qsim_out_file;
        integer out_file;
        integer i;
        integer ret_read;

        reg signed [31:0] out_file_reg;
        reg signed [31:0] lfsr_out_qsim;
        reg signed [7:0] input_out_file;
    

	distr_arith adder0(.clk3(clk3), .reset(reset), .x1_bit(x1_bit), .x2_bit(x2_bit), .x3_bit(x3_bit), .x4_bit(x4_bit), .x5_bit(x5_bit), .x6_bit(x6_bit), .x7_bit(x7_bit), .x8_bit(x8_bit), .sum(sum));

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
                if(!out_file) begin
                $display("Couldn't open the output file.");
                $finish;
                end

                qsim_out_file = $fopen(`QSIM_OUT_FN, "w"); //LOAD A QSIM FILE SO WE CAN WRITE TO IT
                if(!qsim_out_file) begin
                $display("Couldn't create the output file.");
                $finish;
                end


		clk3 = 0;
		reset = 0;

		@(posedge clk3);
		@(negedge clk3); //release reset
		reset = 1;

		@(posedge clk3); //starts the first cycle
                for(i = 0; i < 3; i=i+1) begin
                $display("i: %0d", i);

                ret_read = $fscanf(input_file, "%0d\n", x1_bit);
                $display("x1_bit: %0d", x1_bit);
                ret_read = $fscanf(input_file, "%0d\n", x2_bit);
                $display("x2_bit: %0d", x2_bit);

                ret_read = $fscanf(input_file, "%0d\n", x3_bit);
                $display("x3_bit: %0d", x3_bit);
                ret_read = $fscanf(input_file, "%0d\n", x4_bit);
                $display("x4_bit: %0d", x4_bit);


                ret_read = $fscanf(input_file, "%0d\n", x5_bit);
                $display("x5_bit: %0d", x5_bit);
                ret_read = $fscanf(input_file, "%0d\n", x6_bit);
                $display("x6_bit: %0d", x6_bit);


                ret_read = $fscanf(input_file, "%0d\n", x7_bit);
                $display("x7_bit: %0d", x7_bit);
                ret_read = $fscanf(input_file, "%0d\n", x8_bit);
                $display("x8_bit: %0d", x8_bit);

		ret_read = $fscanf(out_file,"%0d\n",out_file_reg);
                $display("output: %0d", out_file_reg);

@(posedge clk3);
@(posedge clk3);
@(posedge clk3);
@(posedge clk3);
@(posedge clk3);
@(posedge clk3);
@(posedge clk3);
@(posedge clk3);

                lfsr_out_qsim = sum;
                $display("sum: %0d", sum);
                $fwrite(qsim_out_file, "%0d\n", lfsr_out_qsim);

                end

                $fclose(qsim_out_file);
		$fclose(out_file);
                $finish;

        end

endmodule
