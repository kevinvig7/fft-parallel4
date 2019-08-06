`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2019 14:37:49
// Design Name: 
// Module Name: top_ROMfft
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


module top_ROMfft(
        coeff_out,
        adress_in,
        enable,
        clk,
        rst    
    );
        
// 0  0   2  2  0  0  2  2 
// 0  10  0  0  0  10 0  0
// 0  11  0  2  0  11 0  2
// 0  0   0  0  0  4  3  5
// 0  0   0  0  6  8  7  9
parameter [0:7] coeff1 = {0,0,2,2,0,0,2,2};
 
   
    
    
ROMfft  M1()
    
  
    

    
    
    
endmodule
