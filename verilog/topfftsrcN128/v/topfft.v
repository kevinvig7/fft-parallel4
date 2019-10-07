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
       parameter NBITS_out=19,
       parameter N = 32) // Cantidad de coeficientes en los multiplicadores
     (
      output [NBITS_out*2-1:0] fftOut0_up,
      output [NBITS_out*2-1:0] fftOut0_down,
      output [NBITS_out*2-1:0] fftOut1_up,
      output [NBITS_out*2-1:0] fftOut1_down,
      
      input  [NBITS*2-1:0] fftIn0_up,
      input  [NBITS*2-1:0] fftIn0_down,
      input  [NBITS*2-1:0] fftIn1_up,
      input  [NBITS*2-1:0] fftIn1_down,
      input clk,
      input rst);
      
      
     wire [NBITS*2-1:0] in_a_sat0_0_up;
     wire [NBITS*2-1:0] in_a_sat0_0_down;
     wire [NBITS*2-1:0] in_a_sat0_1_up;
     wire [NBITS*2-1:0] in_a_sat0_1_down;
                 
      
     wire [15*2-1:0] sat0_a_blqIII_0_up;
     wire [15*2-1:0] sat0_a_blqIII_0_down;
     wire [15*2-1:0] sat0_a_blqIII_1_up;
     wire [15*2-1:0] sat0_a_blqIII_1_down;

                       
                        
   wire [19*2-1:0] sat1out_0_up;
   wire [19*2-1:0] sat1out_0_down;
   wire [19*2-1:0] sat1out_1_up;
   wire [19*2-1:0] sat1out_1_down;
            
      assign in_a_sat0_0_up   = fftIn0_up;
      assign in_a_sat0_0_down = fftIn0_down;
      assign in_a_sat0_1_up   = fftIn1_up;
      assign in_a_sat0_1_down = fftIn1_down;
      
      
      
                
////Desde la entrada al primer cuantizador sat0      
topfft_in_a_sat0
   #(.NBITS(NBITS),
     .NBITScoeff(NBITScoeff),
     .N(32)) 
    u_topfft_in_a_sat0
    
     (.fftOut0_up(sat0_a_blqIII_0_up),
      .fftOut0_down(sat0_a_blqIII_0_down),
      .fftOut1_up(sat0_a_blqIII_1_up),
      .fftOut1_down(sat0_a_blqIII_1_down),
      
      .fftIn0_up(in_a_sat0_0_up),
      .fftIn0_down(in_a_sat0_0_down),
      .fftIn1_up(in_a_sat0_1_up),
      .fftIn1_down(in_a_sat0_1_down),
      .clk(clk),
      .rst(rst));
 /////////////////////
 
//    assign fftOut0_up = sat0_a_blqIII_0_up;
//    assign fftOut0_down = sat0_a_blqIII_0_down;
//    assign fftOut1_up = sat0_a_blqIII_1_up;
//    assign fftOut1_down = sat0_a_blqIII_1_down;
    

                  
       topfft_sat0_a_sat1
   #(.NBITS(15),
     .NBITScoeff(NBITScoeff),
     .N(32)) 
    u_topfft_sat0_a_sat1
         (.fftOut0_up(sat1out_0_up),
      .fftOut0_down(sat1out_0_down),
      .fftOut1_up(sat1out_1_up),
      .fftOut1_down(sat1out_1_down),
      
      .fftIn0_up(sat0_a_blqIII_0_up),
      .fftIn0_down(sat0_a_blqIII_0_down),
      .fftIn1_up(sat0_a_blqIII_1_up),
      .fftIn1_down(sat0_a_blqIII_1_down),
      .clk(clk),
      .rst(rst));           
                  
                                   
                  
                  
   
//   assign fftOut0_up   = sat1out_0_up;
//   assign fftOut0_down = sat1out_0_down;
//   assign fftOut1_up   = sat1out_1_up;
//   assign fftOut1_down = sat1out_1_down;




    topfft_sat1_a_sat2
   #(.NBITS(19),
     .NBITScoeff(NBITScoeff),
     .N(32)) 
    u_topfft_sat1_a_sat2
     (.fftOut0_up  (sat2out_0_up),
      .fftOut0_down(sat2out_0_down),
      .fftOut1_up  (sat2out_1_up),
      .fftOut1_down(sat2out_1_down),
      
      .fftIn0_up  (sat1_a_blqV_0_up),
      .fftIn0_down(sat1_a_blqV_0_down),
      .fftIn1_up  (sat1_a_blqV_1_up),
      .fftIn1_down(sat1_a_blqV_1_down),
      .clk(clk),
      .rst(rst));           



   assign fftOut0_up   = sat2out_0_up;
   assign fftOut0_down = sat2out_0_down;
   assign fftOut1_up   = sat2out_1_up;
   assign fftOut1_down = sat2out_1_down;




///////////////////////////////      
    
endmodule