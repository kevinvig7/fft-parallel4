`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2019 14:17:19
// Design Name: 
// Module Name: sat
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



module sat
#(parameter NBITS_IN =21,
  parameter NBITS_OUT =20)
 (output reg [NBITS_OUT-1:0] sat_out,
  input signed [NBITS_IN-1:0] sat_in);
  
  wire signed [NBITS_OUT-1:0] max_pos={1'b0,{(NBITS_OUT-1){1'b1}}}; //max positive number
  wire signed [NBITS_OUT-1:0] max_neg={1'b1,{(NBITS_OUT-1){1'b0}}}; //max negative number
 // reg signed [NBITS_IN+1-1:0] redondeo; 
    
    always @(*) 
    begin
    if ((sat_in[NBITS_IN-1:NBITS_OUT-1]=={NBITS_IN-NBITS_OUT+1{1'b0}}) ||
        (sat_in[NBITS_IN-1:NBITS_OUT-1]=={NBITS_IN-NBITS_OUT+1{1'b1}}))
    begin 
   //  redondeo <=  sat_in + 1;// $signed({1'b0,1});
     sat_out <= sat_in[NBITS_OUT-1:0];   
   //    sat_out <= $signed(redondeo[NBITS_OUT-1:0]);    
    end
    else if (sat_in[NBITS_IN-1]) // neg underflow . Go to max neg   
         sat_out <= max_neg;
         else
         sat_out <= max_pos;     // pos overflow . Go to max pos  
     end 
          
    
endmodule











