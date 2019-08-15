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
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module topfft 
     #(parameter Nbits = 2,
       parameter N = 8)
     (output [Nbits*2-1:0] fftOut_up,
      output [Nbits*2-1:0] fftOut_down,
      input  [Nbits*2-1:0] fftIn_up,
      input  [Nbits*2-1:0] fftIn_down,
      input clk,
      input rst);
      
  wire [Nbits*2-1:0] coefficientes0;
  wire [Nbits*2-1:0] coefficientes1;
  wire [Nbits*2-1:0] coefficientes2;
  wire [Nbits*2-1:0] coefficientes3;
  wire [Nbits*2-1:0] coefficientes4;
  
  wire coeffw0_en;
  wire coeffw12_en;
  wire coeffw34_en;

  wire [Nbits*2-1:0] blq_connect_up[0:7];
  wire [Nbits*2-1:0] blq_connect_down[0:7];
  wire ctrl_1,ctrl_2,ctrl_3,ctrl_4;
  wire rstcont1;
    
  assign blq_connect_up[0] = fftIn_up;
  assign blq_connect_down[0] = fftIn_down;
  
  assign fftOut_up =blq_connect_up[7];
  assign fftOut_down = blq_connect_down[7] ;

  assign rstcont1 = !rst;

 contador#(4) control_1(clk,rstcont1,ctrl_1);
 contador#(2) control_2(clk,coeffw0_en,ctrl_2); 
 contador#(1) control_3(clk,coeffw12_en,ctrl_3); 
 contador#(4) control_4(clk,coeffw34_en,ctrl_4); 
 
 
 topD_1#(4) Dcoeffw0(clk,coeffw0_en,rst,clk);
 topD_1#(6) Dcoeffw12(clk,coeffw12_en,rst,clk);
 topD_1#(7) Dcoeffw34(clk,coeffw34_en,rst,clk);
 
 coeff0#(Nbits,N)  Mcoeff0(coefficientes0,clk,coeffw0_en);
 coeff1#(Nbits,N)  Mcoeff1(coefficientes1,clk,coeffw12_en);
 coeff2#(Nbits,N)  Mcoeff2(coefficientes2,clk,coeffw12_en);
 coeff3#(Nbits,N)  Mcoeff3(coefficientes3,clk,coeffw34_en);
 coeff4#(Nbits,N)  Mcoeff4(coefficientes4,clk,coeffw34_en);
 
  assign blq_connect_up[2] = blq_connect_up[1]; 
 
 
 //producto 0
 multip#(Nbits) M0(blq_connect_down[1],coefficientes0,blq_connect_down[2]);
  
  
 //producto 1 2
 multip#(Nbits) M1(blq_connect_up[3],coefficientes1,blq_connect_up[4]);
 multip#(Nbits) M2(blq_connect_down[3],coefficientes2,blq_connect_down[4]);
  
  
 //producto 3 4
 multip#(Nbits) M3(blq_connect_up[5],coefficientes3,blq_connect_up[6]);
 multip#(Nbits) M4(blq_connect_down[5],coefficientes4,blq_connect_down[6]);
    
  
  Blq#(4,4,Nbits) Blq_BFI(blq_connect_up[0],blq_connect_down[0],blq_connect_up[1],blq_connect_down[1],rst,clk,ctrl_1);
  Blq#(2,2,Nbits) Blq_BFII(blq_connect_up[2],blq_connect_down[2],blq_connect_up[3],blq_connect_down[3],rst,clk,ctrl_2);
  Blq#(1,1,Nbits) Blq_BFIII(blq_connect_up[4],blq_connect_down[4],blq_connect_up[5],blq_connect_down[5],rst,clk,ctrl_3);   
  Blq#(4,4,Nbits) Blq_BFIV(blq_connect_up[6],blq_connect_down[6],blq_connect_up[7],blq_connect_down[7],rst,clk,ctrl_4);   

    
endmodule
