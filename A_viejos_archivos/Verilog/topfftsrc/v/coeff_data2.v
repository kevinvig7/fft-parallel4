`timescale 1ns / 1ps
module coeff_data2
#(parameter NBITS=11,
  parameter N=8)
(output reg [NBITS*N*2-1:0] coeff_data);
initial begin
coeff_data[175 : 154] = 22'b0100000000000000000000;
coeff_data[153 : 132] = 22'b1101001011011010010110;
coeff_data[131 : 110] = 22'b0100000000000000000000;
coeff_data[109 : 88] = 22'b0000000000011000000000;
coeff_data[87 : 66] = 22'b0100000000000000000000;
coeff_data[65 : 44] = 22'b1101001011011010010110;
coeff_data[43 : 22] = 22'b0100000000000000000000;
coeff_data[21 : 0] = 22'b0000000000011000000000;
end 
endmodule 
