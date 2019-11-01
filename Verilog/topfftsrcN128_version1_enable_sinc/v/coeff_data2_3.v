`timescale 1ns / 1ps
module coeff_data2_3
#(parameter NBITS=11,
  parameter N=32)
(output reg [NBITS*N*2-1:0] coeff_data);
initial begin
coeff_data[703 : 682] = 22'b0100000000000000000000;
coeff_data[681 : 660] = 22'b0011100001111100001110;
coeff_data[659 : 638] = 22'b0010001110011001010110;
coeff_data[637 : 616] = 22'b0000011001011000000010;
coeff_data[615 : 594] = 22'b1110011110011000100110;
coeff_data[593 : 572] = 22'b1100111010011010111011;
coeff_data[571 : 550] = 22'b1100000100111110011100;
coeff_data[549 : 528] = 22'b1100001011000010010100;
coeff_data[527 : 506] = 22'b0100000000000000000000;
coeff_data[505 : 484] = 22'b0011000101111010111011;
coeff_data[483 : 462] = 22'b0000110001111000001001;
coeff_data[461 : 440] = 22'b1110000111011000111100;
coeff_data[439 : 418] = 22'b1100010011011100111100;
coeff_data[417 : 396] = 22'b1100001011000010010100;
coeff_data[395 : 374] = 22'b1101110001100110101001;
coeff_data[373 : 352] = 22'b0000011001000111111101;
coeff_data[351 : 330] = 22'b0011111000011110000011;
coeff_data[329 : 308] = 22'b0010111101111010101000;
coeff_data[307 : 286] = 22'b0001010110011000011101;
coeff_data[285 : 264] = 22'b1111011010011000000101;
coeff_data[263 : 242] = 22'b1101100111111001100100;
coeff_data[241 : 220] = 22'b1100011000111100100101;
coeff_data[219 : 198] = 22'b1100000000000000011001;
coeff_data[197 : 176] = 22'b1100100100000100000111;
coeff_data[175 : 154] = 22'b0011110001011101010011;
coeff_data[153 : 132] = 22'b0010000011111001001000;
coeff_data[131 : 110] = 22'b1111011010011000000101;
coeff_data[109 : 88] = 22'b1101000010011010101000;
coeff_data[87 : 66] = 22'b1100000000011111100110;
coeff_data[65 : 44] = 22'b1100110010000100110000;
coeff_data[43 : 22] = 22'b1111000001100111110000;
coeff_data[21 : 0] = 22'b0001101101000111001110;
end 
endmodule 