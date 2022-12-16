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
    wire reg_con [15:0] [63 : 0];
    wire sreg_out [15:0] [63:0]; //array of 16 bit wire type. 64 taps are in this array
	//64 taps, 16 bit inputs

//sreg_out[7:0] is 16 bit by 8 taps, the first 8
//sreg_out[7:0][0] is 1 bit by 8 taps

// component instantiation
    dcfifo fifo0(.areset_n(~reset), .wr_clk(clk2), .datain(input_data), .write(write), .rd_clk(clk3), .read(read), .q(fifo_out), .empty(empty), .full(full));
    distr_arith da0(.clk(clk3), .reset(reset), .x1_bit(sreg_out[0][7 : 0]), .x2_bit(sreg_out[0][15 : 8]), .x3_bit(sreg_out[0][23 : 16]), .x4_bit(sreg_out[0][31 : 24]), .x5_bit(sreg_out[0][39 : 32]), .x6_bit(sreg_out[0][47 : 40]), .x7_bit(sreg_out[0][55 : 48]), .x8_bit(sreg_out[0][63 : 56]), .sum(sum));

    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) begin
            if (i != 0) begin
                clk2_reg creg0(.clk2(clk2), .reg_in(reg_con[i - 1][63:56]), .reg_out(reg_con[i][63:56]));
                shift sreg0(.R(reg_con[i - 1][15:0]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[i][15:0]));
            end
            else begin
                clk2_reg creg0(.clk2(clk2), .reg_in(fifo_out), .reg_out(reg_con[0][15:0]));
                shift sreg0(.R(fifo_out), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[0][15:0]));
            end
        end
    endgenerate


    initial begin
        sreg_load_count <= 4'b0000;
        sreg_load <= 1'b1;
    end
    always @(posedge clk3) begin
        sreg_load_count = sreg_load_count + 1;
        sreg_load <= (sreg_load_count != 4'b0000) ? 1'b0 : 1'b1;
    end

endmodule




















