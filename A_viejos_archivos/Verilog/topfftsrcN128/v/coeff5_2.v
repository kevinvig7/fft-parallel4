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



module coeff5_2
    #(parameter NBITS=11, 
      parameter N=32)
    (output reg [NBITS*2-1:0] coeff_out,
     input clk,
     input rst);

reg [22:0] index;

wire [NBITS*N*2-1:0] coeff;

coeff_data5_2
   coefficientes
        (.coeff_data(coeff));

//initial begin
//index=0;
//end

always @(posedge clk) begin
        if (rst) begin 
            coeff_out = {NBITS*2{1'b0}}; 
            index=0;
            end
        else if (index>=(N)) begin
                index=0;
                coeff_out =coeff[N*NBITS*2-1-:NBITS*2];
            end
        else begin
        coeff_out=coeff[N*NBITS*2-1-index*NBITS*2-:NBITS*2];
        index = index + 1;
            end
       end




endmodule
