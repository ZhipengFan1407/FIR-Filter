

`timescale 1 ns/100ps

module testbench();
parameter DWIDTH = 8;
parameter AWIDTH = 3;

reg areset_n;
reg wr_clk, rd_clk;
reg [DWIDTH-1:0] datain;
reg write;
reg read;
wire [DWIDTH-1:0] q;
wire empty, full;

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


initial 
begin
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


	datain = 8'h37;
	write = 1'b1;
	#20 write = 1'b0;
	#20


	read = 1'b1;
	#24 read = 1'b0;
	#24

	read = 1'b1;
	#24 read = 1'b0;
	#24

	read = 1'b1;
	#24 read = 1'b0;
	#24

	read = 1'b1;
	#24 read = 1'b0;
	#24

	read = 1'b1;
	#24 read = 1'b0;
	#24

	read = 1'b1;
	#24 read = 1'b0;
	#24

	read = 1'b1;
	#24 read = 1'b0;
	#24

	#50 $finish;

end


initial
 begin
    $dumpfile("dcfifo.vcd");
    $dumpvars(0,dcfifo_inst);
 end

endmodule // tb





























































