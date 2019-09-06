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
     #(parameter NBITS = 2,
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


  wire [(NBITS+1)-1:0] sat0_up;
  wire [(NBITS+1)*2-1:0] sat1_up;
  wire [(NBITS+1)*2+1-1:0] sat2_up;

 
  wire [(NBITS+1)*2-1:0] sat0_down;
  wire [(NBITS+1)*2-1:0] sat1_down;
  wire [(NBITS+1)*2-1:0] sat2_down;

  wire [(NBITS)*2-1:0] blq_connect_up[0:7];
  wire [(NBITS)*2-1:0] blq_connect_down[0:7];
  wire ctrl_1,ctrl_2,ctrl_3,ctrl_4;
  wire rstcont1;
    
  assign blq_connect_up[0] = fftIn_up;
  assign blq_connect_down[0] = fftIn_down;
  
  assign fftOut_up =blq_connect_up[7];
  assign fftOut_down = blq_connect_down[7] ;

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
      
      
      
      
      
 
  
 //puente salida del primer BF
 //assign blq_connect_up[2] = blq_connect_up[1]; 
   assign sat0_up = blq_connect_up[1]; 
 
//producto 0
 multip
 #(NBITS)
       M0
       (//.result(blq_connect_down[2]),
        .result(sat0_down),
        .muestra(blq_connect_down[1]),
        .coeff(coefficientes0));
        
             
//producto 1 2
 multip
 #(NBITS) 
        M1
        (.result(sat1_up),
         .muestra(blq_connect_up[3]),
         .coeff(coefficientes1));

 multip
 #(NBITS) 
        M2
        (.result(sat1_down),
         .muestra(blq_connect_down[3]),
         .coeff(coefficientes2));

        
//producto 3 4
 multip
 #(NBITS) 
        M3
       (.result(blq_connect_up[6]),
        .muestra(blq_connect_up[5]),
        .coeff(coefficientes3));
        
 multip
 #(NBITS) 
        M4
        (.result(blq_connect_down[6]),
        .muestra(blq_connect_down[5]),
        .coeff(coefficientes4));
    
//Blq I
Blq
#(4,4,NBITS) 
    Blq_BFI
       (.BlqOut_up(blq_connect_up[1]),
        .BlqOut_down(blq_connect_down[1]),
        .BlqIn_up(blq_connect_up[0]),
        .BlqIn_down(blq_connect_down[0]),
        .clk(clk),
        .rst(rst),
        .ctrl(ctrl_1));  

//Blq II
Blq
#(2,2,NBITS)
     Blq_BFII
      (.BlqOut_up(blq_connect_up[3]),
       .BlqOut_down(blq_connect_down[3]),
       .BlqIn_up(blq_connect_up[2]),
       .BlqIn_down(blq_connect_down[2]),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_2)); 
       
//Blq III   
Blq
#(1,1,NBITS) 
    Blq_BFIII
    (.BlqOut_up(blq_connect_up[5]),
     .BlqOut_down(blq_connect_down[5]),
     .BlqIn_up(blq_connect_up[4]),
     .BlqIn_down(blq_connect_down[4]),
     .clk(clk),
     .rst(rst),
     .ctrl(ctrl_3));
    
//BlqIV
Blq
#(4,4,NBITS) 
    Blq_BFIV
   (.BlqOut_up(sat2_up),
    .BlqOut_down(sat2_down),
    .BlqIn_up(blq_connect_up[6]),
    .BlqIn_down(blq_connect_down[6]),
    .clk(clk),
    .rst(rst),
    .ctrl(ctrl_4));  




/////Bloque de saturacion 0        
       fixtop_sat
         #(.NBITS_IN((NBITS+1)*2),
           .NBITS_OUT(NBITS))
        saturacion0_up
          (.sat_in(sat0_up),
           .sat_out(blq_connect_up[2]));
           
           
          fixtop_sat
         #(.NBITS_IN((NBITS+1)*2),
           .NBITS_OUT(NBITS))
        saturacion0_down
          (.sat_in(sat0_down),
           .sat_out(blq_connect_down[2]));

           
 ///////////////////////////////
                
        
/////Bloque de saturacion 1 2
        fixtop_sat
         #(.NBITS_IN((NBITS+1)*2),
           .NBITS_OUT(NBITS))
        saturacion1_up
          (.sat_in(sat1_up),
           .sat_out(blq_connect_up[4]));
           
           fixtop_sat
         #(.NBITS_IN((NBITS+1)*2),
           .NBITS_OUT(NBITS))
        saturacion1_down
          (.sat_in(sat1_down),
           .sat_out(blq_connect_down[4]));
///////////////////////////////        
     
             

  /////Bloque de saturacion final
       fixtop_sat
         #(.NBITS_IN((NBITS+1)*2+1),
           .NBITS_OUT(NBITS))
        saturacion2_up
          (.sat_in(sat2_up),
           .sat_out(blq_connect_up[7]));
           
           
       fixtop_sat
         #(.NBITS_IN((NBITS+1)*2+1),
           .NBITS_OUT(NBITS))
        saturacion2_down
          (.sat_in(sat2_down),
           .sat_out(blq_connect_down[7]));
 
 ///////////////////////////////      
    
endmodule
