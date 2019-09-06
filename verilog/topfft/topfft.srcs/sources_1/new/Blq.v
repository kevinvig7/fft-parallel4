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
    (output [(Nbits+1)*2-1:0] BlqOut_up,
     output [(Nbits+1)*2-1:0] BlqOut_down,
     input [Nbits*2-1:0] BlqIn_up,
     input  [Nbits*2-1:0] BlqIn_down,
     input clk,
     input rst,
     input ctrl);

    wire [Nbits*2-1:0] connect_blq_up[0:2];
    wire [Nbits*2-1:0] connect_blq_down[0:2];
    
    wire [(Nbits+1)*2-1:0] bf_to_blq_out_up ;
     wire [(Nbits+1)*2-1:0] bf_to_blq_out_down;
     
    assign connect_blq_up[0] = BlqIn_up;
    assign connect_blq_down[0] = BlqIn_down;
      
           
      
    assign BlqOut_up=bf_to_blq_out_up ;
    assign BlqOut_down=bf_to_blq_out_down ;
   
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
            (.BFOut_up(bf_to_blq_out_up ),
             .BFOut_down(bf_to_blq_out_down),
             .BFIn_up(connect_blq_up[2]),
             .BFIn_down(connect_blq_down[2]));


endmodule
