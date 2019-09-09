`timescale 1ns / 1ps
module coeff_data1
#(parameter NBITS=5,
  parameter N=8)
(output reg [NBITS*N*2-1:0] coeff_data);
initial begin
coeff_data[79 : 70] = 10'b0010000000;
coeff_data[69 : 60] = 10'b1110111101;
coeff_data[59 : 50] = 10'b0010000000;
coeff_data[49 : 40] = 10'b0000011100;
coeff_data[39 : 30] = 10'b0010000000;
coeff_data[29 : 20] = 10'b1110111101;
coeff_data[19 : 10] = 10'b0010000000;
coeff_data[9 : 0] = 10'b0000011100;
end 
endmodule 

