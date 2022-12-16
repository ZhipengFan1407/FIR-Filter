`timescale 1ns/1ps

`define HALF_CLOCK_PERIOD #0.90

module testbench();

//FOR QUEUE
parameter DWIDTH = 64;
parameter AWIDTH = 3;

reg areset_n;
reg wr_clk, rd_clk;
reg [DWIDTH-1:0] datain;
reg write;
reg read;
wire [DWIDTH-1:0] q;
wire empty, full;

//FOR DISTRUBTED ARITHMETIC	
wire signed [31:0] sum;
reg signed [7:0] x1_bit, x2_bit, x3_bit, x4_bit, x5_bit, x6_bit, x7_bit, x8_bit;

wire [31:0] dff0_out;
	wire [31:0] add6_out;
	wire [31:0] add7_out;
	wire [31:0] leftshift_out;
	wire counter_reach;

//INSTANTIATIONS 
dcfifo #(DWIDTH, AWIDTH) dcfifo_inst(
        .areset_n(areset_n),
        .wr_clk(wr_clk),
        .datain(datain),
        .write(write),

        .rd_clk(rd_clk),
        .read(read),
        .q(q),
        .empty(empty),
        .full(full)
);

distr_arith da0 (.clk(rd_clk), .reset(areset_n), .x1_bit(x1_bit), .x2_bit(x2_bit), .x3_bit(x3_bit), .x4_bit(x4_bit),
		.x5_bit(x5_bit), .x6_bit(x6_bit), .x7_bit(x7_bit), .x8_bit(x8_bit), 
		.add6_out(add6_out), .add7_out(add7_out), .leftshift_out(leftshift_out), .sum(sum), .dff0_out(dff0_out), .count_reach(count_reach));

//FOR QUEUE
initial begin
        areset_n <= 0;
        # 101 areset_n <= 1;
end

initial begin
        wr_clk <= 0;
        rd_clk <= 0;
end

always @(wr_clk) #10 wr_clk <= !wr_clk;
always @(rd_clk) #12 rd_clk <= !rd_clk;


//FOR DISTRIBUTED ARITHMETIC
        always begin
                `HALF_CLOCK_PERIOD;
        end

//------------------------------

        initial begin

		//after this point, read from memory and append to the queue
		//the queue gets full after having 7  entries added to it (see
		//below)

		datain = 0;
		write = 0;
		read = 0;


		//COMMENT FROM QUEUE CREATOR:
		//the FIFO can also act as a queue. On the read side, you can use the depth of
		//queue, and if depth of queue is greater than some value, you can start to
		//read the data from the dual clock fifo and then feed that data into your
		//compute engine.
		
		#145;

                //writing to queue

		datain = 64'd14514;
	        write = 1'b1;
        	#20 write = 1'b0;
        	#20

		//writing to queue

		datain = 64'd9810;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                //writing to queue

                datain = 64'd8750;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                //writing to queue

		datain = 64'd25610;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                //writing to queue

		datain  = 64'd30610;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                //writing to queue

		datain  = 64'd32610;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                //writing to queue

		datain  = 64'd40000;
                write = 1'b1;
                #20 write = 1'b0;
                #20

		//queue becomes full after this point.
		//full signal goes high
		//anything after this point, however, seems to prevent the
		//full signal from becoming high again
                //@(negedge clk);

                read = 1'b1; //reads 1st
                #24 read = 1'b0;
                #24

		x1_bit = q[63:56];
		x2_bit = q[55:48];
		x3_bit = q[47:40];
		x4_bit = q[39:32];
		x5_bit = q[31:24];
		x6_bit = q[23:16];
		x7_bit = q[15:8];
		x8_bit = q[7:0];

		@(posedge rd_clk);
		@(posedge rd_clk);
		@(posedge rd_clk);
		@(posedge rd_clk);
		
		@(posedge rd_clk);
		@(posedge rd_clk);
		@(posedge rd_clk);
		@(posedge rd_clk);

		@(posedge rd_clk);
		@(posedge rd_clk);
		@(posedge rd_clk);
		@(posedge rd_clk);

		@(posedge rd_clk);
		@(posedge rd_clk);
		@(posedge rd_clk);
		@(posedge rd_clk);

                datain = 64'd2000;
                write = 1'b1;
                #20 write = 1'b0;
                #20
	
                //@(negedge clk);
                read = 1'b1;
                #24 read = 1'b0;
                #24

                x1_bit = q[63:56];
                x2_bit = q[55:48];
                x3_bit = q[47:40];
                x4_bit = q[39:32];
                x5_bit = q[31:24];
                x6_bit = q[23:16];
                x7_bit = q[15:8];
                x8_bit = q[7:0];


                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);


                datain = 64'd4000;
                write = 1'b1;
                #20 write = 1'b0;
                #20
                
		//@(negedge clk);
                read = 1'b1;
                #24 read = 1'b0; //reads 3rd
                #24

                x1_bit = q[63:56];
                x2_bit = q[55:48];
                x3_bit = q[47:40];
                x4_bit = q[39:32];
                x5_bit = q[31:24];
                x6_bit = q[23:16];
                x7_bit = q[15:8];
                x8_bit = q[7:0];

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);


                datain = 64'd6000;
                write = 1'b1;
                #20 write = 1'b0;
                #20


                //@(negedge clk);
                read = 1'b1;
                #24 read = 1'b0; //reads 4th
                #24

                x1_bit = q[63:56];
                x2_bit = q[55:48];
                x3_bit = q[47:40];
                x4_bit = q[39:32];
                x5_bit = q[31:24];
                x6_bit = q[23:16];
                x7_bit = q[15:8];
                x8_bit = q[7:0];

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                datain = 64'd8000;
                write = 1'b1;
                #20 write = 1'b0;
                #20

		//reads 5th
                read = 1'b1;
                #24 read = 1'b0; 
                #24


                x1_bit = q[63:56];
                x2_bit = q[55:48];
                x3_bit = q[47:40];
                x4_bit = q[39:32];
                x5_bit = q[31:24];
                x6_bit = q[23:16];
                x7_bit = q[15:8];
                x8_bit = q[7:0];


                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);


                datain = 64'd4010;
                write = 1'b1;
                #20 write = 1'b0;
                #20

		//reads 6th
                read = 1'b1;
                #24 read = 1'b0; 
                #24

                x1_bit = q[63:56];
                x2_bit = q[55:48];
                x3_bit = q[47:40];
                x4_bit = q[39:32];
                x5_bit = q[31:24];
                x6_bit = q[23:16];
                x7_bit = q[15:8];
                x8_bit = q[7:0];


                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                datain = 64'd4020;
                write = 1'b1;
                #20 write = 1'b0;
                #20

		//reads 7th
                read = 1'b1;
                #24 read = 1'b0; 
                #24

                x1_bit = q[63:56];
                x2_bit = q[55:48];
                x3_bit = q[47:40];
                x4_bit = q[39:32];
                x5_bit = q[31:24];
                x6_bit = q[23:16];
                x7_bit = q[15:8];
                x8_bit = q[7:0];



                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);


                datain = 64'd4030;
                write = 1'b1;
                #20 write = 1'b0;
                #20
	
		//reads 8th
                read = 1'b1;
                #24 read = 1'b0; 
                #24


                x1_bit = q[63:56];
                x2_bit = q[55:48];
                x3_bit = q[47:40];
                x4_bit = q[39:32];
                x5_bit = q[31:24];
                x6_bit = q[23:16];
                x7_bit = q[15:8];
                x8_bit = q[7:0];



                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                datain = 64'd4040;
                write = 1'b1;
                #20 write = 1'b0;
                #20

		//reads 9th
                read = 1'b1;
                #24 read = 1'b0; 
                #24

                x1_bit = q[63:56];
                x2_bit = q[55:48];
                x3_bit = q[47:40];
                x4_bit = q[39:32];
                x5_bit = q[31:24];
                x6_bit = q[23:16];
                x7_bit = q[15:8];
                x8_bit = q[7:0];



                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);


                datain = 64'd4050;
                write = 1'b1;
                #20 write = 1'b0;
                #20


		//reads 10th
                read = 1'b1;
                #24 read = 1'b0; 
                #24

                x1_bit = q[63:56];
                x2_bit = q[55:48];
                x3_bit = q[47:40];
                x4_bit = q[39:32];
                x5_bit = q[31:24];
                x6_bit = q[23:16];
                x7_bit = q[15:8];
                x8_bit = q[7:0];


                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);


                datain = 64'd4060;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);


                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);


                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);

                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);
                @(posedge rd_clk);


		//@(negedge clk);
                #50 $finish;

        end

endmodule








































