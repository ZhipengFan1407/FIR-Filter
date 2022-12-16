`timescale 1ns/1ps

module dp_dcram(
	wr_clk,
	addr0 ,
	data0,
	we0,

	rd_clk,
	addr1,
	q1,
	re1
);
parameter DWIDTH = 8;
parameter AWIDTH = 8;


input wr_clk;
input rd_clk;
input [DWIDTH-1:0] data0; 
output [DWIDTH-1:0] q1;
input [AWIDTH-1:0] addr0;
input [AWIDTH-1:0] addr1;
input we0, re1;

reg [DWIDTH-1:0] Mem [0:(1<<AWIDTH)-1];
reg [DWIDTH-1:0] q1;

always @(posedge wr_clk)
  if (we0)
    Mem[addr0] <= data0;

always @(posedge rd_clk)
  if (re1)
    q1 <=  Mem[addr1] ;

endmodule 






















