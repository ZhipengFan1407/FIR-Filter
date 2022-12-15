`timescale 1ns/1ps

`define HALF_CLK_PERIOD #5

module testbench();

//FOR MEMORY
reg clk;
reg [11:0] addr;
reg [15:0] d_in;
reg wen;
wire [15:0] d_out;

/*
//FOR QUEUE

parameter DWIDTH = 8;
parameter AWIDTH = 3;

reg areset_n;
reg wr_clk, rd_clk;
reg [DWIDTH-1:0] datain;
reg write;
reg read;
wire [DWIDTH-1:0] q;
wire empty, full;
*/

mem16kb mem1 (.address(addr), .data_in(d_in), .write_enable_n(wen), .clk(clk), .data_out(d_out));               // DUT instantiation

/*
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
*/
        always begin
		//FOR QUEUE
                `HALF_CLK_PERIOD;
                clk = ~clk;
        end

/*
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
*/
//-----------------------------

        initial begin
                //WRITE TO THE MEMORY
		clk <= 1'b1;

                @(negedge clk);
                wen <= 1'b0;
                addr <= 12'd1;
                d_in <= 16'd14514;

                @(negedge clk);
                wen = 1'b0;
                addr <= 12'd1407;
                d_in <= 16'd9810;

                @(negedge clk);
                wen <= 1'b0;
                addr <= 12'd500;
                d_in <= 16'd8750;

                @(negedge clk);
                wen <= 1'b0;
                addr <= 12'd996;
                d_in <= 16'd25610;
                
                @(negedge clk);
                wen <= 1'b0;
                addr <= 12'd2596;
                d_in <= 16'd30610;

                @(negedge clk);
                wen <= 1'b0;
                addr <= 12'd2560;
                d_in <= 32'd32610;

                @(negedge clk);
                wen <= 1'b0;
                addr <= 12'd3500;
                d_in <= 32'd40000;

		//after this point, read from memory		

                @(negedge clk);
                wen <= 1'b1;
                addr <= 12'd1;

                @(negedge clk);
                wen <= 1'b1;
                addr <= 12'd1407;

                @(negedge clk);
                wen <= 1'b1;
                addr <= 12'd500;

                @(negedge clk);
                wen <= 1'b1;
                addr <= 12'd996;

                @(negedge clk);
                wen <= 1'b1;
                addr <= 12'd2596;

                @(negedge clk);
                wen <= 1'b1;
                addr <= 12'd2560;

                @(negedge clk);
                wen <= 1'b1;
                addr <= 12'd3500;


/*
        datain = 0;
        write = 0;
        read = 0;
        #145

        datain = 8'h31;
        write = 1'b1;
        #20 write = 1'b0;
        #20

        datain = 8'h32;
        write = 1'b1;
        #20 write = 1'b0;
        #20

        datain = 8'h33;
        write = 1'b1;
        #20 write = 1'b0;
        #20

        datain = 8'h34;
        write = 1'b1;
        #20 write = 1'b0;
        #20

        datain = 8'h35;
        write = 1'b1;
        #20 write = 1'b0;
        #20


        datain = 8'h36;
        write = 1'b1;
        #20 write = 1'b0;
        #20
*/

		@(negedge clk);
                $finish;

        end

endmodule








































