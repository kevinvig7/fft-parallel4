`timescale 1ns / 1ps
//`include "def.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.07.2019 14:32:39
// Design Name: 
// Module Name: topD
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


module topD_1
    #(parameter N = 4)
    (output Q,
    //input D,
     input clk,
     input rst);
    

    reg [22:0] count;


always @(posedge clk) begin
 if (rst) begin
 count = 23'b00000000000000000000000;
   end
    else  begin
   count = count + 1;
    end
end
    


assign Q = (count >= N) ? 1'b1 : 1'b0;
    

    
    
    
    
    
    
    
    
    
    
    
    
    
//    assign connect_wire[0] = D;
//    assign  Q = connect_wire[ND];
    
//   genvar i;
//   generate
//      for (i=0; i < ND; i=i+1) begin:
//      Dgen D_reg_1 nD(connect_wire[i+1],connect_wire[i],clk,rst);
//      end
//   endgenerate
    
endmodule


  
			

