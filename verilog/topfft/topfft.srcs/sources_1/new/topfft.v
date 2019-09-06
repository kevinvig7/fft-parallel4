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
     parameter NBITScoeff=3,
       parameter N = 8) // Cantidad de coeficientes en los multiplicadores
     (output [NBITS*2-1:0] fftOut_up,
      output [NBITS*2-1:0] fftOut_down,
      input  [NBITS*2-1:0] fftIn_up,
      input  [NBITS*2-1:0] fftIn_down,
      input clk,
      input rst);
      
  wire [(NBITS+1)*2-1:0] coefficientes0;
  wire [(NBITS+1)*2-1:0] coefficientes1;
  wire [(NBITS+1)*2-1:0] coefficientes2;
  wire [(NBITS+1)*2-1:0] coefficientes3;
  wire [(NBITS+1)*2-1:0] coefficientes4;
  
   
  wire coeffw0_en;
  wire coeffw12_en;
  wire coeffw34_en;


 /////////
 
 wire [NBITS*2-1:0]   in_up;
 wire [NBITS*2-1:0] in_down;
 
 wire [(NBITS+1)*2-1:0] blq_to_m_up  [0:1];
 wire [(NBITS+1)*2-1:0] blq_to_m_down[0:1];
 
 wire [(NBITS+1)*2*2-1:0] m_to_blq_up  [0:1];
 wire [(NBITS+1)*2*2-1:0] m_to_blq_down[0:1];
  
 wire [((NBITS+1)*2+1)*2-1:0]   blq_to_mm_up;
 wire [((NBITS+1)*2+1)*2-1:0] blq_to_mm_down;
 
 wire [((NBITS+1)*2+1)*2*2-1:0] mm_to_sat_up  ;
 wire [((NBITS+1)*2+1)*2*2-1:0] mm_to_sat_down;
  
 wire [(NBITS*2)-1:0] sat_to_blq_up;
 wire [(NBITS*2)-1:0] sat_to_blq_down;
 
 wire [((NBITS+1)*2+1)*2-1:0]   blq_to_satout_up;
 wire [((NBITS+1)*2+1)*2-1:0] blq_to_satout_down;
 
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
 #(NBITS+1,N)
      Mcoeff0
     (.coeff_out(coefficientes0),
      .clk(clk),
      .rst(coeffw0_en));

 coeff1
 #(NBITS+1,N)
      Mcoeff1
     (.coeff_out(coefficientes1),
      .clk(clk),
      .rst(coeffw12_en));
      
 coeff2
 #(NBITS+1,N)
      Mcoeff2
      (.coeff_out(coefficientes2),
      .clk(clk),
      .rst(coeffw12_en));
      
 coeff3
 #(NBITS+1,N) 
      Mcoeff3
      (.coeff_out(coefficientes3),
      .clk(clk),
      .rst(coeffw34_en));
      
 coeff4
 #(NBITS+1,N) 
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
       
      
   assign m_to_blq_up[0] = $signed(blq_to_m_up[0]); ////expandir signo aqui
 
//producto 0
 multip
 #(NBITS+1,NBITScoeff)
       M0
       (
        .result(m_to_blq_down[0]),
        .muestra(blq_to_m_down[0]),
        .coeff(coefficientes0));
        
             
//producto 1 2
 multip
 #((NBITS+1)*2+1,NBITScoeff) 
        M1
        (.result(mm_to_sat_up),
         .muestra(blq_to_mm_up),
         .coeff(coefficientes1));

 multip
 #((NBITS+1)*2+1,NBITScoeff) 
        M2
        (.result(mm_to_sat_down),
         .muestra(blq_to_mm_down),
         .coeff(coefficientes2));

        
//producto 3 4
 multip
 #(NBITS+1,NBITScoeff) 
        M3
       (.result(m_to_blq_up[1]),
        .muestra(blq_to_m_up[1]),
        .coeff(coefficientes3));
        
 multip
 #(NBITS+1,NBITScoeff) 
        M4
       (.result(m_to_blq_down[1]),
        .muestra(blq_to_m_down[1]),
        .coeff(coefficientes4));
    
//Blq I
Blq
#(4,4,NBITS) 
    Blq_BFI
       (.BlqOut_up(blq_to_m_up[0]),
        .BlqOut_down(blq_to_m_down[0]),
        .BlqIn_up(in_up),
        .BlqIn_down(in_down),
        .clk(clk),
        .rst(rst),
        .ctrl(ctrl_1));  

//Blq II
Blq
#(2,2,(NBITS+1)*2)
     Blq_BFII
      (.BlqOut_up(blq_to_mm_up),
       .BlqOut_down(blq_to_mm_down),
       .BlqIn_up(m_to_blq_up[0]),
       .BlqIn_down(m_to_blq_down[0]),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_2)); 
       
//Blq III   
Blq
#(1,1,NBITS) 
    Blq_BFIII
    (.BlqOut_up(blq_to_m_up[1]),
     .BlqOut_down(blq_to_m_down[1]),
     .BlqIn_up(sat_to_blq_up),
     .BlqIn_down(sat_to_blq_down),
     .clk(clk),
     .rst(rst),
     .ctrl(ctrl_3));
    
//BlqIV
Blq
#(4,4,(NBITS+1)*2) 
    Blq_BFIV
   (.BlqOut_up(blq_to_satout_up),
    .BlqOut_down(blq_to_satout_down),
    .BlqIn_up(m_to_blq_up[1]),
    .BlqIn_down(m_to_blq_up[1]),
    .clk(clk),
    .rst(rst),
    .ctrl(ctrl_4));  



/////Bloque de saturacion intermedio  
       fixtop_sat
         #(.NBITS_IN(((NBITS+1)*2+1)*2),
           .NBITS_OUT(NBITS))
        saturacion_m_up
          (.sat_in(mm_to_sat_up),
           .sat_out(sat_to_blq_up));
           
           
          fixtop_sat
         #(.NBITS_IN(((NBITS+1)*2+1)*2),
           .NBITS_OUT(NBITS))
        saturacion_m_down
          (.sat_in(mm_to_sat_down),
           .sat_out(sat_to_blq_down));

          
 ///////////////////////////////
   
                  

  /////Bloque de saturacion final
       fixtop_sat
         #(.NBITS_IN((NBITS+1)*2+1),
          .NBITS_OUT(NBITS))
       saturacion_out_up
         (.sat_in(blq_to_satout_up),
          .sat_out(satout_up));
       
       
       fixtop_sat
        #(.NBITS_IN((NBITS+1)*2+1),
           .NBITS_OUT(NBITS))
        saturacion_out_down
          (.sat_in(blq_to_satout_down),
          .sat_out(satout_down));

///////////////////////////////      
    
endmodule
