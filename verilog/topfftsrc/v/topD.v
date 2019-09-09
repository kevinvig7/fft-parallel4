`timescale 1ns / 1ps
//`include "def.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2019 14:32:39
// Design Name: 
// Module Name: topD
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


module topD
 #(parameter   ND = 4,
   parameter Nbits = 2)
   (output [Nbits*2-1:0] Q,
    input [Nbits*2-1:0] D,
    input clk,
    input rst);

    
    
    wire [Nbits*2-1:0] connect_wire[0:ND];
    
    assign connect_wire[0] = D;
    assign  Q = connect_wire[ND];
    
   genvar i;
   generate
      for (i=0; i < ND; i=i+1) begin:
      Dgen D_reg#(Nbits) nD(connect_wire[i+1],connect_wire[i],clk,rst);
     end
   endgenerate
    
endmodule


  
			

