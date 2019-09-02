`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2019 10:39:47
// Design Name: 
// Module Name: fixtop
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


module fixtop
#(parameter NBITS=8,
  parameter NBITSI=6,
  parameter NBITSF=2)
 (output [(NBITS+1)-1:0] sat_out,
  input signed [NBITS-1:0] inA,
  input signed [NBITS-1:0] inB);
  
  
  wire signed [(NBITS*2)-1:0] mult_out;
  
 mult
 #(.NBITS(NBITS),
  .NBITSI(NBITSI),
  .NBITSF(NBITSF))
   Multiplicador
      (.mult_out(mult_out),
       .mult_inA(inA),
       .mult_inB(inB)); 
       
       
       

       








            

    
    
endmodule
