`timescale 1ns / 1ps
module coeff_data5_2
#(parameter NBITS=11,
  parameter N=32)
(output reg [NBITS*N*2-1:0] coeff_data);
initial begin
coeff_data[703 : 682] = 22'b0100000000000000000000;
coeff_data[681 : 660] = 22'b0100000000000000000000;
coeff_data[659 : 638] = 22'b0100000000000000000000;
coeff_data[637 : 616] = 22'b0100000000000000000000;
coeff_data[615 : 594] = 22'b0100000000000000000000;
coeff_data[593 : 572] = 22'b0100000000000000000000;
coeff_data[571 : 550] = 22'b0100000000000000000000;
coeff_data[549 : 528] = 22'b0100000000000000000000;
coeff_data[527 : 506] = 22'b0100000000000000000000;
coeff_data[505 : 484] = 22'b0100000000000000000000;
coeff_data[483 : 462] = 22'b0100000000000000000000;
coeff_data[461 : 440] = 22'b0100000000000000000000;
coeff_data[439 : 418] = 22'b0100000000000000000000;
coeff_data[417 : 396] = 22'b0100000000000000000000;
coeff_data[395 : 374] = 22'b0100000000000000000000;
coeff_data[373 : 352] = 22'b0100000000000000000000;
coeff_data[351 : 330] = 22'b0100000000000000000000;
coeff_data[329 : 308] = 22'b0010110101011010010101;
coeff_data[307 : 286] = 22'b0011101100111100111100;
coeff_data[285 : 264] = 22'b0001100001111000100110;
coeff_data[263 : 242] = 22'b0100000000000000000000;
coeff_data[241 : 220] = 22'b0010110101011010010101;
coeff_data[219 : 198] = 22'b0011101100111100111100;
coeff_data[197 : 176] = 22'b0001100001111000100110;
coeff_data[175 : 154] = 22'b0100000000000000000000;
coeff_data[153 : 132] = 22'b0010110101011010010101;
coeff_data[131 : 110] = 22'b0011101100111100111100;
coeff_data[109 : 88] = 22'b0001100001111000100110;
coeff_data[87 : 66] = 22'b0100000000000000000000;
coeff_data[65 : 44] = 22'b0010110101011010010101;
coeff_data[43 : 22] = 22'b0011101100111100111100;
coeff_data[21 : 0] = 22'b0001100001111000100110;
end 
endmodule 
