`timescale 1ns/1ps

`define HALF_CLK_PERIOD #5

module testbench();

//FOR MEMORY
reg clk;
reg [11:0] addr;
reg [15:0] d_in;
reg wen;
wire [15:0] d_out;


//FOR QUEUE
parameter DWIDTH = 16;
parameter AWIDTH = 3;

reg areset_n;
reg wr_clk, rd_clk;
reg [DWIDTH-1:0] datain;
reg write;
reg read;
wire [DWIDTH-1:0] q;
wire empty, full;


mem16kb mem1 (.address(addr), .data_in(d_in), .write_enable_n(wen), .clk(clk), .data_out(d_out));               // DUT instantiation


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

        always begin
		//FOR QUEUE
                `HALF_CLK_PERIOD;
                clk = ~clk;
        end



//FOR FIFO

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


//------------------------------

        initial begin
                //WRITE TO THE MEMORY
		clk <= 1'b1;

                @(negedge clk); //1
                wen <= 1'b0;
                addr <= 12'd1;
                d_in <= 16'd14514;

                @(negedge clk); //2
                wen = 1'b0;
                addr <= 12'd1407;
                d_in <= 16'd9810;

                @(negedge clk); //3
                wen <= 1'b0;
                addr <= 12'd500;
                d_in <= 16'd8750;

                @(negedge clk); //4
                wen <= 1'b0;
                addr <= 12'd996;
                d_in <= 16'd25610;
                
                @(negedge clk); //5
                wen <= 1'b0;
                addr <= 12'd2596;
                d_in <= 16'd30610;

                @(negedge clk); //6
                wen <= 1'b0;
                addr <= 12'd2560;
                d_in <= 16'd32610;

                @(negedge clk); //7
                wen <= 1'b0;
                addr <= 12'd3500;
                d_in <= 16'd40000;

                @(negedge clk); //8
                wen <= 1'b0;
                addr <= 12'd100;
                d_in <= 16'd2000;

                @(negedge clk); //9
                wen = 1'b0;
                addr <= 12'd200;
                d_in <= 16'd4000;

                @(negedge clk); //10
                wen <= 1'b0;
                addr <= 12'd300;
                d_in <= 16'd6000;

                @(negedge clk); //11
                wen <= 1'b0;
                addr <= 12'd400;
                d_in <= 16'd8000;

		//after this point, read from memory and append to the queue
		//the queue gets full after having 7  entries added to it (see
		//below)

//		datain = 0;
//		write = 0;
//		read = 0;
		#145;

                @(negedge clk); //1
                wen <= 1'b1;
                addr <= 12'd1;

		datain = d_out;
	        write = 1'b1;
        	#20 write = 1'b0;
        	#20

                @(negedge clk); //2
                wen <= 1'b1;
                addr <= 12'd1407;

		datain = d_out;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                @(negedge clk); //3
                wen <= 1'b1;
                addr <= 12'd500;

		datain = d_out;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                @(negedge clk); //4
                wen <= 1'b1;
                addr <= 12'd996;

		datain = d_out;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                @(negedge clk); //5
                wen <= 1'b1;
                addr <= 12'd2596;

		datain  = d_out;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                @(negedge clk); //6
                wen <= 1'b1;
                addr <= 12'd2560;

		datain  = d_out;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                @(negedge clk); //7
                wen <= 1'b1;
                addr <= 12'd3500;

		datain  = d_out;
                write = 1'b1;
                #20 write = 1'b0;
                #20

		//queue becomes full after this point.
		//full signal goes high
		//anything after this point, however, seems to prevent the
		//full signal from becoming high again
                @(negedge clk);
                wen <= 1'b1;
                addr <= 12'd100;

                datain = d_out;
                write = 1'b1;
                #20 write = 1'b0;
                #20
	

		//for some reason, it's reading from the 11th value appended
		//into the queue first. after that, it reads the first,
		//second, third, etc. I don't think this affects
		//functionality. however, it does not make logical sense.	
	        read = 1'b1;
        	#24 read = 1'b0;
        	#24

                @(negedge clk);
                wen <= 1'b1;
                addr <= 12'd200;

                datain = d_out;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                read = 1'b1;
                #24 read = 1'b0; //reads 11th element
                #24


                @(negedge clk);
                wen <= 1'b1;
                addr <= 12'd300;

                datain = d_out;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                read = 1'b1;
                #24 read = 1'b0; //reads 1st
                #24


                @(negedge clk);
                wen <= 1'b1;
                addr <= 12'd400;

                datain = d_out;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                read = 1'b1;
                #24 read = 1'b0; //reads 2nd
                #24

                @(negedge clk);
                wen <= 1'b1;
                addr <= 12'd500;

                datain = d_out;
                write = 1'b1;
                #20 write = 1'b0;
                #20

                read = 1'b1;
                #24 read = 1'b0; //reads 3rd
                #24


		@(negedge clk);
                $finish;

        end

endmodule








































