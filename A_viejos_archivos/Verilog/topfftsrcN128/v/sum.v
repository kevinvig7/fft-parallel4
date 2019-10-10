`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2019 18:00:34
// Design Name: 
// Module Name: sum
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


module sum
#(parameter NBITS=8,
  parameter NBITSI=6,
  parameter NBITSF=2)
 (output [(NBITS+1)-1:0] sum_out,
  input signed [NBITS-1:0] sum_inA,
  input signed [NBITS-1:0] sum_inB);
  

  assign sum_out=sum_inA+sum_inB;
    
    
  
endmodule
