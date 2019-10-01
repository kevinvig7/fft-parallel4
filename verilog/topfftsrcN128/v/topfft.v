`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2019 15:27:47
// Design Name: 
// Module Name: topfft
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: a 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module topfft 
     #(parameter NBITS = 10,
     parameter NBITScoeff=NBITS+1,
       parameter N = 32) // Cantidad de coeficientes en los multiplicadores
     (output [15*2-1:0] fftOut0_up,
      output [15*2-1:0] fftOut0_down,
      output [15*2-1:0] fftOut1_up,
      output [15*2-1:0] fftOut1_down,
      input  [NBITS*2-1:0] fftIn0_up,
      input  [NBITS*2-1:0] fftIn0_down,
      input  [NBITS*2-1:0] fftIn1_up,
      input  [NBITS*2-1:0] fftIn1_down,
      input clk,
      input rst);
      
      
      
topfft_in_a_sat0
   #(.NBITS(NBITS),
     .NBITScoeff(NBITScoeff),
     .N(32)) 
    u_topfft_in_a_sat0
    
     (.fftOut0_up(fftOut0_up),
      .fftOut0_down(fftOut0_down),
      .fftOut1_up(fftOut1_up),
      .fftOut1_down(fftOut1_down),
      
      .fftIn0_up(fftIn0_up),
      .fftIn0_down(fftIn0_down),
      .fftIn1_up(fftIn1_up),
      .fftIn1_down(fftIn1_down),
      .clk(clk),
      .rst(rst));
      
      
      
 

///////////////////////////////      
    
endmodule