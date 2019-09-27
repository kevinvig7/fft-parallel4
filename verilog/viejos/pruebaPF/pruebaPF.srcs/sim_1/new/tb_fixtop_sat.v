`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2019 11:33:27
// Design Name: 
// Module Name: tb_fixtop
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


module tb_fixtop_sat();



    
  parameter NBITS=8;
  parameter NBITS_OUT=6;

wire [NBITS-1:0] sat_in;
wire [NBITS_OUT-1:0] sat_out;
  
   
    
sat
#()
satur
(.sat_out(sat_out),
  .sat_in(sat_in));
 
initial begin

    
    end
    
    
endmodule
