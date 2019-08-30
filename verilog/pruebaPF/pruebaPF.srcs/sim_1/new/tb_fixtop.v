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


module tb_fixtop();
    
  parameter NBITS=8;
  parameter NBITS_OUT=4;
 // parameter  NB_FFE_OUT=2;
 // parameter  NBI_FFE_OUT=2;
    
    reg signed [NBITS-1:0] sum;
    wire signed [NBITS_OUT-1:0] salida;
    
    
  /*  fixtop
         dut
         ( .out_sum(sum),
           .sum_sat(salida)
         ); */
         
         
       sat
          #(.NBITS_IN(NBITS),
           .NBITS_OUT(NBITS_OUT))
        dut
          (.sat_in(sum),
           .sat_out(salida));
           
         
         
  
    initial begin
    #10 sum=8'b11111000; 
    #10 sum=8'b0001001; 
    #10 sum=8'b0001010;
    #10 sum=8'b0001011;
    #10 sum=8'b0001100;
    #10 sum=8'b0001101;
    #10 sum=8'b0001110;
    #10 sum=8'b0001111;
    
    #10 sum=8'b0000000;
    #10 sum=8'b0000001;
    #10 sum=8'b0000010;
    #10 sum=8'b0000011;
    #10 sum=8'b0000100;
    #10 sum=8'b0000101;
    #10 sum=8'b0000110;
    #10 sum=8'b0000111;
   
    
    
    end
    
       
    
endmodule
