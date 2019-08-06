`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2019 16:50:35
// Design Name: 
// Module Name: coeff_data
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


module coeff_data1(
 coeff_data
    );
    
parameter Nbits=2;
parameter N=8;
output reg [Nbits*N*2-1:0] coeff_data;

initial begin
coeff_data[31:28] <=4'b0000; 
coeff_data [27:24]<=4'b0001;  
coeff_data[23:20] <=4'b0010; 
coeff_data[19:16] <=4'b0011;  
coeff_data[15:12] <= 4'b0100; 
coeff_data[11:8] <= 4'b0101; 
coeff_data[7:4]<= 4'b0110; 
coeff_data[3:0] <= 4'b0111; 
end 
endmodule


















