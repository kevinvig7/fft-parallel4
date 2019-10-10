`timescale 1ns / 1ps
`include "def.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2019 11:04:29
// Design Name: 
// Module Name: Blq
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Blqj(
    BlqIn_up,
    BlqIn_down,
    BlqOut_up,
    BlqOut_down,
    clk,
    rst,
    ctrl
    );

  parameter ND0 = 128;
  parameter ND1 = 128;
  parameter Nbits = `Nbitsg;


  
    input [Nbits*2-1:0] BlqIn_up;
    input  [Nbits*2-1:0] BlqIn_down;
    output [Nbits*2-1:0] BlqOut_up;
    output [Nbits*2-1:0] BlqOut_down;
    input clk;
    input rst;
    input ctrl;
  
    wire [Nbits*2-1:0] connect_blq_up[0:2];
    wire [Nbits*2-1:0] connect_blq_down[0:2];
    
    assign connect_blq_up[0] = BlqIn_up;
    assign connect_blq_down[0] = BlqIn_down;
      
   
   topD#(ND0,`Nbitsg) DA(connect_blq_down[0],connect_blq_down[1],rst,clk);
  
   switch sw0(connect_blq_up[0],connect_blq_down[1],connect_blq_up[1],connect_blq_down[2],ctrl);

   topD#(ND1,`Nbitsg) DB(connect_blq_up[1],connect_blq_up[2],rst,clk);

   BFj I(connect_blq_up[2],connect_blq_down[2],BlqOut_up,BlqOut_down);


endmodule
