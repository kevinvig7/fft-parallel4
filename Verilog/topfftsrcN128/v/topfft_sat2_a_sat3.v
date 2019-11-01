`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2019 16:33:19
// Design Name: 
// Module Name: topfftt_sat2_a_sat3
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


module topfft_sat2_a_sat3
     #(parameter NBITS = 21,
       parameter NBITScoeff=NBITS+1,
       parameter NBITS_out=10,
       parameter N = 32) // Cantidad de coeficientes en los multiplicadores
     (
      output reg [NBITS_out*2-1:0] fftOut0_up,
      output reg [NBITS_out*2-1:0] fftOut0_down,
      output reg [NBITS_out*2-1:0] fftOut1_up,
      output reg [NBITS_out*2-1:0] fftOut1_down,
      
      input  [NBITS*2-1:0] fftIn0_up,
      input  [NBITS*2-1:0] fftIn0_down,
      input  [NBITS*2-1:0] fftIn1_up,
      input  [NBITS*2-1:0] fftIn1_down,
      input in_enable,
      input clk,
      input rst);




wire coeffCMStage7_en;
wire ctrl_Blq_BFVII;


wire [21*2-1:0] sat2_a_blqVII_0_up;
wire [21*2-1:0] sat2_a_blqVII_0_down;
wire [21*2-1:0] sat2_a_blqVII_1_up;
wire [21*2-1:0] sat2_a_blqVII_1_down;

wire [22*2-1:0] blqVII_0_a_sat3_up;
wire [22*2-1:0] blqVII_0_a_sat3_down;
wire [22*2-1:0] blqVII_1_a_sat3_up;
wire [22*2-1:0] blqVII_1_a_sat3_down;


wire [10*2-1:0] sat3out_0_up;
wire [10*2-1:0] sat3out_0_down;
wire [10*2-1:0] sat3out_1_up;
wire [10*2-1:0] sat3out_1_down;



//////////////////////
assign sat2_a_blqVII_0_up   = fftIn0_up;
assign sat2_a_blqVII_0_down = fftIn0_down;
assign sat2_a_blqVII_1_up   = fftIn1_up;
assign sat2_a_blqVII_1_down = fftIn1_down;



 topD_1
 #(18)
    EnableCM_stage7
    (.Q(coeffCMStage7_en),
    .clk(clk),
    .rst(!in_enable));
   
///Control sw
contador
 #(16) 
   control_Blq_BFVII_0
        (.clk_out(ctrl_Blq_BFVII),
         .clk(clk),
         .rst(!coeffCMStage7_en));  
   
//Blq V 0    
   Blq
#(16,16,21)
     Blq_BFVII_0
      (.BlqOut_up      (blqVII_0_a_sat3_up),
       .BlqOut_down  (blqVII_0_a_sat3_down),
       .BlqIn_up       (sat2_a_blqVII_0_up),
       .BlqIn_down   (sat2_a_blqVII_0_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFVII)); 

//Blq V 1         
Blq
#(16,16,21)
     Blq_BFV_1
      (.BlqOut_up      (blqVII_1_a_sat3_up),
       .BlqOut_down  (blqVII_1_a_sat3_down),
       .BlqIn_up       (sat2_a_blqVII_1_up),
       .BlqIn_down   (sat2_a_blqVII_1_down),
       .clk(clk),
       .rst(rst),
       .ctrl(ctrl_Blq_BFVII)); 




///////////Saturador Sat3
       
    fixtop_sat
       #(.NBITS_IN(22),
          .NBI_IN(7),
          .NBF_IN(15),
          .NBITS_OUT(10),
          .NBI_OUT(6),
          .NBF_OUT(4))
        sat1_out0_up
         (.sat_out(sat3out_0_up),
          .sat_in(blqVII_0_a_sat3_up)); 
       
       
       
       fixtop_sat
        #(.NBITS_IN(22),
          .NBI_IN(7),
          .NBF_IN(15),
          .NBITS_OUT(10),
          .NBI_OUT(6),
          .NBF_OUT(4))
        sat1_out0_down
         (.sat_out(sat3out_0_down),
          .sat_in(blqVII_0_a_sat3_down)); 
   
     fixtop_sat
       #(.NBITS_IN(22),
          .NBI_IN(7),
          .NBF_IN(15),
          .NBITS_OUT(10),
          .NBI_OUT(6),
          .NBF_OUT(4))
        sat1_out1_up
         (.sat_out(sat3out_1_up),
          .sat_in(blqVII_1_a_sat3_up)); 
          
            fixtop_sat
       #(.NBITS_IN(22),
          .NBI_IN(7),
          .NBF_IN(15),
          .NBITS_OUT(10),
          .NBI_OUT(6),
          .NBF_OUT(4))
        sat1_out1_down
         (.sat_out(sat3out_1_down),
          .sat_in(blqVII_1_a_sat3_down)); 
   
    
    
    
always@ (posedge clk) begin             
 if (rst) begin      
 fftOut0_up   = {NBITS_out*2{1'b0}};    
 fftOut0_down = {NBITS_out*2{1'b0}};      
 fftOut1_up   = {NBITS_out*2{1'b0}};       
 fftOut1_down = {NBITS_out*2{1'b0}};       
      end else begin
 fftOut0_up   =  sat3out_0_up;
 fftOut0_down = sat3out_0_down;
 fftOut1_up   =   sat3out_1_up;
 fftOut1_down = sat3out_1_down;
         end
  end  
    








endmodule
