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

module contador(
input clk_in,
input rst,
output reg clk_out
);
    
parameter N=1;

reg [22:0] count;

always @(posedge clk_in) begin
 if (rst) begin
     count=N-1;
     clk_out=1;
     end
  else if (clk_in) begin
  if (count==(N-1)) begin
      clk_out=~clk_out;
      count=0;
      end
  else  begin
    count = count + 1;
        end
    end
    
end

endmodule


    
//parameter frec_in=50_000_000;
//parameter freq_out=1_000_000;
//parameter max_count=frec_in/(2*freq_out);

//reg [22:0] count;

//initial begin
//count =0;
//clk_out=0;
//end

//always @(posedge clk_in) begin
//  if (count==(max_count)) begin
//      clk_out=~clk_out;
//      count=0;
//      end
//  else  begin
//    count = count + 1;
//        end
    
    
//end
    

    