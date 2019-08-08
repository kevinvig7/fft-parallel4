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


module D_reg_1(
    D,
    Q,
    rst,
    clk
    );
    
    input D;
    output reg Q;
    input rst;
    input clk;
    

   always @(posedge clk) begin
     if (rst) begin
       Q <= 1'b0;
      end else begin
         Q <= D;
     end
 end
   
   

				
   
   
   
   
   
	
	endmodule