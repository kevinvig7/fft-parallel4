`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.08.2019 15:42:22
// Design Name: 
// Module Name: multip
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


module multip
#(parameter Nbits=2)
 (output[(Nbits+1)*2-1:0] result,
  input [Nbits*2-1+1:0] muestra,
  input [(Nbits+1)*2-1:0] coeff);


    wire signed [Nbits-1:0] m_r;
    wire signed [Nbits-1:0] m_i;
    
    wire signed [Nbits+1-1:0] c_r;
    wire signed [Nbits+1-1:0] c_i;
    
    
assign m_r = muestra[Nbits*2-1:Nbits]; //Real
assign m_i = muestra[Nbits-1:0];        //Img
    
assign c_r = coeff[(Nbits+1)*2-1:Nbits]; //Real
assign c_i = coeff[(Nbits+1)-1:0];        //Img
        
    
    
  assign result[(Nbits+1)*2-1:Nbits+1] = m_r*c_r-m_i*c_i;   //Real
  assign result[(Nbits+1)-1:0] = m_r*c_i+m_i*c_r;         //Img
 
    
    
    
endmodule
