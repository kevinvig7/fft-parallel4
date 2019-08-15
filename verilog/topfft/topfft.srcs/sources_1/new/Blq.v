`timescale 1ns / 1ps
//`include "def.v"
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


module Blq
    #(parameter ND0 = 4,
      parameter ND1 = 4,
      parameter Nbits = 2)
    (output [Nbits*2-1:0] BlqOut_up,
     output [Nbits*2-1:0] BlqOut_down,
     input [Nbits*2-1:0] BlqIn_up,
     input  [Nbits*2-1:0] BlqIn_down,
     input clk,
     input rst,
     input ctrl);

    wire [Nbits*2-1:0] connect_blq_up[0:3];
    wire [Nbits*2-1:0] connect_blq_down[0:3];
    
    assign connect_blq_up[0] = BlqIn_up;
    assign connect_blq_down[0] = BlqIn_down;
      
    assign BlqOut_up=connect_blq_up[3] ;
    assign BlqOut_down=connect_blq_down[3] ;
   
   topD#(ND0,Nbits)
         DA
          (.Q(connect_blq_down[1]),
           .D(connect_blq_down[0]),
           .clk(clk),
           .rst(rst));
  
   switch#(Nbits) 
        sw
        (.swOut_up(connect_blq_up[1]),
         .swOut_down(connect_blq_down[2]),
         .swIn_up(connect_blq_up[0]),
         .swIn_down(connect_blq_down[1]),
         .ctrl(ctrl),
         .rst(rst));

   topD#(ND1,Nbits) 
            DB
          (.Q(connect_blq_up[2]),
           .D(connect_blq_up[1]),
           .clk(clk), 
           .rst(rst));

   BF#(Nbits) 
        Butterfly
            (.BFOut_up(connect_blq_up[3]),
             .BFOut_down(connect_blq_down[3]),
             .BFIn_up(connect_blq_up[2]),
             .BFIn_down(connect_blq_down[2]));


endmodule
