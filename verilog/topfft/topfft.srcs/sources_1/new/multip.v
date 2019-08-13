`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.08.2019 15:42:22
// Design Name: 
// Module Name: multip
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


module multip(
    muestra,
    coeff,
    result
    );
    
    parameter Nbits=2;
    input [Nbits*2-1:0] muestra;
    input [Nbits*2-1:0] coeff;
    output[Nbits*2-1:0] result;
     
    
     
    assign result[Nbits*2-1:Nbits] = muestra[0]*coeff[0]-muestra[1]*coeff[1]; 
    assign result[Nbits-1:0] = muestra[0]*coeff[1]+muestra[1]*coeff[0];
    
    
    
    
    
    
    
endmodule
