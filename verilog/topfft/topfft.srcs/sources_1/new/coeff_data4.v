`timescale 1ns / 1ps
module coeff_data4
#(parameter NBITS=9,
  parameter N=8)
(output reg [NBITS*N*2-1:0] coeff_data);
initial begin
coeff_data4[143 : 126] = 18'b000000100000000000;
coeff_data4[125 : 108] = 18'b000000100000000000;
coeff_data4[107 : 90] = 18'b000000100000000000;
coeff_data4[89 : 72] = 18'b000000100000000000;
coeff_data4[71 : 54] = 18'b111111100000000000;
coeff_data4[53 : 36] = 18'b000000000000000100;
coeff_data4[35 : 18] = 18'b111111101000000011;
coeff_data4[17 : 0] = 18'b000000011000000011;
end 
endmodule 
