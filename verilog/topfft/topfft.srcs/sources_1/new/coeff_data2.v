`timescale 1ns / 1ps
module coeff_data2
#(parameter NBITS=9,
  parameter N=8)
(output reg [NBITS*N*2-1:0] coeff_data);
initial begin
coeff_data2[143 : 126] = 18'b000000100000000000;
coeff_data2[125 : 108] = 18'b111111101111111101;
coeff_data2[107 : 90] = 18'b000000100000000000;
coeff_data2[89 : 72] = 18'b000000000111111100;
coeff_data2[71 : 54] = 18'b000000100000000000;
coeff_data2[53 : 36] = 18'b111111101111111101;
coeff_data2[35 : 18] = 18'b000000100000000000;
coeff_data2[17 : 0] = 18'b000000000111111100;
end 
endmodule 
