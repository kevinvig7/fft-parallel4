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
    rst
    );

  parameter Nbits = `Nbitsg;
  
  parameter w0=1;
  parameter w1=1;
  parameter w2=1;
  parameter w3=1;
  parameter w4=1;

    input [Nbits*2-1:0] fftIn_up;
    input  [Nbits*2-1:0] fftIn_down;
    output [Nbits*2-1:0] fftOut_up;
    output [Nbits*2-1:0] fftOut_down;
    input clk;
    input rst;
    
  wire [Nbits*2-1:0] blq_connect_up[0:7];
  wire [Nbits*2-1:0] blq_connect_down[0:7];
  wire ctrl_1,ctrl_2,ctrl_4;
    
  assign blq_connect_up[0] = fftIn_up;
  assign blq_connect_down[0] = fftIn_down;
  
  assign blq_connect_up[7] = fftOut_up;
  assign blq_connect_down[7] = fftOut_down;
  
 contador#(4) control_4(clk,rst,ctrl_4);
 contador#(2) control_2(clk,rst,ctrl_2); 
 contador#(1) control_1(clk,rst,ctrl_1); 

  
  Blq#(4,4) BFI(blq_connect_up[0],blq_connect_down[0],blq_connect_up[1],blq_connect_down[1],rst,clk,ctrl_4);
  
  
 //producto 0 
 assign blq_connect_up[2] = blq_connect_up[1]; 
 assign blq_connect_down[2] =  blq_connect_down[1]*w0;   
 
   Blq#(2,2) BFII(blq_connect_up[2],blq_connect_down[2],blq_connect_up[3],blq_connect_down[3],rst,clk,ctrl_2);
  
     //producto 1 2
 assign blq_connect_up[4] = blq_connect_up[3]*w1; 
 assign blq_connect_down[4] =  blq_connect_down[3]*w2;   
    
        
 Blq#(1,1) BFIII(blq_connect_up[4],blq_connect_down[4],blq_connect_up[5],blq_connect_down[5],rst,clk,ctrl_1);   
    
     //producto 3 4
 assign blq_connect_up[6] = blq_connect_up[5]*w3; 
 assign blq_connect_down[6] =  blq_connect_down[5]*w4;   
    
     
 Blq#(4,4) BFIV(blq_connect_up[6],blq_connect_down[6],blq_connect_up[7],blq_connect_down[7],rst,clk,ctrl_4);   
 
  
    
    
    
    
    
endmodule
