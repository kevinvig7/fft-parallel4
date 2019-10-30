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
 #(parameter NBITS_IN  =15,
   parameter NBI_IN    =3,
   parameter NBF_IN    =12,
   parameter NBITS_OUT =15,
   parameter NBI_OUT   =3,
   parameter NBF_OUT   =12)
 
 (output [NBITS_OUT*2-1:0] sat_out,
  input  [NBITS_IN*2-1:0] sat_in);
  
  

    wire [NBITS_IN-1:0] m_real;
    wire [NBITS_IN-1:0] m_imag;
    
    wire [NBITS_OUT-1:0] s_real;
    wire [NBITS_OUT-1:0] s_imag;
    
    
assign m_real = sat_in[NBITS_IN*2-1:NBITS_IN]; //Real
assign m_imag = sat_in[NBITS_IN-1:0];        //Img
    
     
        sat_fxnum
        #(.NBITS_IN(NBITS_IN),
          .NBI_IN(NBI_IN),
          .NBF_IN(NBF_IN),
          .NBITS_OUT(NBITS_OUT),
          .NBI_OUT(NBI_OUT),
          .NBF_OUT(NBF_OUT))
        sat_real
          (.sat_in(m_real),
           .sat_out(s_real));
           
         
       
         sat_fxnum
       #(.NBITS_IN(NBITS_IN),
          .NBI_IN(NBI_IN),
          .NBF_IN(NBF_IN),
          .NBITS_OUT(NBITS_OUT),
          .NBI_OUT(NBI_OUT),
          .NBF_OUT(NBF_OUT))
        sat_img
          (.sat_in(m_imag),
           .sat_out(s_imag));
             

assign sat_out = {s_real,s_imag};

          

    
    
endmodule
