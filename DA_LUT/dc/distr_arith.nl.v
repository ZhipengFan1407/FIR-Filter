/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : O-2018.06-SP5-1
// Date      : Wed Nov 23 20:25:27 2022
/////////////////////////////////////////////////////////////


module distr_arith ( clk, reset, x1_bit, x2_bit, x3_bit, x4_bit, x5_bit, 
        x6_bit, x7_bit, x8_bit, sum );
  input [7:0] x1_bit;
  input [7:0] x2_bit;
  input [7:0] x3_bit;
  input [7:0] x4_bit;
  input [7:0] x5_bit;
  input [7:0] x6_bit;
  input [7:0] x7_bit;
  input [7:0] x8_bit;
  output [31:0] sum;
  input clk, reset;


  INVX2TS U2 ( .A(1'b0), .Y(sum[0]) );
  INVX2TS U4 ( .A(1'b0), .Y(sum[1]) );
  INVX2TS U6 ( .A(1'b0), .Y(sum[2]) );
  INVX2TS U8 ( .A(1'b0), .Y(sum[3]) );
  INVX2TS U10 ( .A(1'b0), .Y(sum[4]) );
  INVX2TS U12 ( .A(1'b0), .Y(sum[5]) );
  INVX2TS U14 ( .A(1'b0), .Y(sum[6]) );
  INVX2TS U16 ( .A(1'b0), .Y(sum[7]) );
  INVX2TS U18 ( .A(1'b0), .Y(sum[8]) );
  INVX2TS U20 ( .A(1'b0), .Y(sum[9]) );
  INVX2TS U22 ( .A(1'b0), .Y(sum[10]) );
  INVX2TS U24 ( .A(1'b0), .Y(sum[11]) );
  INVX2TS U26 ( .A(1'b0), .Y(sum[12]) );
  INVX2TS U28 ( .A(1'b0), .Y(sum[13]) );
  INVX2TS U30 ( .A(1'b0), .Y(sum[14]) );
  INVX2TS U32 ( .A(1'b0), .Y(sum[15]) );
  INVX2TS U34 ( .A(1'b0), .Y(sum[16]) );
  INVX2TS U36 ( .A(1'b0), .Y(sum[17]) );
  INVX2TS U38 ( .A(1'b0), .Y(sum[18]) );
  INVX2TS U40 ( .A(1'b0), .Y(sum[19]) );
  INVX2TS U42 ( .A(1'b0), .Y(sum[20]) );
  INVX2TS U44 ( .A(1'b0), .Y(sum[21]) );
  INVX2TS U46 ( .A(1'b0), .Y(sum[22]) );
  INVX2TS U48 ( .A(1'b0), .Y(sum[23]) );
  INVX2TS U50 ( .A(1'b0), .Y(sum[24]) );
  INVX2TS U52 ( .A(1'b0), .Y(sum[25]) );
  INVX2TS U54 ( .A(1'b0), .Y(sum[26]) );
  INVX2TS U56 ( .A(1'b0), .Y(sum[27]) );
  INVX2TS U58 ( .A(1'b0), .Y(sum[28]) );
  INVX2TS U60 ( .A(1'b0), .Y(sum[29]) );
  INVX2TS U62 ( .A(1'b0), .Y(sum[30]) );
  INVX2TS U64 ( .A(1'b0), .Y(sum[31]) );
endmodule

