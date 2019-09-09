`timescale 1ns / 1ps
`include "def.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2019 16:20:32
// Design Name: 
// Module Name: switch
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


module switch(
   swIn_up,
   swIn_down,
   swOut_up,
   swOut_down,
   ctrl
    );
    
    parameter Nbits=`Nbitsg;
    
    input [Nbits*2-1:0] swIn_up;
    input [Nbits*2-1:0] swIn_down;
    output [Nbits*2-1:0] swOut_up;
    output [Nbits*2-1:0] swOut_down;
    input ctrl;
            
       
       

    
     assign swOut_up = ctrl? swIn_up : swIn_down;
     assign swOut_down = ctrl? swIn_down : swIn_up;
    
    
    
    
    
    
endmodule
