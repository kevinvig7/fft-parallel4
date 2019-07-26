`timescale 1ns / 1ps
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
  
    input swIn_up,
    input swIn_down,
    output swOut_up,
    output swOut_down,
      input ctrl
    
    );
    
    wire conect0[0:1];
    wire conect1[0:1];
    

    
     assign swOut_up = ctrl? swIn_up : swIn_down;
     assign swOut_down = ctrl? swIn_down : swIn_up;
    
    
    
    
    
    
endmodule
