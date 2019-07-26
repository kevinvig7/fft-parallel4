`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2019 11:01:50
// Design Name: 
// Module Name: top_fft
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


module top_fft(
    input sampleIn_up,
    input sampleIn_down,
    output sampleOut_up,
    output sampleOut_down,
    input rst,
    input clk,
    input ctrl
    );
    
   
Blq B0(sampleIn_up,sampleIn_down,sampleOut_up,sampleOut_down,rst,clk,ctrl);


endmodule

           
