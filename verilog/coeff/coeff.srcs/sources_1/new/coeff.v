`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2019 15:59:05
// Design Name: 
// Module Name: coeff
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


module coeff(
clk,
coeff_out,
rst
    );
    
parameter Nbits=16; 
parameter N=8;
input rst;
input clk;
output reg [Nbits*2-1:0] coeff_out;
integer index=0;
wire [Nbits*N*2-1:0] coeff;

coeff_data coefficientes(coeff);


always @(posedge clk_in) begin
    if(rst) begin
    coeff_out<= ; 
    end
    else if 










endmodule
