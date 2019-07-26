`timescale 1ns / 1ps
`include "def.v"
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
    D,
    Q,
    rst,
    clk
    );
    
parameter Nbits = `Nbitsg;

    input [0:(Nbits*2)-1] D;
    output reg [0:Nbits*2-1] Q;
    input rst;
    input clk;
    
wire [0:Nbits/2-1] q[0:1];
assign q[0] = D[0:Nbits/2-1];
assign q[1] = D[Nbits/2:Nbits-1];


   always @(posedge clk) begin
      if (rst) begin
        Q <= Nbits*2'b0;
      end 
      else begin
         Q <= {q[0],q[1]};
      end
    end
	
	endmodule