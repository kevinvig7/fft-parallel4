`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2019 15:59:05
// Design Name: 
// Module Name: coeff
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


module coeff0(
coeff_out,
clk,
rst
    );
    
parameter Nbits=2; 
parameter N=8;
input rst;
input clk;
output reg [Nbits*2-1:0] coeff_out;

reg [22:0] index;

wire [Nbits*N*2-1:0] coeff;

coeff_data0 coefficientes(coeff);

initial begin
index=0;
end

always @(posedge clk) begin
        if (rst) begin 
            coeff_out = {Nbits*2{1'b0}}; 
            index<=0;
            end
        else if (clk) begin 
             if (index==(N)) begin
                index<=0;
                coeff_out <=coeff[N*Nbits*2-1-:4];
            end
        else begin
        coeff_out <=coeff[N*Nbits*2-1-index*Nbits*2-:4];
        index = index + 1;
            end
       end
end




endmodule
