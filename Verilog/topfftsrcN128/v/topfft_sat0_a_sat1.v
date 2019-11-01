`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2019 16:03:28
// Design Name: 
// Module Name: top_fft_sat0_a_sat1
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


module topfft_sat0_a_sat1
     #(parameter NBITS = 10,
       parameter NBITScoeff=NBITS+1,
       parameter NBITS_out=19,
       parameter N = 32) // Cantidad de coeficientes en los multiplicadores
     (
      output reg [NBITS_out*2-1:0] fftOut0_up,
      output reg [NBITS_out*2-1:0] fftOut0_down,
      output reg [NBITS_out*2-1:0] fftOut1_up,
      output reg [NBITS_out*2-1:0] fftOut1_down,
      
      input  [NBITS*2-1:0] fftIn0_up,
      input  [NBITS*2-1:0] fftIn0_down,
      input  [NBITS*2-1:0] fftIn1_up,
      input  [NBITS*2-1:0] fftIn1_down,
      input in_enable,
      output o_enable,
      input clk,
      input rst);




   wire [NBITS_out*2-1:0] sat1out_0_up;
   wire [NBITS_out*2-1:0] sat1out_0_down;
   wire [NBITS_out*2-1:0] sat1out_1_up;
   wire [NBITS_out*2-1:0] sat1out_1_down;

     wire [16*2-1:0] blqIII_0_a_m_up;
     wire [16*2-1:0] blqIII_0_a_m_down;
     wire [16*2-1:0] blqIII_1_a_m_up;
     wire [16*2-1:0] blqIII_1_a_m_down;
       
     wire ctrl_Blq_BFIII,ctrl_Blq_BFIV;  
     wire coeffCMStage3_en,coeffCMStage4_en;
     
     
     assign o_enable = coeffCMStage4_en;
                        
     wire [28*2-1:0] m_a_blqIV_0_up;
     wire [28*2-1:0] m_a_blqIV_0_down;
     wire [28*2-1:0] m_a_blqIV_1_up;
     wire [28*2-1:0] m_a_blqIV_1_down;                   
                 
                        
     wire [NBITScoeff*2-1:0] coefficientes2_0;
     wire [NBITScoeff*2-1:0] coefficientes2_1;               
     wire [NBITScoeff*2-1:0] coefficientes2_2;
     wire [NBITScoeff*2-1:0] coefficientes2_3;
     
     wire coeffw2_0en;
     wire coeffw2_1en;
     wire coeffw2_2en;
     wire coeffw2_3en;
                    
      wire     coeffw3_0en;
      wire     coeffw3_1en;

     
     wire [NBITScoeff*2-1:0] coefficientes3_0;
     wire [NBITScoeff*2-1:0] coefficientes3_1;
     
     
     
     
     wire [29*2-1:0] blqIV_a_m_0_up;
     wire [29*2-1:0] blqIV_a_m_0_down;
     wire [29*2-1:0] blqIV_a_m_1_up;
     wire [29*2-1:0] blqIV_a_m_1_down;





     wire [15*2-1:0] sat0_a_blqIII_0_up;
     wire [15*2-1:0] sat0_a_blqIII_0_down;
     wire [15*2-1:0] sat0_a_blqIII_1_up;
     wire [15*2-1:0] sat0_a_blqIII_1_down;



     wire [29*2-1:0] m_to_sat1_0_up;
     wire [40*2-1:0] m_to_sat1_0_down;
     wire [29*2-1:0] m_to_sat1_1_up;
     wire [40*2-1:0]  m_to_sat1_1_down;


    
    
     //////////////////////////////////Sat 0 a Sat 1///////////////////////////////////
     
     
      assign sat0_a_blqIII_0_up   = fftIn0_up;
      assign sat0_a_blqIII_0_down = fftIn0_down;
      assign sat0_a_blqIII_1_up   = fftIn1_up;
      assign sat0_a_blqIII_1_down = fftIn1_down;
     
//     wire coeffCMStage31_en;
     
     
 ///Enable de etapa
 topD_1
 #(8)
    EnableCM_stage3
    (.Q(coeffCMStage3_en),
    .clk(clk),
    .rst(!in_enable));
   
   
   
///Control sw
contador
 #(8) 
   control_Blq_BFIII_0
        (.clk_out(ctrl_Blq_BFIII),
         .clk(clk),
         .rst(!coeffCMStage3_en));  
   
//Blq III 0    
   Blq
#(8,8,15)
     Blq_BFIII_0
      (.BlqOut_up      (blqIII_0_a_m_up),
       .BlqOut_down  (blqIII_0_a_m_down),
       .BlqIn_up       (sat0_a_blqIII_0_up),
       .BlqIn_down   (sat0_a_blqIII_0_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFIII)); 

//Blq III 1         
Blq
#(8,8,15)
     Blq_BFIII_1
      (.BlqOut_up       (blqIII_1_a_m_up),
       .BlqOut_down   (blqIII_1_a_m_down),
       .BlqIn_up       (sat0_a_blqIII_1_up),
       .BlqIn_down   (sat0_a_blqIII_1_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFIII)); 


/////////////////Coeficientes


assign coeffw2_0en=coeffCMStage3_en;
assign coeffw2_1en=coeffCMStage3_en;
assign coeffw2_2en=coeffCMStage3_en;
assign coeffw2_3en=coeffCMStage3_en;
   
          
   
 coeff_mem_2_0
      Mcoeff_2_0
     (.coeff_out(coefficientes2_0),
      .clk(clk),
      .rst(!coeffw2_0en));     
   
 coeff_mem_2_1
      Mcoeff_2_1
     (.coeff_out(coefficientes2_1),
      .clk(clk),
      .rst(!coeffw2_0en));     
   
   
   coeff_mem_2_2
      Mcoeff_2_2
     (.coeff_out(coefficientes2_2),
      .clk(clk),
      .rst(!coeffw2_0en));     
   
   coeff_mem_2_3
      Mcoeff_2_3
     (.coeff_out(coefficientes2_3),
      .clk(clk),
      .rst(!coeffw2_0en));
   

  
   
   
   
   
   
   
   
/////////////////Productos full   
   
  //producto 2_0
 multip
 #(16,NBITScoeff)
       M2_0
       (.result(m_a_blqIV_0_up),
        .muestra(blqIII_0_a_m_up),
        .coeff(coefficientes2_0));      
 
   
     //producto 2_1
 multip
 #(16,NBITScoeff)
       M2_1
       (.result(m_a_blqIV_0_down),
        .muestra(blqIII_0_a_m_down),
        .coeff(coefficientes2_1));      

   
     //producto 2_2
 multip
 #(16,NBITScoeff)
       M2_2
       (.result(m_a_blqIV_1_up),
        .muestra(blqIII_1_a_m_up),
        .coeff(coefficientes2_2));      

             

     //producto 2_3
 multip
 #(16,NBITScoeff)
       M2_3
       (.result(m_a_blqIV_1_down),
        .muestra(blqIII_1_a_m_down),
        .coeff(coefficientes2_3));      
   

      
      
/*   assign fftOut0_up   = m_a_blqIV_0_up;
   assign fftOut0_down = m_a_blqIV_0_down;
   assign fftOut1_up   = m_a_blqIV_1_up;
   assign fftOut1_down = m_a_blqIV_1_down;
    */
///////////////////////Stag4 
/////////////////////////////////  
    ///Enable de etapa
 topD_1
 #(4)
    EnableCM_stage4
    (.Q(coeffCMStage4_en),
    .clk(clk),
    .rst(!coeffCMStage3_en));
   
///Control sw
contador
 #(4) 
   control_Blq_BFIV_0
        (.clk_out(ctrl_Blq_BFIV),
         .clk(clk),
         .rst(!coeffCMStage4_en));  

//Blq IV 0    
   Blq
#(4,4,28)
     Blq_BFIV_0
    (.BlqOut_up(blqIV_a_m_0_up),
    .BlqOut_down(blqIV_a_m_0_down),
    .BlqIn_up(m_a_blqIV_0_up),
    .BlqIn_down(m_a_blqIV_0_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFIV)); 

//Blq IV 1         
Blq
#(4,4,28)
     Blq_BFIV_1
    (.BlqOut_up(blqIV_a_m_1_up),
      .BlqOut_down(blqIV_a_m_1_down),
       .BlqIn_up(m_a_blqIV_1_up),
       .BlqIn_down(m_a_blqIV_1_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFIV)); 


    /////////
    
    
assign coeffw3_0en=coeffCMStage4_en;
assign coeffw3_1en=coeffCMStage4_en;

     coeff_mem_3_0
      Mcoeff_3_0
     (.coeff_out(coefficientes3_0),
      .clk(clk),
      .rst(!coeffw3_0en));

 coeff_mem_3_1
      Mcoeff_3_1
     (.coeff_out(coefficientes3_1),
      .clk(clk),
      .rst(!coeffw3_1en));
 ///////////////////////////////// 
   
  //cable 3_0 
assign m_to_sat1_0_up= blqIV_a_m_0_up;  // Cable

//producto 3_1
 multip_tdw
 #(29,NBITScoeff)
       M0_0_tdw
       (.result(m_to_sat1_0_down),
        .muestra(blqIV_a_m_0_down),
        .coeff(coefficientes3_0));
      
    //cable 3_2      
assign m_to_sat1_1_up= blqIV_a_m_1_up; // Cable

        
  //producto 3_3
 multip_tdw
 #(29,NBITScoeff)
       M0_1_tdw
       (.result(m_to_sat1_1_down),
        .muestra(blqIV_a_m_1_down),
        .coeff(coefficientes3_1));       
    


///////////Saturador Sat1
       
    fixtop_sat
        #(.NBITS_IN(29),
          .NBI_IN(8),
          .NBF_IN(21),
          .NBITS_OUT(19),
          .NBI_OUT(5),
          .NBF_OUT(14))
        sat1_out0_up
         (.sat_out(sat1out_0_up),
          .sat_in(m_to_sat1_0_up)); 
       
       
       
       fixtop_sat
        #(.NBITS_IN(40),
          .NBI_IN(10),
          .NBF_IN(30),
          .NBITS_OUT(19),
          .NBI_OUT(5),
          .NBF_OUT(14))
        sat1_out0_down
         (.sat_out(sat1out_0_down),
          .sat_in(m_to_sat1_0_down)); 
   
     fixtop_sat
        #(.NBITS_IN(29),
          .NBI_IN(8),
          .NBF_IN(21),
          .NBITS_OUT(19),
          .NBI_OUT(5),
          .NBF_OUT(14))
        sat1_out1_up
         (.sat_out(sat1out_1_up),
          .sat_in(m_to_sat1_1_up)); 
          
            fixtop_sat
        #(.NBITS_IN(40),
           .NBI_IN(10),
          .NBF_IN(30),
          .NBITS_OUT(19),
          .NBI_OUT(5),
          .NBF_OUT(14))
        sat1_out1_down
         (.sat_out(sat1out_1_down),
          .sat_in(m_to_sat1_1_down)); 
   
    
    
    
always@ (posedge clk) begin             
 if (rst) begin      
 fftOut0_up   = {NBITS_out*2{1'b0}};    
 fftOut0_down = {NBITS_out*2{1'b0}};      
 fftOut1_up   = {NBITS_out*2{1'b0}};       
 fftOut1_down = {NBITS_out*2{1'b0}};       
      end else begin
 fftOut0_up   =  sat1out_0_up;
 fftOut0_down = sat1out_0_down;
 fftOut1_up   =   sat1out_1_up;
 fftOut1_down = sat1out_1_down;
         end
  end  
    
    
    
    
    
    
    
endmodule
