`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2019 11:33:27
// Design Name: 
// Module Name: tb_fixtop
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


module tb_fixtop_sat();



    
  parameter NBITS=12;
  parameter NBITScoeff=11;
 parameter NBITS_out=NBITS+NBITScoeff+1;

wire [NBITS_out*2-1:0] result;
reg  [NBITS*2-1:0] muestra;    
reg  [NBITScoeff*2-1:0] coeff;     
    
multip
#(NBITS,NBITScoeff)
as
 (.result(result),
  .muestra(muestra),
  .coeff(coeff));

 
initial begin
   
#10   
coeff = 22'b0011100110100111001101;
muestra=24'b000111001101000111001101;

    
    end
    
    
endmodule
