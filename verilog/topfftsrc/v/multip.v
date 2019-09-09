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
#(parameter NBITS=2,
parameter NBITScoeff=3)
 (output[NBITS*2*2-1:0] result,
  input [NBITS*2-1:0] muestra,
  input [NBITScoeff*2-1:0] coeff);



    wire signed [NBITS-1:0] m_r;
    wire signed [NBITS-1:0] m_i;
    
    wire signed [NBITS-1:0] c_r;
    wire signed [NBITS-1:0] c_i;
    
    
assign m_r = muestra[NBITS*2-1:NBITS]; //Real
assign m_i = muestra[NBITS-1:0];        //Img
    
assign c_r = $signed(coeff[NBITScoeff*2-1:NBITScoeff]); //Real
assign c_i = $signed(coeff[NBITScoeff-1:0]);        //Img
        
    
    
  assign result[NBITS*2*2-1:NBITS*2] = m_r*c_r-m_i*c_i;   //Real
  assign result[NBITS*2-1:0] = m_r*c_i+m_i*c_r;         //Img
 
    
    
    
endmodule
