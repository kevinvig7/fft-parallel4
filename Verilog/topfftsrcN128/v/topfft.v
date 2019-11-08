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
       parameter NBITS_out=10,
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
   
  wire [21*2-1:0] sat2out_0_up;
  wire [21*2-1:0] sat2out_0_down;
  wire [21*2-1:0] sat2out_1_up;
  wire [21*2-1:0] sat2out_1_down;

  wire [NBITS_out*2-1:0] sat3out_0_up;
  wire [NBITS_out*2-1:0] sat3out_0_down;
  wire [NBITS_out*2-1:0] sat3out_1_up;
  wire [NBITS_out*2-1:0] sat3out_1_down;

wire enable_sat0_a_sat1,enable_sat1_a_sat2,enable_sat2_a_sat3;
   
///////////////////////////////////////////////////////                  
////Desde entrada "in" hasta primer cuantizador "sat0" 

      assign in_a_sat0_0_up   = fftIn0_up;
      assign in_a_sat0_0_down = fftIn0_down;
      assign in_a_sat0_1_up   = fftIn1_up;
      assign in_a_sat0_1_down = fftIn1_down;
      

topfft_in_a_sat0
   #(.NBITS(NBITS),
     .NBITScoeff(NBITScoeff),
     .N(32)) 
    u_topfft_in_a_sat0
    
     (.fftOut0_up(sat0_a_blqIII_0_up),
      .fftOut0_down(sat0_a_blqIII_0_down),
      .fftOut1_up(sat0_a_blqIII_1_up),
      .fftOut1_down(sat0_a_blqIII_1_down),
      .o_enable(enable_sat0_a_sat1),
      .fftIn0_up(in_a_sat0_0_up),
      .fftIn0_down(in_a_sat0_0_down),
      .fftIn1_up(in_a_sat0_1_up),
      .fftIn1_down(in_a_sat0_1_down),
      .clk(clk),
      .rst(rst));
      
 ////Desde "sat0" hasta el segundo cuantizador "sat1"

                  
       topfft_sat0_a_sat1
   #(.NBITS(15),
     .NBITScoeff(NBITScoeff),
     .N(32)) 
    u_topfft_sat0_a_sat1
         (.fftOut0_up(sat1out_0_up),
      .fftOut0_down(sat1out_0_down),
      .fftOut1_up(sat1out_1_up),
      .fftOut1_down(sat1out_1_down),
      .in_enable(enable_sat0_a_sat1),
      .o_enable(enable_sat1_a_sat2),
      .fftIn0_up(sat0_a_blqIII_0_up),
      .fftIn0_down(sat0_a_blqIII_0_down),
      .fftIn1_up(sat0_a_blqIII_1_up),
      .fftIn1_down(sat0_a_blqIII_1_down),
      .clk(clk),
      .rst(rst));           
                  
  ////Desde "sat1" hasta el tercer cuantizador "sat2"                                 
                  
    topfft_sat1_a_sat2
   #(.NBITS(19),
     .NBITScoeff(NBITScoeff),
     .N(32)) 
    u_topfft_sat1_a_sat2
     (.fftOut0_up  (sat2out_0_up),
      .fftOut0_down(sat2out_0_down),
      .fftOut1_up  (sat2out_1_up),
      .fftOut1_down(sat2out_1_down),
       .in_enable(enable_sat1_a_sat2),
      .o_enable(enable_sat2_a_sat3),
      .fftIn0_up  (sat1out_0_up),
      .fftIn0_down(sat1out_0_down),
      .fftIn1_up  (sat1out_1_up),
      .fftIn1_down(sat1out_1_down),
      .clk(clk),
      .rst(rst));           
      

  ////Desde "sat2" hasta el cuarto cuantizador "sat3"   

    topfft_sat2_a_sat3
   #(.NBITS(21),
     .NBITScoeff(NBITScoeff),
     .N(32)) 
    u_topfft_sat2_a_sat3
     (.fftOut0_up  (sat3out_0_up),
      .fftOut0_down(sat3out_0_down),
      .fftOut1_up  (sat3out_1_up),
      .fftOut1_down(sat3out_1_down),
     .in_enable(enable_sat2_a_sat3),
      .fftIn0_up  (sat2out_0_up),
      .fftIn0_down(sat2out_0_down),
      .fftIn1_up  (sat2out_1_up),
      .fftIn1_down(sat2out_1_down),
      .clk(clk),
      .rst(rst));         


//sat 3 salida final
   assign fftOut0_up   = sat3out_0_up;
   assign fftOut0_down = sat3out_0_down;
   assign fftOut1_up   = sat3out_1_up;
   assign fftOut1_down = sat3out_1_down;


//sat0
//   assign fftOut0_up   = sat0_a_blqIII_0_up;
//   assign fftOut0_down = sat0_a_blqIII_0_down;
//   assign fftOut1_up   = sat0_a_blqIII_1_up;
//   assign fftOut1_down = sat0_a_blqIII_1_down;

//sat1
//   assign fftOut0_up   = sat1out_0_up;
//   assign fftOut0_down = sat1out_0_down;
//   assign fftOut1_up   = sat1out_1_up;
//   assign fftOut1_down = sat1out_1_down;
 
//sat2
//  assign fftOut0_up   = sat2out_0_up;
//   assign fftOut0_down = sat2out_0_down;
//   assign fftOut1_up   = sat2out_1_up;
//   assign fftOut1_down = sat2out_1_down;
 
 

///////////////////////////////      
    
endmodule