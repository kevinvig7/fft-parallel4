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
     (output [((NBITS+1)*2+1)*2-1:0] fftOut0_up,
      output [((NBITS+1)*2+1)*2-1:0] fftOut0_down,
      output [((NBITS+1)*2+1)*2-1:0] fftOut1_up,
      output [((NBITS+1)*2+1)*2-1:0] fftOut1_down,
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
  
  wire ctrl_Blq_BFII;
 
  
  
 assign coeffw0_0en=rst;
 assign coeffw0_1en=rst;
 /////////
 
 wire [NBITS*2-1:0]   in0_up;
 wire [NBITS*2-1:0] in0_down;
 wire [NBITS*2-1:0]   in1_up;
 wire [NBITS*2-1:0] in1_down;
 
 wire [((NBITS+1)*2+1)*2-1:0]   out0_up;
 wire [((NBITS+1)*2+1)*2-1:0] out0_down;
 wire [((NBITS+1)*2+1)*2-1:0]   out1_up;
 wire [((NBITS+1)*2+1)*2-1:0] out1_down;
 
 
 wire [(NBITS+1)*2-1:0] blqI0_to_m_up  ;
 wire [(NBITS+1)*2-1:0] blqI0_to_m_down;
 wire [(NBITS+1)*2-1:0] blqI1_to_m_up  ;
 wire [(NBITS+1)*2-1:0] blqI1_to_m_down;
 
 
 wire [(NBITS+1)*2*2-1:0] m_to_blqII0_up  ;
 wire [(NBITS+1)*2*2-1:0] m_to_blqII0_down;

 wire [(NBITS+1)*2*2-1:0] m_to_blqII1_up  ;
 wire [(NBITS+1)*2*2-1:0] m_to_blqII1_down;



  assign in0_up   =   fftIn0_up;
  assign in0_down = fftIn0_down;
  assign in1_up   =   fftIn1_up;
  assign in1_down = fftIn1_down;
  
  
  assign fftOut0_up   =   out0_up;
  assign fftOut0_down = out0_down;
  assign fftOut1_up   =   out1_up;
  assign fftOut1_down = out1_down;
    
  
/////////////////////////////////  
 coeff0_0
 #(NBITScoeff,N)
      Mcoeff0_0
     (.coeff_out(coefficientes0_0),
      .clk(clk),
      .rst(coeffw0_0en));

 coeff0_1
 #(NBITScoeff,N)
      Mcoeff0_1
     (.coeff_out(coefficientes0_1),
      .clk(clk),
      .rst(coeffw0_1en));
 /////////////////////////////////      
 
 
assign m_to_blqII0_up[(NBITS+1)*2*2-1:(NBITS+1)*2] = $signed(blqI0_to_m_up[(NBITS+1)*2-1:NBITS+1]); ////expandir signo aqui
assign                 m_to_blqII0_up[(NBITS+1)*2-1:0] = $signed(blqI0_to_m_up[NBITS:0]);//expandir signo aqui
      

//producto 0_0
 multip
 #(NBITS+1,NBITScoeff)
       M0_0
       (.result(m_to_blqII0_down),
        .muestra(blqI0_to_m_down),
        .coeff(coefficientes0_0));
        
assign m_to_blqII1_up[(NBITS+1)*2*2-1:(NBITS+1)*2] = $signed(blqI1_to_m_up[(NBITS+1)*2-1:NBITS+1]); ////expandir signo aqui
assign             m_to_blqII1_up[(NBITS+1)*2-1:0] = $signed(blqI1_to_m_up[NBITS:0]);//expandir signo aqui
        
  //producto 0_1
 multip
 #(NBITS+1,NBITScoeff)
       M0_1
       (.result(m_to_blqII1_down),
        .muestra(blqI1_to_m_down),
        .coeff(coefficientes0_1));      
        
        

//BFI I
   BF#(NBITS) 
        Butterfly0_0
            (.BFOut_up(blqI0_to_m_up),
             .BFOut_down(blqI0_to_m_down),
             .BFIn_up(in0_up),
             .BFIn_down(in0_down));


   BF#(NBITS) 
        Butterfly0_1
            (.BFOut_up(blqI1_to_m_up),
             .BFOut_down(blqI1_to_m_down),
             .BFIn_up(in1_up),
             .BFIn_down(in1_down));

    
    
////////////////////////////////////////////////////////////////////////////////    
contador
 #(16) 
   control_Blq_BFII_0
        (.clk_out(ctrl_Blq_BFII),
         .clk(clk),
         .rst(rst));  
   
Blq
#(16,16,(NBITS+1)*2)
     Blq_BFII_0
      (.BlqOut_up      (out0_up),
       .BlqOut_down  (out0_down),
       .BlqIn_up       (m_to_blqII0_up),
       .BlqIn_down   (m_to_blqII0_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFII)); 
    

    
Blq
#(16,16,(NBITS+1)*2)
     Blq_BFII_1
      (.BlqOut_up       (out1_up),
       .BlqOut_down   (out1_down),
       .BlqIn_up       (m_to_blqII1_up),
       .BlqIn_down   (m_to_blqII1_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFII)); 
   
 /////////////////////////////////////////////////////////////////////
   
  assign coeffw1_0en=ctrl_Blq_BFII;
  assign coeffw1_1en=ctrl_Blq_BFII;
  assign coeffw1_2en=ctrl_Blq_BFII;
   
   
      
   
coeff1_0
 #(NBITScoeff,N)
      Mcoeff1_0
     (.coeff_out(coefficientes1_0),
      .clk(clk),
      .rst(coeffw1_0en));

 coeff1_1
 #(NBITScoeff,N)
      Mcoeff1_1
     (.coeff_out(coefficientes1_1),
      .clk(clk),
      .rst(coeffw1_1en));
   
   
coeff1_2
 #(NBITScoeff,N)
      Mcoeff1_2
     (.coeff_out(coefficientes1_2),
      .clk(clk),
      .rst(coeffw1_2en));
   
   
   
   
   
   
   
   
   
   
   
                  

///////////////////////////////      
    
endmodule
