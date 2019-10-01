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
      
      
     wire [NBITS*2-1:0] in_a_sat0_0_up;
     wire [NBITS*2-1:0] in_a_sat0_0_down;
     wire [NBITS*2-1:0] in_a_sat0_1_up;
     wire [NBITS*2-1:0] in_a_sat0_1_down;
      
     wire [15*2-1:0] sat0_a_blqIII_0_up;
     wire [15*2-1:0] sat0_a_blqIII_0_down;
     wire [15*2-1:0] sat0_a_blqIII_1_up;
     wire [15*2-1:0] sat0_a_blqIII_1_down;


     wire [16*2-1:0] blqIII_0_a_m_up;
     wire [16*2-1:0] blqIII_0_a_m_down;
     wire [16*2-1:0] blqIII_1_a_m_up;
     wire [16*2-1:0] blqIII_1_a_m_down;
       
     wire ctrl_Blq_BFIII;  
     wire coeffCMStage3_en;
                        
     wire [28*2-1:0] m_a_blqIV_0_up;
     wire [28*2-1:0] m_a_blqIV_0_down;
     wire [28*2-1:0] m_a_blqIV_1_up;
     wire [28*2-1:0] m_a_blqIV_1_down;                   
                 
                        
     wire coefficientes2_0;
     wire coefficientes2_1;               
     wire coefficientes2_2;
     wire coefficientes2_3;
     
     wire coeffw2_0en;
     wire coeffw2_1en;
     wire coeffw2_2en;
     wire coeffw2_3en;
                    
                        
            
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
 
      

    assign fftOut0_up = sat0_a_blqIII_0_up;
    assign fftOut0_down = sat0_a_blqIII_0_down;
    assign fftOut1_up = sat0_a_blqIII_1_up;
    assign fftOut1_down = sat0_a_blqIII_1_down;
      
   
   
   //////////Sat 0 a Sat 1
   
   
   
   Blq
#(8+16,8+16,15)
     Blq_BFIII_0
      (.BlqOut_up      (blqIII_0_a_m_up),
       .BlqOut_down  (blqIII_0_a_m_down),
       .BlqIn_up       (sat0_a_blqIII_0_up),
       .BlqIn_down   (sat0_a_blqIII_0_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFIII)); 
    

    
Blq
#(8+16,8+16,15)
     Blq_BFIII_1
      (.BlqOut_up       (blqIII_1_a_m_up),
       .BlqOut_down   (blqIII_1_a_m_down),
       .BlqIn_up       (sat0_a_blqIII_1_up),
       .BlqIn_down   (sat0_a_blqIII_1_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFIII)); 
   
      
   
////////////////Control sw

contador
 #(8+16) 
   control_Blq_BFII_0
        (.clk_out(ctrl_Blq_BFIII),
         .clk(clk),
         .rst(!coeffCMStage3_en));  

/////////////////Productos full

assign coeffw2_0en=coeffCMStage3_en;
assign coeffw2_1en=coeffCMStage3_en;
assign coeffw2_2en=coeffCMStage3_en;
assign coeffw2_3en=coeffCMStage3_en;
   
  //producto 2_0
 multip
 #(16,NBITScoeff)
       M2_0
       (.result(m_a_blqIV_0_up),
        .muestra(blqIII_0_a_m_up),
        .coeff(coefficientes2_0));      
        
  coeff2_0
 #(NBITScoeff,N)
      Mcoeff2_0
     (.coeff_out(coefficientes2_0),
      .clk(clk),
      .rst(!coeffw2_0en));      
        
        

   
   
     //producto 2_1
 multip
 #(16,NBITScoeff)
       M2_1
       (.result(m_a_blqIV_0_down),
        .muestra(blqIII_0_a_m_down),
        .coeff(coefficientes2_1));      
 coeff2_1
 #(NBITScoeff,N)
      Mcoeff2_1
     (.coeff_out(coefficientes2_1),
      .clk(clk),
      .rst(!coeffw2_1en));
   
   
   
   
   
     //producto 2_2
 multip
 #(16,NBITScoeff)
       M2_2
       (.result(m_a_blqIV_1_up),
        .muestra(blqIII_1_a_m_up),
        .coeff(coefficientes2_2));      
coeff2_2
 #(NBITScoeff,N)
      Mcoeff2_2
     (.coeff_out(coefficientes2_2),
      .clk(clk),
      .rst(!coeffw2_2en));  
             
        
   
   
     //producto 2_3
 multip
 #(16,NBITScoeff)
       M2_3
       (.result(m_a_blqIV_1_down),
        .muestra(blqIII_1_a_m_down),
        .coeff(coefficientes2_3));      
   
coeff2_3
 #(NBITScoeff,N)
      Mcoeff2_3
     (.coeff_out(coefficientes2_3),
      .clk(clk),
      .rst(!coeffw2_3en));     
   
    




   
      
      
 

///////////////////////////////      
    
endmodule