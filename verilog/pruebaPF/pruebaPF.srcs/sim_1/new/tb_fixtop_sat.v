`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2019 11:33:27
// Design Name: 
// Module Name: tb_fixtop
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


module tb_fixtop_sat();
    
  parameter NBITS=8;
  parameter NBITS_OUT=4;
 // parameter  NB_FFE_OUT=2;
 // parameter  NBI_FFE_OUT=2;
    
    reg signed [NBITS*2-1:0] sum;
    wire signed [NBITS_OUT*2-1:0] salida;
    
    
  /*  fixtop
         dut
         ( .out_sum(sum),
           .sum_sat(salida)
         ); */
         
         
       fixtop_sat
          #(.NBITS_IN(NBITS),
           .NBITS_OUT(NBITS_OUT))
        dut
          (.sat_in(sum),
           .sat_out(salida));
           
           
         
         
  
    initial begin
    #10 sum=8'b1111011111110111; 
    #10 sum=8'b1111100011110111; 
    #10 sum=8'b1111100111110111; 
    #10 sum=8'b1111101011110111;
    #10 sum=8'b1111101111110111;
    #10 sum=8'b1111110011110111;
    #10 sum=8'b1111110111110111;
    #10 sum=8'b1111111011110111;
    #10 sum=8'b1111111111110111;
    
    #10 sum=8'b0000000011110111;
    #10 sum=8'b0000000111110111;
    #10 sum=8'b0000001011110111;
    #10 sum=8'b0000001111110111;
    #10 sum=8'b0000010011110111;
    #10 sum=8'b0000010111110111;
    #10 sum=8'b0000011011110111;
    #10 sum=8'b0000011111110111;
    #10 sum=8'b0000011111110111;
    #10 sum=8'b0000100011110111;
    
    
    end
    
       
    
endmodule
