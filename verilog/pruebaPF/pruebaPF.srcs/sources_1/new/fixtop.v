`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2019 10:39:47
// Design Name: 
// Module Name: fixtop
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


module fixtop
#(parameter NBITS=5,
  parameter NBITSF=4,  
  parameter  NB_SUM=5,
  parameter  NBF_SUM=4,
  parameter  NB_FFE_OUT=7,
  parameter  NBI_FFE_OUT=2)
  (input  [NBITS+NBITSF-1:0] out_sum,
   output reg [NB_FFE_OUT+NBI_FFE_OUT-1:0] sum_sat    
        );
    
        

            

    
    
endmodule
