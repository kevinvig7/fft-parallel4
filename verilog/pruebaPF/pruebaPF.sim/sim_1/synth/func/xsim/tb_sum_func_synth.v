// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Sep  2 11:05:33 2019
// Host        : Cacuy running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               C:/fft-parallel4/verilog/pruebaPF/pruebaPF.sim/sim_1/synth/func/xsim/tb_sum_func_synth.v
// Design      : sat
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k70tfbv676-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* NBITS_IN = "21" *) (* NBITS_OUT = "20" *) 
(* NotValidForBitStream *)
module sat
   (sat_out,
    sat_in);
  output [19:0]sat_out;
  input [20:0]sat_in;

  wire [20:0]sat_in;
  wire [20:0]sat_in_IBUF;
  wire [19:0]sat_out;
  wire [19:0]sat_out_OBUF;

  IBUF \sat_in_IBUF[0]_inst 
       (.I(sat_in[0]),
        .O(sat_in_IBUF[0]));
  IBUF \sat_in_IBUF[10]_inst 
       (.I(sat_in[10]),
        .O(sat_in_IBUF[10]));
  IBUF \sat_in_IBUF[11]_inst 
       (.I(sat_in[11]),
        .O(sat_in_IBUF[11]));
  IBUF \sat_in_IBUF[12]_inst 
       (.I(sat_in[12]),
        .O(sat_in_IBUF[12]));
  IBUF \sat_in_IBUF[13]_inst 
       (.I(sat_in[13]),
        .O(sat_in_IBUF[13]));
  IBUF \sat_in_IBUF[14]_inst 
       (.I(sat_in[14]),
        .O(sat_in_IBUF[14]));
  IBUF \sat_in_IBUF[15]_inst 
       (.I(sat_in[15]),
        .O(sat_in_IBUF[15]));
  IBUF \sat_in_IBUF[16]_inst 
       (.I(sat_in[16]),
        .O(sat_in_IBUF[16]));
  IBUF \sat_in_IBUF[17]_inst 
       (.I(sat_in[17]),
        .O(sat_in_IBUF[17]));
  IBUF \sat_in_IBUF[18]_inst 
       (.I(sat_in[18]),
        .O(sat_in_IBUF[18]));
  IBUF \sat_in_IBUF[19]_inst 
       (.I(sat_in[19]),
        .O(sat_in_IBUF[19]));
  IBUF \sat_in_IBUF[1]_inst 
       (.I(sat_in[1]),
        .O(sat_in_IBUF[1]));
  IBUF \sat_in_IBUF[20]_inst 
       (.I(sat_in[20]),
        .O(sat_in_IBUF[20]));
  IBUF \sat_in_IBUF[2]_inst 
       (.I(sat_in[2]),
        .O(sat_in_IBUF[2]));
  IBUF \sat_in_IBUF[3]_inst 
       (.I(sat_in[3]),
        .O(sat_in_IBUF[3]));
  IBUF \sat_in_IBUF[4]_inst 
       (.I(sat_in[4]),
        .O(sat_in_IBUF[4]));
  IBUF \sat_in_IBUF[5]_inst 
       (.I(sat_in[5]),
        .O(sat_in_IBUF[5]));
  IBUF \sat_in_IBUF[6]_inst 
       (.I(sat_in[6]),
        .O(sat_in_IBUF[6]));
  IBUF \sat_in_IBUF[7]_inst 
       (.I(sat_in[7]),
        .O(sat_in_IBUF[7]));
  IBUF \sat_in_IBUF[8]_inst 
       (.I(sat_in[8]),
        .O(sat_in_IBUF[8]));
  IBUF \sat_in_IBUF[9]_inst 
       (.I(sat_in[9]),
        .O(sat_in_IBUF[9]));
  OBUF \sat_out_OBUF[0]_inst 
       (.I(sat_out_OBUF[0]),
        .O(sat_out[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[0]_inst_i_1 
       (.I0(sat_in_IBUF[0]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[0]));
  OBUF \sat_out_OBUF[10]_inst 
       (.I(sat_out_OBUF[10]),
        .O(sat_out[10]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[10]_inst_i_1 
       (.I0(sat_in_IBUF[10]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[10]));
  OBUF \sat_out_OBUF[11]_inst 
       (.I(sat_out_OBUF[11]),
        .O(sat_out[11]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[11]_inst_i_1 
       (.I0(sat_in_IBUF[11]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[11]));
  OBUF \sat_out_OBUF[12]_inst 
       (.I(sat_out_OBUF[12]),
        .O(sat_out[12]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[12]_inst_i_1 
       (.I0(sat_in_IBUF[12]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[12]));
  OBUF \sat_out_OBUF[13]_inst 
       (.I(sat_out_OBUF[13]),
        .O(sat_out[13]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[13]_inst_i_1 
       (.I0(sat_in_IBUF[13]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[13]));
  OBUF \sat_out_OBUF[14]_inst 
       (.I(sat_out_OBUF[14]),
        .O(sat_out[14]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[14]_inst_i_1 
       (.I0(sat_in_IBUF[14]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[14]));
  OBUF \sat_out_OBUF[15]_inst 
       (.I(sat_out_OBUF[15]),
        .O(sat_out[15]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[15]_inst_i_1 
       (.I0(sat_in_IBUF[15]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[15]));
  OBUF \sat_out_OBUF[16]_inst 
       (.I(sat_out_OBUF[16]),
        .O(sat_out[16]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[16]_inst_i_1 
       (.I0(sat_in_IBUF[16]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[16]));
  OBUF \sat_out_OBUF[17]_inst 
       (.I(sat_out_OBUF[17]),
        .O(sat_out[17]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[17]_inst_i_1 
       (.I0(sat_in_IBUF[17]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[17]));
  OBUF \sat_out_OBUF[18]_inst 
       (.I(sat_out_OBUF[18]),
        .O(sat_out[18]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[18]_inst_i_1 
       (.I0(sat_in_IBUF[18]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[18]));
  OBUF \sat_out_OBUF[19]_inst 
       (.I(sat_out_OBUF[19]),
        .O(sat_out[19]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \sat_out_OBUF[19]_inst_i_1 
       (.I0(sat_in_IBUF[19]),
        .I1(sat_in_IBUF[20]),
        .O(sat_out_OBUF[19]));
  OBUF \sat_out_OBUF[1]_inst 
       (.I(sat_out_OBUF[1]),
        .O(sat_out[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[1]_inst_i_1 
       (.I0(sat_in_IBUF[1]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[1]));
  OBUF \sat_out_OBUF[2]_inst 
       (.I(sat_out_OBUF[2]),
        .O(sat_out[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[2]_inst_i_1 
       (.I0(sat_in_IBUF[2]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[2]));
  OBUF \sat_out_OBUF[3]_inst 
       (.I(sat_out_OBUF[3]),
        .O(sat_out[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[3]_inst_i_1 
       (.I0(sat_in_IBUF[3]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[3]));
  OBUF \sat_out_OBUF[4]_inst 
       (.I(sat_out_OBUF[4]),
        .O(sat_out[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[4]_inst_i_1 
       (.I0(sat_in_IBUF[4]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[4]));
  OBUF \sat_out_OBUF[5]_inst 
       (.I(sat_out_OBUF[5]),
        .O(sat_out[5]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[5]_inst_i_1 
       (.I0(sat_in_IBUF[5]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[5]));
  OBUF \sat_out_OBUF[6]_inst 
       (.I(sat_out_OBUF[6]),
        .O(sat_out[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[6]_inst_i_1 
       (.I0(sat_in_IBUF[6]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[6]));
  OBUF \sat_out_OBUF[7]_inst 
       (.I(sat_out_OBUF[7]),
        .O(sat_out[7]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[7]_inst_i_1 
       (.I0(sat_in_IBUF[7]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[7]));
  OBUF \sat_out_OBUF[8]_inst 
       (.I(sat_out_OBUF[8]),
        .O(sat_out[8]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[8]_inst_i_1 
       (.I0(sat_in_IBUF[8]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[8]));
  OBUF \sat_out_OBUF[9]_inst 
       (.I(sat_out_OBUF[9]),
        .O(sat_out[9]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \sat_out_OBUF[9]_inst_i_1 
       (.I0(sat_in_IBUF[9]),
        .I1(sat_in_IBUF[19]),
        .I2(sat_in_IBUF[20]),
        .O(sat_out_OBUF[9]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
