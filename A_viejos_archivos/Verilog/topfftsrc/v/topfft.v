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
     #(parameter NBITS = 3,
     parameter NBITScoeff=NBITS+1,
       parameter N = 8) // Cantidad de coeficientes en los multiplicadores
     (output [NBITS*2-1:0] fftOut_up,
      output [NBITS*2-1:0] fftOut_down,
      input  [NBITS*2-1:0] fftIn_up,
      input  [NBITS*2-1:0] fftIn_down,
      input clk,
      input rst);
      
  wire [NBITScoeff*2-1:0] coefficientes0;
  wire [NBITScoeff*2-1:0] coefficientes1;
  wire [NBITScoeff*2-1:0] coefficientes2;
  wire [NBITScoeff*2-1:0] coefficientes3;
  wire [NBITScoeff*2-1:0] coefficientes4;
  
   
  wire coeffw0_en;
  wire coeffw12_en;
  wire coeffw34_en;


 /////////
 
 wire [NBITS*2-1:0]   in_up;
 wire [NBITS*2-1:0] in_down;
 
 wire [(NBITS+1)*2-1:0] blqI_to_m_up  ;
 wire [(NBITS+1)*2-1:0] blqI_to_m_down;

 wire [(NBITS+1)*2*2-1:0] m_to_blqII_up  ;
 wire [(NBITS+1)*2*2-1:0] m_to_blqII_down;
 
 wire [((NBITS+1)*2+1)*2-1:0] blqII_to_m_up;
 wire [((NBITS+1)*2+1)*2-1:0] blqII_to_m_down;
 
 wire [((NBITS+1)*2+1)*2*2-1:0] m_to_satm_up  ;
 wire [((NBITS+1)*2+1)*2*2-1:0] m_to_satm_down;
 
 wire [(NBITS*2)-1:0] satm_to_blqIII_up;
 wire [(NBITS*2)-1:0] satm_to_blqIII_down;

 wire [(NBITS+1)*2-1:0] blqIII_to_m_up  ;
 wire [(NBITS+1)*2-1:0] blqIII_to_m_down;
 

   
 wire [(NBITS+1)*2*2-1:0] m_to_blqIV_up  ;
 wire [(NBITS+1)*2*2-1:0] m_to_blqIV_down; 
   
 wire [((NBITS+1)*2+1)*2-1:0]   blqIV_to_satout_up;
 wire [((NBITS+1)*2+1)*2-1:0] blqIV_to_satout_down;
  

 
 wire [NBITS*2-1:0]   satout_up;
 wire [NBITS*2-1:0] satout_down;

  wire ctrl_1,ctrl_2,ctrl_3,ctrl_4;
  wire rstcont1;
    
  assign in_up   =   fftIn_up;
  assign in_down = fftIn_down;
  
  assign fftOut_up   =   satout_up;
  assign fftOut_down = satout_down;

  assign rstcont1 = !rst;

 contador
 #(4) 
   control_1
        (.clk_out(ctrl_1),
         .clk(clk),
         .rst(rstcont1));
        
contador
#(2) 
   control_2
        (.clk_out(ctrl_2),
         .clk(clk),
         .rst(coeffw0_en));
               
contador
#(1) 
   control_3
        (.clk_out(ctrl_3),
         .clk(clk),
         .rst(coeffw12_en));

contador
#(4) 
   control_4
        (.clk_out(ctrl_4),
         .clk(clk),
         .rst(coeffw34_en));

 
 
 coeff0
 #(NBITScoeff,N)
      Mcoeff0
     (.coeff_out(coefficientes0),
      .clk(clk),
      .rst(coeffw0_en));

 coeff1
 #(NBITScoeff,N)
      Mcoeff1
     (.coeff_out(coefficientes1),
      .clk(clk),
      .rst(coeffw12_en));
      
 coeff2
 #(NBITScoeff,N)
      Mcoeff2
      (.coeff_out(coefficientes2),
      .clk(clk),
      .rst(coeffw12_en));
      
 coeff3
 #(NBITScoeff,N) 
      Mcoeff3
      (.coeff_out(coefficientes3),
      .clk(clk),
      .rst(coeffw34_en));
      
 coeff4
 #(NBITScoeff,N) 
      Mcoeff4
      (.coeff_out(coefficientes4),
      .clk(clk),
      .rst(coeffw34_en));
      
      
///////////////////////////////
   topD_1
 #(4)
     Enable_0
     (.Q(coeffw0_en),
      .D(clk),
      .clk(clk),
      .rst(rst));
      
 topD_1
 #(6)
     Enable_12
     (.Q(coeffw12_en),
      .D(clk),
      .clk(clk),
      .rst(rst));      
      
 topD_1
 #(7)
     Enable_34
     (.Q(coeffw34_en),
      .D(clk),
      .clk(clk),
      .rst(rst));         
      
/////////////////////////////////      
       
      

//producto 0
 multip
 #(NBITS+1,NBITScoeff)
       M0
       (.result(m_to_blqII_down),
        .muestra(blqI_to_m_down),
        .coeff(coefficientes0));
        
             
//producto 1 2
 multip
 #((NBITS+1)*2+1,NBITScoeff) 
        M1
        (.result(m_to_satm_up),
         .muestra(blqII_to_m_up),
         .coeff(coefficientes1));

 multip
 #((NBITS+1)*2+1,NBITScoeff) 
        M2
        (.result(m_to_satm_down),
         .muestra(blqII_to_m_down),
         .coeff(coefficientes2));

        
//producto 3 4
 multip
 #(NBITS+1,NBITScoeff) 
        M3
       (.result(m_to_blqIV_up),
        .muestra(blqIII_to_m_up),
        .coeff(coefficientes3));
        
 multip
 #(NBITS+1,NBITScoeff) 
        M4
       (.result(m_to_blqIV_down),
        .muestra(blqIII_to_m_down),
        .coeff(coefficientes4));
    
//Blq I
Blq
#(4,4,NBITS) 
    Blq_BFI
       (.BlqOut_up    (blqI_to_m_up),
        .BlqOut_down(blqI_to_m_down),
        .BlqIn_up            (in_up),
        .BlqIn_down        (in_down),
        .clk(clk),
        .rst(rst),
        .ctrl(ctrl_1));  

//Blq II
assign m_to_blqII_up[(NBITS+1)*2*2-1:NBITS-1] = $signed(blqI_to_m_up[(NBITS+1)*2-1:NBITS-1]); ////expandir signo aqui
assign                 m_to_blqII_up[NBITS:0] = $signed(blqI_to_m_up[NBITS:0]);//expandir signo aqui


Blq
#(2,2,(NBITS+1)*2)
     Blq_BFII
      (.BlqOut_up      (blqII_to_m_up),
       .BlqOut_down  (blqII_to_m_down),
       .BlqIn_up       (m_to_blqII_up),
       .BlqIn_down   (m_to_blqII_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_2)); 
       
//Blq III   
Blq
#(1,1,NBITS) 
    Blq_BFIII
    (.BlqOut_up    (blqIII_to_m_up),
     .BlqOut_down(blqIII_to_m_down),
     .BlqIn_up      (satm_to_blqIII_up),
     .BlqIn_down  (satm_to_blqIII_down),
     .clk(clk),
     .rst(rst),
     .ctrl(ctrl_3));
    
//BlqIV
Blq
#(4,4,(NBITS+1)*2) 
    Blq_BFIV
   (.BlqOut_up    (blqIV_to_satout_up),
    .BlqOut_down(blqIV_to_satout_down),
    .BlqIn_up          (m_to_blqIV_up),
    .BlqIn_down      (m_to_blqIV_down),
    .clk(clk),
    .rst(rst),
    .ctrl(ctrl_4));  



/////Bloque de saturacion intermedio  
       fixtop_sat
         #(.NBITS_IN(((NBITS+1)*2+1)*2),
           .NBITS_OUT(NBITS))
        saturacion_m_up
          (.sat_out(satm_to_blqIII_up),
           .sat_in  (m_to_satm_up));
           
           
          fixtop_sat
         #(.NBITS_IN(((NBITS+1)*2+1)*2),
           .NBITS_OUT(NBITS))
        saturacion_m_down
          (.sat_out(satm_to_blqIII_down),
           .sat_in (m_to_satm_down));
    
 ///////////////////////////////
   
                  

/////Bloque de saturacion final
       fixtop_sat
         #(.NBITS_IN((NBITS+1)*2+1),
          .NBITS_OUT(NBITS))
       saturacion_out_up
         (.sat_out(satout_up),
          .sat_in(blqIV_to_satout_up));
       
       
       fixtop_sat
        #(.NBITS_IN((NBITS+1)*2+1),
           .NBITS_OUT(NBITS))
        saturacion_out_down
         (.sat_out(satout_down),
          .sat_in(blqIV_to_satout_down));

///////////////////////////////      
    
endmodule
