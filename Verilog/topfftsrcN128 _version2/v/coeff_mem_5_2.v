`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2019 15:26:13
// Design Name: 
// Module Name: coeff_mem_1_1
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


module coeff_mem_5_2(
    input clk,
    input rst,
    output reg [11*2-1:0] coeff_out
    );

parameter SIZE = 32;    
reg [11*2-1:0] rom_memory [SIZE-1:0];
integer i;
initial begin
   $readmemb("coeff_data_5_2.mem", rom_memory);
    i = 0;
end    

always@(posedge clk) begin
if (rst) begin
coeff_out = 22'b00000000000000000000;
i = 0;
end else if (i < SIZE) begin
    coeff_out <= rom_memory[i];
    i = i+1;
end else i=0;

end

endmodule
