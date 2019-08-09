`timescale 1ns / 1ps
//`include "def.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2019 14:32:39
// Design Name: 
// Module Name: topD
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


module topD_1(
    D,
    Q,
    rst,
    clk
    );
  parameter   ND = 4;

  
    input D;
    output Q;
    input rst;
    input clk;
    
    
    wire [ND:0] connect_wire;
    
    assign connect_wire[0] = D;
    assign  Q = connect_wire[ND];
    
   genvar i;
   generate
      for (i=1; i <= ND; i=i+1) begin:
      Dgen D_reg_1 nD(connect_wire[i-1],connect_wire[i],rst,clk);
     end
   endgenerate
    
endmodule


  
			

