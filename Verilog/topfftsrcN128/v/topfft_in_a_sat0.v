`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2019 11:53:12
// Design Name: 
// Module Name: topfft_in_a_sat0
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


module topfft_in_a_sat0
    #(parameter NBITS = 10,
      parameter NBITScoeff=NBITS+1,
       parameter NBITS_out=15,
      parameter N = 32) // Cantidad de coeficientes en los multiplicadores
     (output reg [NBITS_out*2-1:0] fftOut0_up,
      output reg [NBITS_out*2-1:0] fftOut0_down,
      output reg [NBITS_out*2-1:0] fftOut1_up,
      output reg [NBITS_out*2-1:0] fftOut1_down,
      output reg o_enable,
      input  [NBITS*2-1:0] fftIn0_up,
      input  [NBITS*2-1:0] fftIn0_down,
      input  [NBITS*2-1:0] fftIn1_up,
      input  [NBITS*2-1:0] fftIn1_down,
      input clk,
      input rst);




     
      
  wire [NBITScoeff*2-1:0] coefficientes0_0;
  wire [NBITScoeff*2-1:0] coefficientes0_1;
  wire [NBITScoeff*2-1:0] coefficientes1_0;
  wire [NBITScoeff*2-1:0] coefficientes1_1;
  wire [NBITScoeff*2-1:0] coefficientes1_2;
  
    
   
  wire coeffw0_0en;
  wire coeffw0_1en;
  wire coeffw1_0en;
  wire coeffw1_1en;
  wire coeffw1_2en;
  
  wire ctrl_Blq_BFII,coeffCMStage2_en;
  
  //assign o_enable = coeffCMStage2_en;
 
  ///estos no van negados a la entrada de coeff porque el rst es negado
  
 assign coeffw0_0en=rst;
 assign coeffw0_1en=rst;

 /////////
 
 wire [NBITS*2-1:0]   in0_up;
 wire [NBITS*2-1:0] in0_down;
 wire [NBITS*2-1:0]   in1_up;
 wire [NBITS*2-1:0] in1_down;
 
 //[((NBITS+1)*2+1)*2-1:0]
 

 
 wire [11*2-1:0] blqI0_to_m_up  ;
 wire [11*2-1:0] blqI0_to_m_down;
 wire [11*2-1:0] blqI1_to_m_up  ;
 wire [11*2-1:0] blqI1_to_m_down;
 
 
// wire [11*2-1:0] blqI0_to_m_upj  ;
// wire [11*2-1:0] blqI0_to_m_downj;
// wire [11*2-1:0] blqI1_to_m_upj  ;
// wire [11*2-1:0] blqI1_to_m_downj;
 
 wire  twd1,twd2;

 
 //////////////////////
wire [11*2-1:0] m_to_blqII0_up;
wire [11*2-1:0] m_to_blqII1_up;
wire [11*2-1:0] m_to_blqII0_down;
wire [11*2-1:0] m_to_blqII1_down;

 //wire [22*2-1:0] m_to_blqII1_up;
// wire [22*2-1:0] m_to_blqII1_down;

/////////////////////////////////
 wire [12*2-1:0] blqII0_to_m_up;
 wire [12*2-1:0] blqII0_to_m_down;
 wire [12*2-1:0] blqII1_to_m_up;
 wire [12*2-1:0] blqII1_to_m_down;



 wire [12*2-1:0] m_to_sat0_0_up  ;
 wire [12*2-1:0] m_to_sat0_1_down;
 wire [24*2-1:0] m_to_sat1_0_up  ;
 wire [24*2-1:0] m_to_sat1_1_down;
 

 wire [NBITS_out*2-1:0] satout0_0_up;
 wire [NBITS_out*2-1:0] satout0_1_down;
 wire [NBITS_out*2-1:0] satout1_0_up;
 wire [NBITS_out*2-1:0] satout1_1_down;


  assign in0_up   =   fftIn0_up;
  assign in0_down = fftIn0_down;
  assign in1_up   =   fftIn1_up;
  assign in1_down = fftIn1_down;
  
  
 
    
  
///////////////////////////////////  
// coeff_mem_0_0
//      Mcoeff_0_0
//     (.coeff_out(coefficientes0_0),
//      .clk(clk),
//      .rst(coeffw0_0en));

// coeff_mem_0_1
//      Mcoeff_0_1
//     (.coeff_out(coefficientes0_1),
//      .clk(clk),
//      .rst(coeffw0_1en));
// /////////////////////////////////      
 
       
        

////BFI I
//   BF#(NBITS) 
//        Butterfly0_0
//            (.BFOut_up(blqI0_to_m_up),
//             .BFOut_down(blqI0_to_m_down),
//             .BFIn_up(in0_up),
//             .BFIn_down(in0_down));


//   BF#(NBITS) 
//        Butterfly0_1
//            (.BFOut_up(blqI1_to_m_up),
//             .BFOut_down(blqI1_to_m_down),
//             .BFIn_up(in1_up),
//             .BFIn_down(in1_down));

    //////////prueba 
    
       contador
 #(16) 
   control_twd1
        (.clk_out(twd1),
         .clk(clk),
         .rst(rst));   
    
   BFj#(NBITS) 
        Butterflyj0_0
            (.BFOut_up(blqI0_to_m_up),
             .BFOut_down(blqI0_to_m_down),
             .BFIn_up(in0_up),
             .BFIn_down(in0_down),
             .twd(twd1));


   BFj#(NBITS) 
        Butterflyj0_1
            (.BFOut_up(blqI1_to_m_up),
             .BFOut_down(blqI1_to_m_down),
             .BFIn_up(in1_up),
             .BFIn_down(in1_down),
             .twd(twd1));
    

    
   
assign m_to_blqII0_up  = blqI0_to_m_up;  // Cable
assign m_to_blqII1_up  = blqI0_to_m_down ;  // Cable

////producto 0_0
// multip_tdw
// #(NBITS+1,NBITScoeff)
//       M0_0_tdw
//       (.result(m_to_blqII1_up),
//        .muestra(blqI0_to_m_down),
//        .coeff(coefficientes0_0));
        
assign m_to_blqII0_down= blqI1_to_m_up; // Cable
assign m_to_blqII1_down= blqI1_to_m_down; // Cable
        
//  //producto 0_1
// multip_tdw
// #(NBITS+1,NBITScoeff)
//       M0_1_tdw
//       (.result(m_to_blqII1_down),
//        .muestra(blqI1_to_m_down),
//        .coeff(coefficientes0_1));       
    
   
    
 /// 22 bits termina etapa anterior   
////////////////////////////////////////////////////////////////////////////////    

 topD_1
 #(16)
    EnableCM_stage2
    (.Q(coeffCMStage2_en),
    .clk(clk),
    .rst(rst));

contador
 #(16) 
   control_Blq_BFII_0
        (.clk_out(ctrl_Blq_BFII),
         .clk(clk),
         .rst(!coeffCMStage2_en));  
         
         
contador
 #(8) 
   control_twd2
        (.clk_out(twd2),
         .clk(clk),
         .rst(!coeffCMStage2_en));           
         
   
Blqj
#(16,16,11)
     Blq_BFII_0
      (.BlqOut_up      (blqII0_to_m_up),
       .BlqOut_down  (blqII0_to_m_down),
       .BlqIn_up       (m_to_blqII0_up),
       .BlqIn_down   (m_to_blqII0_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFII),
       .twd(twd2)); 
    

    
Blq
#(16,16,11)
     Blq_BFII_1
      (.BlqOut_up       (blqII1_to_m_up),
       .BlqOut_down   (blqII1_to_m_down),
       .BlqIn_up       (m_to_blqII1_up),
       .BlqIn_down   (m_to_blqII1_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFII)); 
   
 /////////////////////////////////////////////////////////////////////
   

   

     
//assign coeffw1_0en=coeffCMStage2_en;
assign coeffw1_1en=coeffCMStage2_en;
assign coeffw1_2en=coeffCMStage2_en;
   

         
   
// coeff_mem_1_0   
//      Mcoeff_1_0
//     (.coeff_out(coefficientes1_0),
//      .clk(clk),
//      .rst(!coeffw1_0en));


      
 coeff_mem_1_1     
      Mcoeff_1_1
     (.coeff_out(coefficientes1_1),
      .clk(clk),
      .rst(!coeffw1_1en));
   

 coeff_mem_1_2     
      Mcoeff_1_2
     (.coeff_out(coefficientes1_2),
      .clk(clk),
      .rst(!coeffw1_1en));
   
   
   
   
   
   ///////////////////
   
assign   m_to_sat0_0_up = blqII0_to_m_up; 
assign  m_to_sat0_1_down =  blqII0_to_m_down;
      

////producto 1_0
// multip_tdw
// #(12,NBITScoeff)
//       M1_0_tdw
//       (.result(m_to_sat0_1_down),
//        .muestra(blqII0_to_m_down),
//        .coeff(coefficientes1_0));
        

  //producto 1_1
 multip
 #(12,NBITScoeff)
       M1_1
       (.result(m_to_sat1_0_up),
        .muestra(blqII1_to_m_up),
        .coeff(coefficientes1_1));      
  
   
     //producto 1_2
 multip
 #(12,NBITScoeff)
       M1_2
       (.result(m_to_sat1_1_down),
        .muestra(blqII1_to_m_down),
        .coeff(coefficientes1_2));      
        
   
   
   
   /////////////////////////////////////////////
          
     assign satout0_0_up[15*2-1:15] ={m_to_sat0_0_up[12*2-1:12],3'b0 };
     assign satout0_0_up[14:0]      ={m_to_sat0_0_up[11:0],3'b0};
     
     assign satout0_1_down[15*2-1:15] ={m_to_sat0_1_down[12*2-1:12],3'b0 };
     assign satout0_1_down[14:0]      ={m_to_sat0_1_down[11:0],3'b0};   
       
             
       
//       fixtop_sat
//        #(.NBITS_IN(23),
//          .NBI_IN(5),
//          .NBF_IN(18),
//          .NBITS_OUT(15),
//          .NBI_OUT(3),
//          .NBF_OUT(12))
//        sat0_out0_down
//         (.sat_out(satout0_1_down),
//          .sat_in(m_to_sat0_1_down)); 
   
     fixtop_sat
        #(.NBITS_IN(24),
          .NBI_IN(6),
          .NBF_IN(18),
          .NBITS_OUT(15),
          .NBI_OUT(3),
          .NBF_OUT(12))
        sat0_out1_up
         (.sat_out(satout1_0_up),
          .sat_in(m_to_sat1_0_up)); 
          
            fixtop_sat
        #(.NBITS_IN(24),
          .NBI_IN(6),
          .NBF_IN(18),
          .NBITS_OUT(15),
          .NBI_OUT(3),
          .NBF_OUT(12))
        sat0_out1_down
         (.sat_out(satout1_1_down),
          .sat_in(m_to_sat1_1_down)); 
   
always @(posedge clk) begin         
if (rst) begin
 fftOut0_up   =   {NBITS_out*2{1'b0}};
 fftOut0_down = {NBITS_out*2{1'b0}};
 fftOut1_up   =   {NBITS_out*2{1'b0}};
 fftOut1_down = {NBITS_out*2{1'b0}};
 o_enable = 0;
end else begin
 fftOut0_up   =   satout0_0_up;
 fftOut0_down = satout0_1_down;
 fftOut1_up   =   satout1_0_up;
 fftOut1_down = satout1_1_down;
 o_enable = coeffCMStage2_en;
end
end



endmodule
