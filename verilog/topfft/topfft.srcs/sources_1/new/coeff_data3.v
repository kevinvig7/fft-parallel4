`timescale 1ns / 1ps
module coeff_data3
#(parameter NBITS=9,
  parameter N=8)
(output reg [NBITS*N*2-1:0] coeff_data);
initial begin
coeff_data3[143 : 126] = 18'b000000100000000000;
coeff_data3[125 : 108] = 18'b000000100000000000;
coeff_data3[107 : 90] = 18'b000000100000000000;
coeff_data3[89 : 72] = 18'b000000100000000000;
coeff_data3[71 : 54] = 18'b000000100000000000;
coeff_data3[53 : 36] = 18'b000000000111111100;
coeff_data3[35 : 18] = 18'b000000011111111101;
coeff_data3[17 : 0] = 18'b111111101111111101;
end 
endmodule 
