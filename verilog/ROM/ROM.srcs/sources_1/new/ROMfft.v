`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2019 13:59:46
// Design Name: 
// Module Name: ROMfft
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


module ROMfft(
        coeff_out,
        adress_in,
        enable,
        clk,
        rst        
   );
        
   parameter ROM_WIDTH = 16;

   output reg [ROM_WIDTH*2-1:0] coeff_out ;
   input [3:0] adress_in;
   input clk;
   input enable;
   input rst;
   
   always @(posedge clk) begin
   if (rst) begin
   coeff_out <= 32'h0;
   end
      else if (enable) begin
         case (adress_in)
/*0*/       4'b0000: coeff_out <= {16'h1,16'h0}; // %1 + 0i;
/*1*/       4'b0001: coeff_out <= {16'h0,16'h1}; // %0 + 1i;
/*2*/       4'b0010: coeff_out <= {16'h1,16'h3}; // %0 - 1i;
/*3*/       4'b0011: coeff_out <= {16'h1,16'h4}; //w1 = (exp(-j*2*pi/N))^1; %  0.9239 - 0.3827i
/*4*/       4'b0100: coeff_out <= {16'h1,16'h5}; //w2 = (exp(-j*2*pi/N))^2; %  0.7071 - 0.7071i
/*5*/       4'b0101: coeff_out <= {16'h1,16'h6}; //w3 = (exp(-j*2*pi/N))^3; %  0.3827 - 0.9239i
/*6*/       4'b0110: coeff_out <= {16'h1,16'h7}; //w4 = (exp(-j*2*pi/N))^4; % -0.0000 - 1.0000i
/*7*/       4'b0111: coeff_out <= {16'h1,16'h8}; //w5 = (exp(-j*2*pi/N))^5; % -0.3827 - 0.9239i
/*8*/       4'b1000: coeff_out <= {16'h1,16'h9}; //w6 = (exp(-j*2*pi/N))^6; % -0.7071 - 0.7071i
/*9*/       4'b1001: coeff_out <= {16'h1,16'h10}; //w7 = (exp(-j*2*pi/N))^7; % -0.9239 - 0.3827i
/*10*/       4'b1010: coeff_out <= {16'h1,16'h11};//wn8  = exp(-j*pi/4);    %  0.7071 - 0.7071i
/*11*/       4'b1011: coeff_out <= {16'h1,16'h12}; //w3n8 = exp(-j*pi/4)*-j; % -0.7071 - 0.7071i
   //        4'b1100: coeff_out <= {16'h1,16'h13};
    //        4'b1101: coeff_out <= {16'h1,16'h14};
    //        4'b1110: coeff_out <= {16'h1,16'h15};
    //        4'b1111: coeff_out <= {16'h1,16'h16};
            default: coeff_out <= 32'h0;
         endcase 
         end
   end
endmodule



// 0  0   2  2  0  0  2  2
// 0  10  0  0  0  10 0  0
// 0  11  0  2  0  11 0  2
// 0  0   0  0  0  4  3  5
// 0  0   0  0  6  8  7  9


