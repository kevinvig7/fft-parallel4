`timescale 1ns / 1ps
//`include "def.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2019 14:35:16
// Design Name: 
// Module Name: BF
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


module BF
    #(parameter NBITS = 10)
    (output [(NBITS+1)*2-1:0]   BFOut_up,
     output [(NBITS+1)*2-1:0] BFOut_down,
     input  [NBITS*2-1:0]        BFIn_up,
     input  [NBITS*2-1:0]      BFIn_down);
    
    
    //Separacion parte real e imaginaria 
wire signed [NBITS-1:0]   q_up_r ;
wire signed [NBITS-1:0]   q_up_i ;

wire signed [NBITS-1:0] q_down_r;
wire signed [NBITS-1:0] q_down_i;
    
wire signed [NBITS+1-1:0]   sumOut_up_r; //Salida de sumador
wire signed [NBITS+1-1:0]   sumOut_up_i; //Salida de sumador

wire signed [NBITS+1-1:0] sumOut_down_r; //Salida de sumador
wire signed [NBITS+1-1:0] sumOut_down_i; //Salida de sumador   
    
assign q_up_r   = $signed(BFIn_up[NBITS*2-1:NBITS]); //Real
assign q_up_i   = $signed(BFIn_up[NBITS-1:0]);       //Img
  
assign q_down_r = $signed(BFIn_down[NBITS*2-1:NBITS]); //Real
assign q_down_i = $signed(BFIn_down[NBITS-1:0]); //Img


//conectar los wire de salida del sumador 

assign sumOut_up_r = q_up_r + q_down_r;
assign sumOut_up_i = q_up_i + q_down_i;

assign sumOut_down_r = q_up_r - q_down_r;
assign sumOut_down_i = q_up_i - q_down_i;  

//assign sumOut_downAlter[0] =   q_up[1] - q_down[0];
//assign sumOut_downAlter[1] =   q_down[0] - q_up[0];    
   
      
assign BFOut_up   =     {sumOut_up_r,sumOut_up_i};    
assign BFOut_down = {sumOut_down_r,sumOut_down_i}; 
      
    
    
endmodule
