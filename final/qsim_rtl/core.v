`timescale 1us/1ns
//`timescale 1ns/1ps

//`define HALF_CLOCK3_PERIOD #0.5
`define HALF_CLOCK3_PERIOD #0.9

module testbench();

integer i = 0;

//FOR QUEUE
reg clk2, clk3;

reg write;
reg read;
reg reset;

reg [15:0] input_data;

wire empty, full;
wire[31:0] sum;

fir_filter_core core(.clk2(clk2), .clk3(clk3), .write(write), .read(read), .reset(reset), .input_data(input_data), .empty(empty), .full(full), .sum(sum));

initial begin
reset <= 0;
clk2 <= 0;
clk3 <= 0;
end


always begin
	`HALF_CLOCK3_PERIOD;

//	if (i % 100 == 0) begin
	clk2 = !clk2;
	//end
	clk3 = !clk3;
	i = i + 1;
end

//always @(clk2) #12 clk2 <= !clk2;
//always @(clk3) #10 clk3 <= !clk3;


initial begin
	input_data = 0;
	write = 0;
	read = 0;

	#100;

	input_data = 15'd1000;
	write = 1'b1;
	#20 write = 1'b0;
	#20;

        input_data = 15'd2000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;

        input_data = 15'd3000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;


        input_data = 15'd4000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;


        input_data = 15'd5000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;


        input_data = 15'd6000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;


        input_data = 15'd7000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;

        input_data = 15'd8000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;

        input_data = 15'd9000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;


        input_data = 15'd10000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;




        input_data = 15'd11000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;


        input_data = 15'd12000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;

        input_data = 15'd13000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;


        input_data = 15'd14000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;


        input_data = 15'd15000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;


        input_data = 15'd16000;
        write = 1'b1;
        #20 write = 1'b0;
        #20;


	$finish;
end
endmodule
