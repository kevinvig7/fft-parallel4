`timescale 1ns / 1ps
module coeff_data2
#(parameter NBITS=9,
  parameter N=8)
(output reg [NBITS*N*2-1:0] coeff_data);
initial begin
coeff_data1(143 : 126) = 18' b =000000100000000000;
coeff_data1(125 : 108) = 18' b =111111101111111101;
coeff_data1(107 : 90) = 18' b =000000100000000000;
coeff_data1(89 : 72) = 18' b =000000000111111100;
coeff_data1(71 : 54) = 18' b =000000100000000000;
coeff_data1(53 : 36) = 18' b =111111101111111101;
coeff_data1(35 : 18) = 18' b =000000100000000000;
coeff_data1(17 : 0) = 18' b =000000000111111100;
end 
endmodule 
