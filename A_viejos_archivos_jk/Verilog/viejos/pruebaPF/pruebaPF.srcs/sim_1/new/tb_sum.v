`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2019 10:43:45
// Design Name: 
// Module Name: tb_sum
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


module tb_sum(

    );
   
  parameter NBITS=8;
  parameter NBITSI=6;
  parameter NBITSF=2;
 // parameter  NB_FFE_OUT=2;
 // parameter  NBI_FFE_OUT=2;
    
    reg signed [NBITS-1:0] sum_inA;
    reg signed [NBITS-1:0] sum_inB;
    wire signed [(NBITS+1)-1:0] sum_out;
    
        
         
       sum
          #(.NBITS(NBITS),
            .NBITSI(NBITSI),
            .NBITSF(NBITSF))
        dut
          (.sum_out(sum_out),
           .sum_inA(sum_inA),
           .sum_inB(sum_inB));
           
           
           
           
         
         
  
    initial begin
    #10 
    sum_inA=8'b00001000; 
    sum_inB=8'b11111000; 
    
   
    
    end
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
