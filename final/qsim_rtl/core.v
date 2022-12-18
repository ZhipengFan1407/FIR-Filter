`timescale 1us/1ns

`define HALF_CLOCK3_PERIOD #0.5

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
	if (i % 100 == 0) begin
	clk2 = ~clk2;
	end
	`HALF_CLOCK3_PERIOD;
	clk3 = ~clk3;
	i = i + 1;
end


initial begin

	input_data = 0;
	write = 0;
	read = 0;

	#100;

	input_data = 15'd1000;
	write = 1'b1;
	#2 write = 1'b0;
	#100;

        input_data = 15'd2000;
        write = 1'b1;
        #2 write = 1'b0;
        #100;

        input_data = 15'd3000;
        write = 1'b1;
        #2 write = 1'b0;
        #100;


        input_data = 15'd4000;
        write = 1'b1;
        #2 write = 1'b0;
        #100;


        input_data = 15'd5000;
        write = 1'b1;
        #2 write = 1'b0;
        #100;


        input_data = 15'd6000;
        write = 1'b1;
        #2 write = 1'b0;
        #100;

	$finish;
end
endmodule
