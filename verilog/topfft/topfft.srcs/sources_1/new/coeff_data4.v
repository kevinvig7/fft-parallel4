`timescale 1ns / 1ps
module coeff_data4
#(parameter NBITS=3,
  parameter N=8)
(output reg [NBITS*N*2-1:0] coeff_data);
initial begin
coeff_data[47 : 42] = 6'b011000;
coeff_data[41 : 36] = 6'b011000;
coeff_data[35 : 30] = 6'b011000;
coeff_data[29 : 24] = 6'b011000;
coeff_data[23 : 18] = 6'b100000;
coeff_data[17 : 12] = 6'b000011;
coeff_data[11 : 6] = 6'b101011;
coeff_data[5 : 0] = 6'b011011;
end 
endmodule 
