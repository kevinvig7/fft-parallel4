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
    
  parameter NBITS=4;
  parameter NBITS_OUT=3;
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
    #10 sum=4'b1000; 
    #10 sum=4'b1001; 
    #10 sum=4'b1010;
    #10 sum=4'b1011;
    #10 sum=4'b1100;
    #10 sum=4'b1101;
    #10 sum=4'b1110;
    #10 sum=4'b1111;
    
    #10 sum=4'b0000;
    #10 sum=4'b0001;
    #10 sum=4'b0010;
    #10 sum=4'b0011;
    #10 sum=4'b0100;
    #10 sum=4'b0101;
    #10 sum=4'b0110;
    #10 sum=4'b0111;
   
    
    
    end
    
       
    
endmodule
