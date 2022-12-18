`timescale 1us/1ns

module dcfifo(
	input areset_n, 

	input wr_clk, 
 	input datain, 
	input write,

	input rd_clk,
	input read, 
	output q,
	output empty,
	output reg full
);

parameter DWIDTH=16;
parameter AWIDTH=6;
localparam  DEPTH=(1<<AWIDTH);

input wr_clk;
input areset_n;
input [DWIDTH-1:0] datain;
input write;

input rd_clk;
input read;
output [DWIDTH-1:0] q;
//reg full;
output empty;

//wire [DWIDTH-1:0] q;
wire [DWIDTH-1:0] data_int;
reg [AWIDTH-1:0] wptr, rptr;
reg [AWIDTH-1:0] wptr_ms, wptr_rd;
reg [AWIDTH-1:0] rptr_ms, rptr_wr;
wire [AWIDTH-1:0] wptr_next;
reg[AWIDTH-1:0] rptr_wr_bin;
wire [AWIDTH-1:0] rptr_gray;
wire [AWIDTH-1:0] wptr_gray;
reg [AWIDTH:0] fill;
integer i;

reg areset_n_ms, areset_n_wr;

always @(posedge wr_clk ) begin
	areset_n_ms <= areset_n;
	areset_n_wr <= areset_n_ms;
end

// create write section 
always @(posedge wr_clk or negedge areset_n_wr) begin
	if (!areset_n_wr) begin
		wptr <= #1 {AWIDTH{1'b0}};
	end else if (write) begin
		wptr <= #1 wptr+1;
	end
end

//always @* begin
 assign wptr_gray = (wptr >>1) ^ wptr;
 assign wptr_next = wptr+1;
 
 always @* begin
  full  = (wptr_next == rptr_wr_bin);
 end

always@(*)
   for (i=0; i<AWIDTH; i = i+1) begin
     rptr_wr_bin[i] = ^(rptr_wr >> i);
   end



always @(posedge wr_clk ) begin
	rptr_ms <= rptr_gray;
	rptr_wr <= rptr_ms;
end

always @(posedge rd_clk ) begin
	wptr_ms <= wptr_gray;
	wptr_rd <= wptr_ms;
end

//create read section
always @(posedge rd_clk or negedge areset_n_wr) begin
	if (!areset_n_wr) begin
		rptr <= #1 {AWIDTH{1'b0}};
	end else if (read) begin
		rptr <= #1 rptr+1;
	end
end

//always @* begin
assign rptr_gray = (rptr>>1) ^ rptr;
//end

assign q = data_int;


assign	empty = (rptr_gray == wptr_rd);

// instance of dual port RAM here 

dp_dcram #(DWIDTH, AWIDTH) dp_dcram_0(
	// write port
	.wr_clk(wr_clk),
	.addr0(wptr),
	.data0(datain),
	.we0(write),
	
	// read port 
	.rd_clk(rd_clk),
	.addr1(rptr),
	.q1(data_int),
	.re1(read)
);

endmodule // scfifo


















































