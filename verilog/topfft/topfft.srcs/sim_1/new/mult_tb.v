`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2019 17:19:28
// Design Name: 
// Module Name: mult_tb
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


module mult_tb;
  
  reg signed [3:0] a = 3;
  reg signed [7:0] b = 63;
  wire signed [7:0] c;
  assign c = a*b;
  
  initial
    #1 $display("c= %d", c);
  
endmodule