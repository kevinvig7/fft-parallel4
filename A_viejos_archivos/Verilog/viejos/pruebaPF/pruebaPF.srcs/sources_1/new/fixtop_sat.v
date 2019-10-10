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
#(parameter NBITS=12,
parameter NBITScoeff=11,
parameter NBITS_out=NBITS+NBITScoeff+1)
 (output signed [NBITS_out*2-1:0] result,
  input signed [NBITS*2-1:0] muestra,
  input signed [NBITScoeff*2-1:0] coeff);



  wire [NBITS-1:0] m_r;
  wire [NBITS-1:0] m_i;
    
  wire [NBITScoeff-1:0] c_r;
  wire [NBITScoeff-1:0] c_i;
    
    
assign m_r = muestra[NBITS*2-1:NBITS]; //Real
assign m_i = muestra[NBITS-1:0];        //Img
    
assign c_r = coeff[NBITScoeff*2-1:NBITScoeff]; //Real
assign c_i = coeff[NBITScoeff-1:0];        //Img
        
    
    
  assign result[NBITS_out*2-1:NBITS_out] = m_r*c_r-m_i*c_i;   //Real
  assign result[NBITS_out-1:0] = m_r*c_i+m_i*c_r;         //Img


   
    
endmodule

