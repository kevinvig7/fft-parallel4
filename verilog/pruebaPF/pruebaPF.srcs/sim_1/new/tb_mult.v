`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2019 12:06:07
// Design Name: 
// Module Name: tb_mult
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


module tb_mult(

    );
    
  parameter NBITS=8;
  parameter NBITSI=6;
  parameter NBITSF=2;
 // parameter  NB_FFE_OUT=2;
 // parameter  NBI_FFE_OUT=2;
    
    reg signed [NBITS-1:0] mult_inA;
    reg signed [NBITS-1:0] mult_inB;
    wire signed [(NBITS+1)-1:0] mult_out;
    
        
         
       mult
          #(.NBITS(NBITS),
            .NBITSI(NBITSI),
            .NBITSF(NBITSF))
        dut
          (.mult_out(mult_out),
           .mult_inA(mult_inA),
           .mult_inB(mult_inB));
           
           
           
           
         
         
  
    initial begin
    #10 
    mult_inA=8'b11111000; 
    mult_inB=8'b11111000; 
      
    end
    
    
    
    
    
endmodule
