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


module switch(
   swIn_up,
   swIn_down,
   swOut_up,
   swOut_down,
   ctrl,
   rst
    );
    
    parameter Nbits=2;
    
    input [Nbits*2-1:0] swIn_up;
    input [Nbits*2-1:0] swIn_down;
    output [Nbits*2-1:0] swOut_up;
    output [Nbits*2-1:0] swOut_down;
    input ctrl;
    input rst;
    
   reg [Nbits*2-1:0] out_up;
   reg [Nbits*2-1:0] out_down;
    
    assign swOut_up=out_up;
    assign swOut_down=out_down;        
       
       

     //assign out_up = ctrl? swIn_down : swIn_up;
     //assign out_down = ctrl? swIn_up : swIn_down;
    
    
always @(*) begin
if (rst) 
out_up<={Nbits*2{1'b0}};
else begin
   case (ctrl)
     0 : out_up <= swIn_up;
     1 : out_up <= swIn_down;
     default : out_up ={Nbits*2{1'b0}};
  endcase
  end
end 
  
  
always @(*) begin
if (rst)
out_down<={Nbits*2{1'b0}};
else begin
  case (ctrl)
     0 : out_down  <=swIn_down;
     1 : out_down  <= swIn_up ;
     default : out_down  <={Nbits*2{1'b0}};
  endcase
  end
end
    
    
    
    
    
    
    
    
endmodule
