`timescale 1ns/1ps
// the final FIR core RTL assembly
module fir_filter_core(
    input clk2,         // outside clock
    input clk3,         // internal clock for DA and shift registers
    input write,        // external control for fifo write
    input read,         // external control for fifo read
    input reset,        // external reset
    input [15 : 0] input_data,
    output empty,       // external signal for fifo empty
    output full,        // external signal for fifo full
    output [31 : 0] sum
);

// wires and buses
    input clk2, clk3, write, read, reset;
    //added two lines above
    //
    reg [3 : 0] sreg_load_count;
    reg sreg_load;
    wire [15 : 0] fifo_out;

    //2d
    wire [15:0] reg_con [0:63]; //I think this is actually saying that we have 16 taps, each of which contains 64 bits.  
    wire [15:0] sreg_out [63:0];
	wire [7:0] x1_wires;
	wire [7:0] x2_wires;
	wire [7:0] x3_wires;
	wire [7:0] x4_wires;
	wire [7:0] x5_wires;
	wire [7:0] x6_wires;
	wire [7:0] x7_wires;
	wire [7:0] x8_wires;
		
	genvar j;
	for (j = 0; j < 8; j = j + 1) begin
		assign x1_wires[j] = sreg_out[j][0];
		assign x2_wires[j] = sreg_out[j+8][0];
		assign x3_wires[j] = sreg_out[j+16][0];
		assign x4_wires[j] = sreg_out[j+24][0];
		assign x5_wires[j] = sreg_out[j+32][0];
		assign x6_wires[j] = sreg_out[j+40][0];
		assign x7_wires[j] = sreg_out[j+48][0];
		assign x8_wires[j] = sreg_out[j+56][0];
	end
    //64 taps, 16 bit inputs
    //sreg_out[7:0] is 16 bit by 8 taps, the first 8
    //sreg_out[7:0][0] is 1 bit by 8 taps

//2d - I think this is wrong because our code is saying we have 16 taps. Each
//tap has 64 bits. Because i goes up to 64, we go beyond 16 taps and run into
//indexing problems. This will most likely have to be redesigned starting from
//how we define regcon and sreg_out
   genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) 
    	begin: reg_generator
            if (i != 0) begin
                clk2_reg creg0 (.clk2(clk2), .reg_in(reg_con[i - 1]), .reg_out(reg_con[i]));
                shift sreg0 (.R(reg_con[i - 1]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[i]));
            end
            else begin
                clk2_reg creg0 (.clk2(clk2), .reg_in(fifo_out), .reg_out(reg_con[0]));
                shift sreg0 (.R(fifo_out), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[0]));
            end
        end
    endgenerate

//1d version
//wire reg_con[63:0]; //this is most likely wrong. You have 64 taps, each of which has 16 bits. When I index, I get 7 taps but they are interpreted as single bits.
//wire sreg_out[63:0];

// component instantiation
dcfifo fifo0(.areset_n(~reset), .wr_clk(clk2), .datain(input_data), .write(write), .rd_clk(clk3), .read(read), .q(fifo_out), .empty(empty), .full(full));

//1d
//distr_arith da0(.clk(clk3), .reset(reset), .x1_bit(sreg_out[63:56]), .x2_bit(sreg_out[55:48]), .x3_bit(sreg_out[47:40]), .x4_bit(sreg_out[39:32]), .x5_bit(sreg_out[31:24]), .x6_bit(sreg_out[23:16]), .x7_bit(sreg_out[15:8]), .x8_bit(sreg_out[7:0]), .sum(sum));

//2d
distr_arith da0(.clk(clk3), .reset(reset), .x1_bit(x1_wires), .x2_bit(x2_wires), .x3_bit(x3_wires), .x4_bit(x4_wires), .x5_bit(x5_wires), .x6_bit(x6_wires), .x7_bit(x7_wires), .x8_bit(x8_wires), .sum(sum));

/*
//1d
   genvar i;
    generate
        for (i = 0; i < 64; i = i + 1)
        begin: reg_generator
            if (i != 0) begin
                clk2_reg creg0 (.clk2(clk2), .reg_in(reg_con[15:0]), .reg_out(reg_con[15:0]));
                shift sreg0 (.R(reg_con[15:0]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[15:0]));
            end
            else begin
                clk2_reg creg0 (.clk2(clk2), .reg_in(fifo_out), .reg_out(reg_con[15:0]));
                shift sreg0 (.R(fifo_out), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[15:0]));
            end
        end
    endgenerate
*/

    initial begin
        sreg_load_count <= 4'b0000;
        sreg_load <= 1'b1;
    end
    always @(posedge clk3) begin
        sreg_load_count = sreg_load_count + 1;
        sreg_load <= (sreg_load_count != 4'b0000) ? 1'b0 : 1'b1;
		
    end
    
endmodule
