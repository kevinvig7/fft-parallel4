`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2019 15:46:47
// Design Name: 
// Module Name: contador
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

module contador_int
    #( parameter N=1)
     (output [1:0] num_ciclo,
      input clk,
      input rst);
    
    
reg [22:0] count;


always @(posedge clk) begin
 if (rst) begin
   count=N-1;
     end else if (count>=N-1) begin
      count=0;
      end
      else  begin
      count = count + 1;
      end
end
    

    
    assign num_ciclo =count ;
   






endmodule


    

    