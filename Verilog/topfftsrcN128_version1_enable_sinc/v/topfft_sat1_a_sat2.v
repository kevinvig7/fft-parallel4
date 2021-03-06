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
     #(parameter NBITS = 19,
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
      input in_enable,
      output o_enable,
      input clk,
      input rst);
      
      
wire coeffCMStage5_en,coeffCMStage6_en;

assign o_enable = coeffCMStage6_en ;

wire coeffw4_0en,coeffw4_1en,coeffw4_2en,coeffw4_3en;
wire coeffw5_0en,coeffw5_1en,coeffw5_2en,coeffw5_3en;

wire ctrl_Blq_BFV,ctrl_Blq_BFVI;
      
  wire [20*2-1:0] blqV_0_a_m_up;
  wire [20*2-1:0] blqV_0_a_m_down;
  wire [20*2-1:0] blqV_1_a_m_up;
  wire [20*2-1:0] blqV_1_a_m_down;
  
  wire [19*2-1:0] sat1_a_blqV_0_up;
  wire [19*2-1:0] sat1_a_blqV_0_down;
  wire [19*2-1:0] sat1_a_blqV_1_up;
  wire [19*2-1:0] sat1_a_blqV_1_down;
  
  
   wire [NBITScoeff*2-1:0] coefficientes4_0;
   wire [NBITScoeff*2-1:0] coefficientes4_1;               
   wire [NBITScoeff*2-1:0] coefficientes4_2;
   wire [NBITScoeff*2-1:0] coefficientes4_3;
   
   wire [NBITScoeff*2-1:0] coefficientes5_0;
   wire [NBITScoeff*2-1:0] coefficientes5_1;               
   wire [NBITScoeff*2-1:0] coefficientes5_2;
   wire [NBITScoeff*2-1:0] coefficientes5_3;
   
     
   wire [32*2-1:0] m_a_blqVI_0_up;
   wire [32*2-1:0] m_a_blqVI_0_down;
   wire [32*2-1:0] m_a_blqVI_1_up;
   wire [32*2-1:0] m_a_blqVI_1_down;  
     
     
     
  wire [33*2-1:0] blqVI_0_a_m_up;
  wire [33*2-1:0] blqVI_0_a_m_down;
  wire [33*2-1:0] blqVI_1_a_m_up;
  wire [33*2-1:0] blqVI_1_a_m_down;
     
     
     wire [45*2-1:0] m_a_sat2_0_up;
     wire [45*2-1:0] m_a_sat2_0_down;
     wire [45*2-1:0] m_a_sat2_1_up;
     wire [45*2-1:0] m_a_sat2_1_down;
     
    wire [NBITS_out*2-1:0] sat2out_0_up;
    wire [NBITS_out*2-1:0] sat2out_0_down;
    wire [NBITS_out*2-1:0] sat2out_1_up;
    wire [NBITS_out*2-1:0] sat2out_1_down;
     
     
      //////////////////////////////////Sat1 a Sat 2///////////////////////////////////    
     
     
      assign sat1_a_blqV_0_up   = fftIn0_up;
      assign sat1_a_blqV_0_down = fftIn0_down;
      assign sat1_a_blqV_1_up   = fftIn1_up;
      assign sat1_a_blqV_1_down = fftIn1_down;
     
     
   //////////////Blq V     
     
 ///Enable de etapa
 topD_1
 #(2)
    EnableCM_stage5
    (.Q(coeffCMStage5_en),
    .clk(clk),
    .rst(!in_enable));
   
///Control sw
contador
 #(2) 
   control_Blq_BFV_0
        (.clk_out(ctrl_Blq_BFV),
         .clk(clk),
         .rst(!coeffCMStage5_en));  
   
//Blq V 0    
   Blq
#(2,2,19)
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
#(2,2,19)
     Blq_BFV_1
      (.BlqOut_up       (blqV_1_a_m_up),
       .BlqOut_down   (blqV_1_a_m_down),
       .BlqIn_up       (sat1_a_blqV_1_up),
       .BlqIn_down   (sat1_a_blqV_1_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFV)); 

    
assign coeffw4_0en=coeffCMStage5_en;
assign coeffw4_1en=coeffCMStage5_en;
assign coeffw4_2en=coeffCMStage5_en;
assign coeffw4_3en=coeffCMStage5_en;
      
      
          
  coeff4_0
 #(NBITScoeff,N)
      Mcoeff4_0
     (.coeff_out(coefficientes4_0),
      .clk(clk),
      .rst(!coeffw4_0en));     
   
    coeff4_1
 #(NBITScoeff,N)
      Mcoeff4_1
     (.coeff_out(coefficientes4_1),
      .clk(clk),
      .rst(!coeffw4_1en));
   
   coeff4_2
 #(NBITScoeff,N)
      Mcoeff4_2
     (.coeff_out(coefficientes4_2),
      .clk(clk),
      .rst(!coeffw4_2en));  
      
      coeff4_3
 #(NBITScoeff,N)
      Mcoeff4_3
     (.coeff_out(coefficientes4_3),
      .clk(clk),
      .rst(!coeffw4_3en));     
   
   
/////////////////Productos full   
   
  //producto 4_0
 multip
 #(20,NBITScoeff)
       M4_0
       (.result(m_a_blqVI_0_up),
        .muestra(blqV_0_a_m_up),
        .coeff(coefficientes4_0));      
 
   
     //producto 4_1
 multip
 #(20,NBITScoeff)
       M4_1
       (.result(m_a_blqVI_0_down),
        .muestra(blqV_0_a_m_down),
        .coeff(coefficientes4_1));      

   
     //producto 4_2
 multip
 #(20,NBITScoeff)
       M4_2
       (.result(m_a_blqVI_1_up),
        .muestra(blqV_1_a_m_up),
        .coeff(coefficientes4_2));      

             

     //producto 4_3
 multip
 #(20,NBITScoeff)
       M4_3
       (.result(m_a_blqVI_1_down),
        .muestra(blqV_1_a_m_down),
        .coeff(coefficientes4_3));         
      
      
      
   ///////////////////Blq VI
   
        
 topD_1
 #(1)
    EnableCM_stage6
    (.Q(coeffCMStage6_en),
    .clk(clk),
    .rst(!coeffCMStage5_en));
      
      
      
   ///Control sw
contador
 #(1) 
   control_Blq_BFVI_0
        (.clk_out(ctrl_Blq_BFVI),
         .clk(clk),
         .rst(!coeffCMStage6_en));    
      
      
      
      //Blq VI 0    
   Blq
#(1,1,32)
     Blq_BFVI_0
      (.BlqOut_up      (blqVI_0_a_m_up),
       .BlqOut_down  (blqVI_0_a_m_down),
       .BlqIn_up       (m_a_blqVI_0_up),
       .BlqIn_down   (m_a_blqVI_0_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFVI)); 

//Blq V 1         
Blq
#(1,1,32)
     Blq_BFVI_1
      (.BlqOut_up       (blqVI_1_a_m_up),
       .BlqOut_down   (blqVI_1_a_m_down),
       .BlqIn_up       (m_a_blqVI_1_up),
       .BlqIn_down   (m_a_blqVI_1_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFVI)); 

    
assign coeffw5_0en=coeffCMStage6_en;
assign coeffw5_1en=coeffCMStage6_en;
assign coeffw5_2en=coeffCMStage6_en;
assign coeffw5_3en=coeffCMStage6_en;
           
      
      
      
 coeff5_0
 #(NBITScoeff,N)
      Mcoeff5_0
     (.coeff_out(coefficientes5_0),
      .clk(clk),
      .rst(!coeffw5_0en));     
   
    coeff5_1
 #(NBITScoeff,N)
      Mcoeff5_1
     (.coeff_out(coefficientes5_1),
      .clk(clk),
      .rst(!coeffw5_1en));
   
   coeff5_2
 #(NBITScoeff,N)
      Mcoeff5_2
     (.coeff_out(coefficientes5_2),
      .clk(clk),
      .rst(!coeffw5_2en));  
      
      coeff5_3
 #(NBITScoeff,N)
      Mcoeff5_3
     (.coeff_out(coefficientes5_3),
      .clk(clk),
      .rst(!coeffw5_3en));     
   
   
/////////////////Productos full   
   
  //producto 5_0
 multip
 #(33,NBITScoeff)
       M5_0
       (.result(m_a_sat2_0_up),
        .muestra(blqVI_0_a_m_up),
        .coeff(coefficientes5_0));      
 
   
     //producto 5_1
 multip
 #(33,NBITScoeff)
       M5_1
       (.result(m_a_sat2_0_down),
        .muestra(blqVI_0_a_m_down),
        .coeff(coefficientes5_1));      

   
     //producto 5_2
 multip
 #(33,NBITScoeff)
       M5_2
       (.result(m_a_sat2_1_up),
        .muestra(blqVI_1_a_m_up),
        .coeff(coefficientes5_2));      

             

     //producto 5_3
 multip
 #(33,NBITScoeff)
       M5_3
       (.result(m_a_sat2_1_down),
        .muestra(blqVI_1_a_m_down),
        .coeff(coefficientes5_3));         
      
      
      
     
///////////Saturador Sat1
       
    fixtop_sat
        #(.NBITS_IN(45),
          .NBI_IN(13),
          .NBF_IN(32),
          .NBITS_OUT(21),
          .NBI_OUT(6),
          .NBF_OUT(15))
        sat2_out0_up
         (.sat_out(sat2out_0_up),
          .sat_in(m_a_sat2_0_up)); 
       
       
       
    fixtop_sat
        #(.NBITS_IN(45),
          .NBI_IN(13),
          .NBF_IN(32),
          .NBITS_OUT(21),
          .NBI_OUT(6),
          .NBF_OUT(15))
        sat2_out0_down
         (.sat_out(sat2out_0_down),
          .sat_in(m_a_sat2_0_down)); 
   
    fixtop_sat
        #(.NBITS_IN(45),
          .NBI_IN(13),
          .NBF_IN(32),
          .NBITS_OUT(21),
          .NBI_OUT(6),
          .NBF_OUT(15))
        sat2_out1_up
         (.sat_out(sat2out_1_up),
          .sat_in(m_a_sat2_1_up)); 
          
    fixtop_sat
        #(.NBITS_IN(45),
          .NBI_IN(13),
          .NBF_IN(32),
          .NBITS_OUT(21),
          .NBI_OUT(6),
          .NBF_OUT(15))
        sat2_out1_down
         (.sat_out(sat2out_1_down),
          .sat_in(m_a_sat2_1_down)); 
   
    
    
    
    
             
   
   assign fftOut0_up   = sat2out_0_up;
   assign fftOut0_down = sat2out_0_down;
   assign fftOut1_up   = sat2out_1_up;
   assign fftOut1_down = sat2out_1_down;
      
      
      
      
      
      
      
      
endmodule
