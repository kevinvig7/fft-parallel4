`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: as
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


module fixtop_sat
#(parameter NBITS_IN=8,
  parameter NBITS_OUT=6)
 (output [NBITS_OUT*2-1:0] sat_out,
    input [NBITS_IN*2-1:0] sat_in);
  
 
    wire [NBITS_IN-1:0] m_r;
    wire [NBITS_IN-1:0] m_i;
    
    wire [NBITS_OUT-1:0] s_r;
    wire [NBITS_OUT-1:0] s_i;
    
    
assign m_r = sat_in[NBITS_IN*2-1:NBITS_IN]; //Real
assign m_i = sat_in[NBITS_IN-1:0];        //Img
    
     
        sat
          #(.NBITS_IN(NBITS_IN),
           .NBITS_OUT(NBITS_OUT))
        sat_real
          (.sat_in(m_r),
           .sat_out(s_r));
           
         
       
         sat
          #(.NBITS_IN(NBITS_IN),
           .NBITS_OUT(NBITS_OUT))
        sat_img
          (.sat_in(m_i),
           .sat_out(s_i));
             

assign sat_out = {s_r,s_i};

          

    
    
endmodule
