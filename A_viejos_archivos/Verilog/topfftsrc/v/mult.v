`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2019 12:01:07
// Design Name: 
// Module Name: mult
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


module mult
#(parameter NBITS=8,
  parameter NBITSI=6,
  parameter NBITSF=2)
 (output [(NBITS*2)-1:0] mult_out,
  input signed [NBITS-1:0] mult_inA,
  input signed [NBITS-1:0] mult_inB);
    
   assign mult_out = mult_inA*mult_inB;
  
    
    
endmodule
