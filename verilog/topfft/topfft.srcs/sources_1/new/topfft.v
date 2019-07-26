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

    input [Nbits*2-1:0] fftIn_up;
    input  [Nbits*2-1:0] fftIn_down;
    output [Nbits*2-1:0] fftOut_up;
    output [Nbits*2-1:0] fftOut_down;
    input clk;
    input rst;
    input ctrl;
    
  wire [Nbits*2-1:0] blq_connect_up[0:2];
  wire [Nbits*2-1:0] blq_connect_down[0:2];
  
  
  assign blq_connect_up[0] = fftIn_up;
  assign blq_connect_down[0] = fftIn_down;
  
  assign blq_connect_up[2] = fftOut_up;
  assign blq_connect_down[2] = fftOut_down;
  
  Blq#(32,32) BFI(blq_connect_up[0],blq_connect_down[0],blq_connect_up[1],blq_connect_down[1],rst,clk,ctrl);
  
    
  Blqj#(16,16) BFII(blq_connect_up[1],blq_connect_down[1],blq_connect_up[2],blq_connect_down[2],rst,clk,ctrl);
  
  
  
   
  
  
    
    
endmodule
