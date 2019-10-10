`timescale 1ns / 1ps
`include "def.v"
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


module BFj(
    BFIn_up,
    BFIn_down,
    BFOut_up,
    BFOut_down,
    );
    
    parameter Nbits = `Nbitsg;
    
    input [Nbits*2-1:0] BFIn_up;
    input  [Nbits*2-1:0] BFIn_down;
    output [Nbits*2-1:0] BFOut_up;
    output [Nbits*2-1:0] BFOut_down;
    
    
    //Separacion parte real e imaginaria 
    wire [Nbits-1:0] q_up [0:1];
    wire [Nbits-1:0] q_down [0:1];
    
    wire [Nbits-1:0] sumOut_up [0:1];    //Salida de sumador
    wire [Nbits-1:0] sumOut_down [0:1]; //Salida de sumador
    
    
assign q_up[0] = BFIn_up[Nbits*2-1:Nbits]; //Real
assign q_up[1] = BFIn_up[Nbits-1:0];        //Img
  
assign q_down[0] =  BFIn_down[Nbits*2-1:Nbits]; //Real
assign q_down[1] =  BFIn_down[Nbits-1:0];       //Img


//conectar los wire de salida del sumador  --- Orden diferente con respecto al anterior

assign sumOut_up[0] = q_up[0] + q_down[1];
assign sumOut_up[1] = q_up[1] + q_down[0];

assign sumOut_down[0] = q_up[0] - q_down[1];
assign sumOut_down[1] = q_up[1] - q_down[0];  
    
   
    assign BFOut_up = {sumOut_down[0],sumOut_up[1]};    
    assign BFOut_down = {sumOut_up[0],sumOut_down[1]}; 

    

      
    
    
endmodule
