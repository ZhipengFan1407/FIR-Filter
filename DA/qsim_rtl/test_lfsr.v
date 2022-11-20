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
	reg signed [15:0] LUT0_out, LUT1_out, LUT2_out, LUT3_out, LUT4_out, LUT5_out, LUT6_out, LUT7_out;

   	integer input_file;
        integer qsim_out_file;
        integer out_file;
        integer i;
        integer ret_read;

        reg signed [15:0] out_file_reg;
        reg signed [31:0] lfsr_out_qsim;
        reg signed [15:0] input_out_file;
    

	distr_arith adder0(.clk3(clk3), .reset(reset), .LUT0_out(LUT0_out), .LUT1_out(LUT1_out), .LUT2_out(LUT2_out), .LUT3_out(LUT3_out), .LUT4_out(LUT4_out), .LUT5_out(LUT5_out), .LUT6_out(LUT6_out), .LUT7_out(LUT7_out), .sum(sum));

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

		ret_read = $fscanf(out_file,"%0d\n",out_file_reg);
                $display("output:%0d", out_file_reg);

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
