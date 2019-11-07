`timescale 1ns / 1ps
//`include "def.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2019 11:39:41
// Design Name: 
// Module Name: D_reg
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


module D_reg
    #(parameter Nbits = 2)
    (output reg [Nbits*2-1:0] Q,
     input [Nbits*2-1:0] D,
     input clk,
     input rst);



   always @(posedge clk) begin
     if (rst) begin
       Q <= {Nbits*2{1'b0}};
      end else begin
         Q <= D;
     end
 end
   
   

				
   
   
   
   
   
	
	endmodule