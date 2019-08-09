`timescale 1ns / 1ps
`include "def.v"
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


module topfft(
    fftIn_up,
    fftIn_down,
    fftOut_up,
    fftOut_down,
    clk,
    rst,
    ctrl
    );

  parameter Nbits = `Nbitsg;
  
  parameter w0=1;
  parameter w1=1;
  parameter w2=1;
  parameter w3=1;
  parameter w4=1;
  parameter w5=1;

    input [Nbits*2-1:0] fftIn_up;
    input  [Nbits*2-1:0] fftIn_down;
    output [Nbits*2-1:0] fftOut_up;
    output [Nbits*2-1:0] fftOut_down;
    input clk;
    input rst;
    input ctrl;
    
  wire [Nbits*2-1:0] blq_connect_up[0:13];
  wire [Nbits*2-1:0] blq_connect_down[0:13];
  
  
  assign blq_connect_up[0] = fftIn_up;
  assign blq_connect_down[0] = fftIn_down;
  
  assign blq_connect_up[13] = fftOut_up;
  assign blq_connect_down[13] = fftOut_down;
  
  Blq#(128,128) BFI(blq_connect_up[0],blq_connect_down[0],blq_connect_up[1],blq_connect_down[1],rst,clk,ctrl);
  
  Blq#(64,64) BFII(blq_connect_up[1],blq_connect_down[1],blq_connect_up[2],blq_connect_down[2],rst,clk,ctrl);
  
    //producto 0 
 assign blq_connect_up[3] = blq_connect_up[2]; 
 assign blq_connect_down[3] =  blq_connect_down[2]*w0;   
    
 Blq#(32,32) BFIII(blq_connect_up[3],blq_connect_down[3],blq_connect_up[4],blq_connect_down[4],rst,clk,ctrl);   
    
     //producto 1 2
 assign blq_connect_up[5] = blq_connect_up[4]*w1; 
 assign blq_connect_down[5] =  blq_connect_down[4]*w2;   
    
     
 Blq#(16,16) BFIV(blq_connect_up[5],blq_connect_down[5],blq_connect_up[6],blq_connect_down[6],rst,clk,ctrl);   
 Blq#(8,8) BFV(blq_connect_up[6],blq_connect_down[6],blq_connect_up[7],blq_connect_down[7],rst,clk,ctrl);   
    
       //producto 3  
 assign blq_connect_up[8] = blq_connect_up[7]; 
 assign blq_connect_down[8] =  blq_connect_down[7]*w3;   
    
 Blq#(4,4) BFVI(blq_connect_up[8],blq_connect_down[8],blq_connect_up[9],blq_connect_down[9],rst,clk,ctrl);     
    
   //producto 4 5
 assign blq_connect_up[10] = blq_connect_up[9]*w4; 
 assign blq_connect_down[10] =  blq_connect_down[9]*w5;   
    
    
    
 Blq#(2,2) BFVII(blq_connect_up[10],blq_connect_down[10],blq_connect_up[11],blq_connect_down[11],rst,clk,ctrl);      
 Blq#(1,1) BFVIII(blq_connect_up[11],blq_connect_down[11],blq_connect_up[12],blq_connect_down[12],rst,clk,ctrl);      
    
    
 Blq#(128,128) BFIX(blq_connect_up[12],blq_connect_down[12],blq_connect_up[13],blq_connect_down[13],rst,clk,ctrl); 
    
    
    
    
    
    
endmodule
