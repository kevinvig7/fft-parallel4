`timescale 1ns / 1ps
//`include "def.v"
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


module switch
    #(parameter Nbits=2)
    (output reg [Nbits*2-1:0] swOut_up,
     output reg [Nbits*2-1:0] swOut_down,
     input [Nbits*2-1:0] swIn_up,
     input [Nbits*2-1:0] swIn_down,
     input ctrl,
     input rst);

    
always @(*) begin
if (rst) 
swOut_up ={Nbits*2{1'b0}};
else begin
   case (ctrl)
     0 : swOut_up = swIn_up;
     1 : swOut_up = swIn_down;
     default : swOut_up ={Nbits*2{1'b0}};
  endcase
  end
end 
  
  
always @(*) begin
if (rst)
swOut_down ={Nbits*2{1'b0}};
else begin
  case (ctrl)
     0 : swOut_down  =swIn_down;
     1 : swOut_down  = swIn_up ;
     default : swOut_down ={Nbits*2{1'b0}};
  endcase
  end
end
    
    
    
    
    
    
    
    
endmodule
