`timescale 1ns / 1ps
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


module D_reg(
    input D,
    output reg Q,
    input rst,
    input clk
    );






   always @(posedge clk)
      if (rst) begin
         Q <= 1'b0;
      end else begin
         Q <= D;
      end
						
				endmodule