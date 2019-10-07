`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2019 16:31:07
// Design Name: 
// Module Name: topfft_sat1_a_sat2
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


module topfft_sat1_a_sat2
     #(parameter NBITS = 10,
       parameter NBITScoeff=NBITS+1,
       parameter NBITS_out=21,
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
      
      

      
     
 ///Enable de etapa
 topD_1
 #(8+16+2)
    EnableCM_stage5
    (.Q(coeffCMStage5_en),
    .clk(clk),
    .rst(rst));
   
///Control sw
contador
 #(2) 
   control_Blq_BFV_0
        (.clk_out(ctrl_Blq_BFV),
         .clk(clk),
         .rst(!coeffCMStage5_en));  
   
//Blq V 0    
   Blq
#(2,2,15)
     Blq_BFV_0
      (.BlqOut_up      (blqV_0_a_m_up),
       .BlqOut_down  (blqV_0_a_m_down),
       .BlqIn_up       (sat1_a_blqV_0_up),
       .BlqIn_down   (sat1_a_blqV_0_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFV)); 

//Blq V 1         
Blq
#(2,2,15)
     Blq_BFV_1
      (.BlqOut_up       (blqV_1_a_m_up),
       .BlqOut_down   (blqV_1_a_m_down),
       .BlqIn_up       (sat1_a_blqV_1_up),
       .BlqIn_down   (sat1_a_blqV_1_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFV)); 

    
      
      
      
      
      
      
      
      
      
      
      
endmodule
