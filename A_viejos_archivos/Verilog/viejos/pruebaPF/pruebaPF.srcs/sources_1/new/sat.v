/////////////////////////////////////////////////////////////////////////////////
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
#(parameter NBITS_IN =8,
 parameter NBI_IN =1,
 parameter NBF_IN =7 ,
  parameter NBITS_OUT =6,
  parameter NBI_OUT =1,
  parameter NBF_OUT=5  )
 (output reg [NBITS_OUT-1:0] sat_out,
  input  [NBITS_IN-1:0] sat_in);
  
always @(*) begin
if(|sat_in[NBITS_IN-2:NBI_IN+NBITS_OUT-1]==1'b1 && sat_in[NBITS_IN-1]==1'b0)
	sat_out = {2'b01,{NBITS_OUT-2{1'b1}}};
else if (&sat_in[NBITS_IN-2:NBI_IN+NBITS_OUT-1]==1'b0 && sat_in[NBITS_IN-1]==1'b1)
	sat_out = {2'b01,{NBITS_OUT-2{1'b0}}};
else
	sat_out = sat_in[NBF_IN+NBI_OUT-1 -: NBITS_OUT]; 
end
    


    
endmodule







