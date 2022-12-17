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
    wire reg_con [0:15] [0 : 63];
    wire sreg_out [0:15] [0:63]; //array of 16 bit wire type. 64 taps are in this array
	//64 taps, 16 bit inputs

//sreg_out[7:0] is 16 bit by 8 taps, the first 8
//sreg_out[7:0][0] is 1 bit by 8 taps

// component instantiation
    dcfifo fifo0(.areset_n(~reset), .wr_clk(clk2), .datain(input_data), .write(write), .rd_clk(clk3), .read(read), .q(fifo_out), .empty(empty), .full(full));
    distr_arith da0(.clk(clk3), .reset(reset), .x1_bit(sreg_out[15][0 : 7]), .x2_bit(sreg_out[15][8 : 15]), .x3_bit(sreg_out[15][16 : 23]), .x4_bit(sreg_out[15][24 : 31]), .x5_bit(sreg_out[15][32 : 39]), .x6_bit(sreg_out[15][40 : 47]), .x7_bit(sreg_out[15][48 : 55]), .x8_bit(sreg_out[15][56 : 63]), .sum(sum));

        clk2_reg creg0(.clk2(clk2), .reg_in(fifo_out), .reg_out(reg_con[0][0:15]));
        shift sreg0(.R(fifo_out), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[0][0:15]));


clk2_reg creg1 (.clk2(clk2), .reg_in(reg_con[0]), .reg_out(reg_con[1][0:15]));
shift sreg1(.R(reg_con[0][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[1][0:15]));
clk2_reg creg2 (.clk2(clk2), .reg_in(reg_con[1]), .reg_out(reg_con[2][0:15]));
shift sreg2(.R(reg_con[1][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[2][0:15]));
clk2_reg creg3 (.clk2(clk2), .reg_in(reg_con[2]), .reg_out(reg_con[3][0:15]));
shift sreg3(.R(reg_con[2][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[3][0:15]));
clk2_reg creg4 (.clk2(clk2), .reg_in(reg_con[3]), .reg_out(reg_con[4][0:15]));
shift sreg4(.R(reg_con[3][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[4][0:15]));
clk2_reg creg5 (.clk2(clk2), .reg_in(reg_con[4]), .reg_out(reg_con[5][0:15]));
shift sreg5(.R(reg_con[4][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[5][0:15]));
clk2_reg creg6 (.clk2(clk2), .reg_in(reg_con[5]), .reg_out(reg_con[6][0:15]));
shift sreg6(.R(reg_con[5][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[6][0:15]));
clk2_reg creg7 (.clk2(clk2), .reg_in(reg_con[6]), .reg_out(reg_con[7][0:15]));
shift sreg7(.R(reg_con[6][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[7][0:15]));
clk2_reg creg8 (.clk2(clk2), .reg_in(reg_con[7]), .reg_out(reg_con[8][0:15]));
shift sreg8(.R(reg_con[7][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[8][0:15]));
clk2_reg creg9 (.clk2(clk2), .reg_in(reg_con[8]), .reg_out(reg_con[9][0:15]));
shift sreg9(.R(reg_con[8][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[9][0:15]));
clk2_reg creg10 (.clk2(clk2), .reg_in(reg_con[9]), .reg_out(reg_con[10][0:15]));
shift sreg10(.R(reg_con[9][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[10][0:15]));
clk2_reg creg11 (.clk2(clk2), .reg_in(reg_con[10]), .reg_out(reg_con[11][0:15]));
shift sreg11(.R(reg_con[10][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[11][0:15]));
clk2_reg creg12 (.clk2(clk2), .reg_in(reg_con[11]), .reg_out(reg_con[12][0:15]));
shift sreg12(.R(reg_con[11][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[12][0:15]));
clk2_reg creg13 (.clk2(clk2), .reg_in(reg_con[12]), .reg_out(reg_con[13][0:15]));
shift sreg13(.R(reg_con[12][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[13][0:15]));
clk2_reg creg14 (.clk2(clk2), .reg_in(reg_con[13]), .reg_out(reg_con[14][0:15]));
shift sreg14(.R(reg_con[13][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[14][0:15]));
clk2_reg creg15 (.clk2(clk2), .reg_in(reg_con[14]), .reg_out(reg_con[15][0:15]));
shift sreg15(.R(reg_con[14][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[15][0:15]));
clk2_reg creg16 (.clk2(clk2), .reg_in(reg_con[15]), .reg_out(reg_con[16][0:15]));
shift sreg16(.R(reg_con[15][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[16][0:15]));
clk2_reg creg17 (.clk2(clk2), .reg_in(reg_con[16]), .reg_out(reg_con[17][0:15]));
shift sreg17(.R(reg_con[16][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[17][0:15]));
clk2_reg creg18 (.clk2(clk2), .reg_in(reg_con[17]), .reg_out(reg_con[18][0:15]));
shift sreg18(.R(reg_con[17][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[18][0:15]));
clk2_reg creg19 (.clk2(clk2), .reg_in(reg_con[18]), .reg_out(reg_con[19][0:15]));
shift sreg19(.R(reg_con[18][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[19][0:15]));
clk2_reg creg20 (.clk2(clk2), .reg_in(reg_con[19]), .reg_out(reg_con[20][0:15]));
shift sreg20(.R(reg_con[19][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[20][0:15]));
clk2_reg creg21 (.clk2(clk2), .reg_in(reg_con[20]), .reg_out(reg_con[21][0:15]));
shift sreg21(.R(reg_con[20][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[21][0:15]));
clk2_reg creg22 (.clk2(clk2), .reg_in(reg_con[21]), .reg_out(reg_con[22][0:15]));
shift sreg22(.R(reg_con[21][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[22][0:15]));
clk2_reg creg23 (.clk2(clk2), .reg_in(reg_con[22]), .reg_out(reg_con[23][0:15]));
shift sreg23(.R(reg_con[22][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[23][0:15]));
clk2_reg creg24 (.clk2(clk2), .reg_in(reg_con[23]), .reg_out(reg_con[24][0:15]));
shift sreg24(.R(reg_con[23][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[24][0:15]));
clk2_reg creg25 (.clk2(clk2), .reg_in(reg_con[24]), .reg_out(reg_con[25][0:15]));
shift sreg25(.R(reg_con[24][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[25][0:15]));
clk2_reg creg26 (.clk2(clk2), .reg_in(reg_con[25]), .reg_out(reg_con[26][0:15]));
shift sreg26(.R(reg_con[25][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[26][0:15]));
clk2_reg creg27 (.clk2(clk2), .reg_in(reg_con[26]), .reg_out(reg_con[27][0:15]));
shift sreg27(.R(reg_con[26][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[27][0:15]));
clk2_reg creg28 (.clk2(clk2), .reg_in(reg_con[27]), .reg_out(reg_con[28][0:15]));
shift sreg28(.R(reg_con[27][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[28][0:15]));
clk2_reg creg29 (.clk2(clk2), .reg_in(reg_con[28]), .reg_out(reg_con[29][0:15]));
shift sreg29(.R(reg_con[28][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[29][0:15]));
clk2_reg creg30 (.clk2(clk2), .reg_in(reg_con[29]), .reg_out(reg_con[30][0:15]));
shift sreg30(.R(reg_con[29][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[30][0:15]));
clk2_reg creg31 (.clk2(clk2), .reg_in(reg_con[30]), .reg_out(reg_con[31][0:15]));
shift sreg31(.R(reg_con[30][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[31][0:15]));
clk2_reg creg32 (.clk2(clk2), .reg_in(reg_con[31]), .reg_out(reg_con[32][0:15]));
shift sreg32(.R(reg_con[31][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[32][0:15]));
clk2_reg creg33 (.clk2(clk2), .reg_in(reg_con[32]), .reg_out(reg_con[33][0:15]));
shift sreg33(.R(reg_con[32][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[33][0:15]));
clk2_reg creg34 (.clk2(clk2), .reg_in(reg_con[33]), .reg_out(reg_con[34][0:15]));
shift sreg34(.R(reg_con[33][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[34][0:15]));
clk2_reg creg35 (.clk2(clk2), .reg_in(reg_con[34]), .reg_out(reg_con[35][0:15]));
shift sreg35(.R(reg_con[34][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[35][0:15]));
clk2_reg creg36 (.clk2(clk2), .reg_in(reg_con[35]), .reg_out(reg_con[36][0:15]));
shift sreg36(.R(reg_con[35][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[36][0:15]));
clk2_reg creg37 (.clk2(clk2), .reg_in(reg_con[36]), .reg_out(reg_con[37][0:15]));
shift sreg37(.R(reg_con[36][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[37][0:15]));
clk2_reg creg38 (.clk2(clk2), .reg_in(reg_con[37]), .reg_out(reg_con[38][0:15]));
shift sreg38(.R(reg_con[37][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[38][0:15]));
clk2_reg creg39 (.clk2(clk2), .reg_in(reg_con[38]), .reg_out(reg_con[39][0:15]));
shift sreg39(.R(reg_con[38][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[39][0:15]));
clk2_reg creg40 (.clk2(clk2), .reg_in(reg_con[39]), .reg_out(reg_con[40][0:15]));
shift sreg40(.R(reg_con[39][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[40][0:15]));
clk2_reg creg41 (.clk2(clk2), .reg_in(reg_con[40]), .reg_out(reg_con[41][0:15]));
shift sreg41(.R(reg_con[40][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[41][0:15]));
clk2_reg creg42 (.clk2(clk2), .reg_in(reg_con[41]), .reg_out(reg_con[42][0:15]));
shift sreg42(.R(reg_con[41][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[42][0:15]));
clk2_reg creg43 (.clk2(clk2), .reg_in(reg_con[42]), .reg_out(reg_con[43][0:15]));
shift sreg43(.R(reg_con[42][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[43][0:15]));
clk2_reg creg44 (.clk2(clk2), .reg_in(reg_con[43]), .reg_out(reg_con[44][0:15]));
shift sreg44(.R(reg_con[43][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[44][0:15]));
clk2_reg creg45 (.clk2(clk2), .reg_in(reg_con[44]), .reg_out(reg_con[45][0:15]));
shift sreg45(.R(reg_con[44][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[45][0:15]));
clk2_reg creg46 (.clk2(clk2), .reg_in(reg_con[45]), .reg_out(reg_con[46][0:15]));
shift sreg46(.R(reg_con[45][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[46][0:15]));
clk2_reg creg47 (.clk2(clk2), .reg_in(reg_con[46]), .reg_out(reg_con[47][0:15]));
shift sreg47(.R(reg_con[46][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[47][0:15]));
clk2_reg creg48 (.clk2(clk2), .reg_in(reg_con[47]), .reg_out(reg_con[48][0:15]));
shift sreg48(.R(reg_con[47][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[48][0:15]));
clk2_reg creg49 (.clk2(clk2), .reg_in(reg_con[48]), .reg_out(reg_con[49][0:15]));
shift sreg49(.R(reg_con[48][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[49][0:15]));
clk2_reg creg50 (.clk2(clk2), .reg_in(reg_con[49]), .reg_out(reg_con[50][0:15]));
shift sreg50(.R(reg_con[49][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[50][0:15]));
clk2_reg creg51 (.clk2(clk2), .reg_in(reg_con[50]), .reg_out(reg_con[51][0:15]));
shift sreg51(.R(reg_con[50][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[51][0:15]));
clk2_reg creg52 (.clk2(clk2), .reg_in(reg_con[51]), .reg_out(reg_con[52][0:15]));
shift sreg52(.R(reg_con[51][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[52][0:15]));
clk2_reg creg53 (.clk2(clk2), .reg_in(reg_con[52]), .reg_out(reg_con[53][0:15]));
shift sreg53(.R(reg_con[52][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[53][0:15]));
clk2_reg creg54 (.clk2(clk2), .reg_in(reg_con[53]), .reg_out(reg_con[54][0:15]));
shift sreg54(.R(reg_con[53][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[54][0:15]));
clk2_reg creg55 (.clk2(clk2), .reg_in(reg_con[54]), .reg_out(reg_con[55][0:15]));
shift sreg55(.R(reg_con[54][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[55][0:15]));
clk2_reg creg56 (.clk2(clk2), .reg_in(reg_con[55]), .reg_out(reg_con[56][0:15]));
shift sreg56(.R(reg_con[55][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[56][0:15]));
clk2_reg creg57 (.clk2(clk2), .reg_in(reg_con[56]), .reg_out(reg_con[57][0:15]));
shift sreg57(.R(reg_con[56][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[57][0:15]));
clk2_reg creg58 (.clk2(clk2), .reg_in(reg_con[57]), .reg_out(reg_con[58][0:15]));
shift sreg58(.R(reg_con[57][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[58][0:15]));
clk2_reg creg59 (.clk2(clk2), .reg_in(reg_con[58]), .reg_out(reg_con[59][0:15]));
shift sreg59(.R(reg_con[58][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[59][0:15]));
clk2_reg creg60 (.clk2(clk2), .reg_in(reg_con[59]), .reg_out(reg_con[60][0:15]));
shift sreg60(.R(reg_con[59][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[60][0:15]));
clk2_reg creg61 (.clk2(clk2), .reg_in(reg_con[60]), .reg_out(reg_con[61][0:15]));
shift sreg61(.R(reg_con[60][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[61][0:15]));
clk2_reg creg62 (.clk2(clk2), .reg_in(reg_con[61]), .reg_out(reg_con[62][0:15]));
shift sreg62(.R(reg_con[61][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[62][0:15]));
clk2_reg creg63 (.clk2(clk2), .reg_in(reg_con[62]), .reg_out(reg_con[63][0:15]));
shift sreg63(.R(reg_con[62][0:15]), .L(sreg_load), .w(1'b0), .Clock(clk3), .Q(sreg_out[63][0:15]));

    initial begin
        sreg_load_count <= 4'b0000;
        sreg_load <= 1'b1;
    end
    always @(posedge clk3) begin
        sreg_load_count = sreg_load_count + 1;
        sreg_load <= (sreg_load_count != 4'b0000) ? 1'b0 : 1'b1;
    end


endmodule




















