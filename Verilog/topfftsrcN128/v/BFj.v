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


module BFj
    #(parameter NBITS = 10 )
    (output reg [(NBITS+1)*2-1:0]   BFOut_up,
     output reg [(NBITS+1)*2-1:0] BFOut_down,
     input  [NBITS*2-1:0]        BFIn_up,
     input  [NBITS*2-1:0]      BFIn_down,
     input  twd,
     input rst,
     input clk);
    
    
    //Separacion parte real e imaginaria 
wire [NBITS-1:0]   q_up_r ;
wire [NBITS-1:0]   q_up_i ;


wire  [NBITS-1:0] q_down_r;
wire [NBITS-1:0] q_down_i;
    
wire signed [NBITS+1-1:0]   sumOut_up_r; //Salida de sumador
wire signed [NBITS+1-1:0]   sumOut_up_i; //Salida de sumador
reg signed [NBITS+1-1:0] sumOut_down_r; //Salida de sumador
reg signed [NBITS+1-1:0] sumOut_down_i; //Salida de sumador   

wire signed [NBITS+1-1:0] aux_subs_r;
wire signed [NBITS+1-1:0] aux_subs_i;
wire signed [NBITS+1-1:0] aux_subs_ri;


    
assign q_up_r   = BFIn_up[NBITS*2-1:NBITS]; //Real
assign q_up_i   = BFIn_up[NBITS-1:0];       //Img
  
assign q_down_r = BFIn_down[NBITS*2-1:NBITS]; //Real
assign q_down_i = BFIn_down[NBITS-1:0]; //Img

//conectar los wire de salida del sumador 



assign sumOut_up_r = $signed(q_up_r) + $signed(q_down_r);
assign sumOut_up_i = $signed(q_up_i) + $signed(q_down_i);

assign aux_subs_r =  $signed(q_up_r) - $signed(q_down_r);
assign aux_subs_i =  $signed(q_up_i) - $signed(q_down_i);  

assign aux_subs_ri = $signed(q_down_r) - $signed(q_up_r);  

always @(*) begin
if (twd) begin
sumOut_down_r =  aux_subs_r; 
sumOut_down_i =  aux_subs_i;  
end else begin
sumOut_down_r =  aux_subs_i; 
sumOut_down_i =  aux_subs_ri;  
end
end



//assign BFOut_up   =     {sumOut_up_r,sumOut_up_i};    

//assign BFOut_down = {sumOut_down_r,sumOut_down_i}; 

      
 always @(posedge clk) begin
 if (rst) begin
BFOut_up   = {(NBITS+1)*2{1'b0}};    
BFOut_down = {(NBITS+1)*2{1'b0}}; 
 end else begin
BFOut_up   =     {sumOut_up_r,sumOut_up_i};    
BFOut_down = {sumOut_down_r,sumOut_down_i}; 

end 
end
    
    
    
    
    
    
    
endmodule

