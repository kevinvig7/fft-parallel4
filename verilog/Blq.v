`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2019 11:04:29
// Design Name: 
// Module Name: Blq
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


module Blq(
    input BlqIn_up,
    input BlqIn_down,
    output BlqOut_up,
    output BlqOut_down,
    input clk,
    input rst,
    input ctrl
    );


wire w_up[0:2];
wire w_down[0:2];    
   
D_reg D0(w_down[0],w_down[1],rst,clk);


switch sw0(w_up[0],w_down[1],w_up[1],w_down[2],ctrl);

D_reg D1(w_up[1],w_up[2],rst,clk);

BF I(w_up[2],w_down[2],BlqOut_up,BlqOut_down);

endmodule
