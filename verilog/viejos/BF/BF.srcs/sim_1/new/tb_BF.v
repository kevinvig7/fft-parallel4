`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2019 17:13:39
// Design Name: 
// Module Name: tb_BF
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


module tb_BF( );

parameter NBITS=11;

    wire [(NBITS+1)*2-1:0]   BFOut_up;
     wire [(NBITS+1)*2-1:0] BFOut_down;
    reg  [NBITS*2-1:0]        BFIn_up;
     reg  [NBITS*2-1:0]      BFIn_down;




BF#(11)
Butterfly
    (.BFOut_up(BFOut_up),
     . BFOut_down(BFOut_down),
     .BFIn_up(BFIn_up),
     .BFIn_down(BFIn_down));
     
     
     initial begin
    #10; 
     BFIn_up = 22'b0100000000011000000000;
     BFIn_down =22'b0100000000011000000000;
     
     end
     
     
     
     
     
     
     
 endmodule