`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.08.2019 16:41:35
// Design Name: 
// Module Name: topfft_tb
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


module topfft_tb();
    
parameter NBITS=10;
parameter NBITScoeff=NBITS+1;
parameter N=32;   
reg clk = 0;
reg rst;  
reg rst_tb;
 
 reg [NBITS*2-1:0] fftIn0_up;
 reg [NBITS*2-1:0] fftIn0_down;
 reg [NBITS*2-1:0] fftIn1_up;
 reg [NBITS*2-1:0] fftIn1_down;
 
wire [15*2-1:0] fftOut0_up;
wire [15*2-1:0] fftOut0_down;
wire [15*2-1:0] fftOut1_up;
wire [15*2-1:0] fftOut1_down;
    
       //-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;
        
topfft#(
.NBITS(NBITS),
.NBITScoeff(NBITScoeff))
  dut(
    .fftIn0_up(fftIn0_up),
    .fftIn0_down(fftIn0_down),
    .fftIn1_up(fftIn1_up),
    .fftIn1_down(fftIn1_down),
    .fftOut0_up(fftOut0_up),
    .fftOut0_down(fftOut0_down),
    .fftOut1_up(fftOut1_up),
    .fftOut1_down(fftOut1_down),
    .clk(clk),
    .rst(rst)
  );
    
integer data_in; // file handler
integer scan_in0; // file handler
integer scan_in1; // file handler
integer scan_in2; // file handler
integer scan_in3; // file handler

`define NULL 0

initial begin
    data_in = $fopen("Input128.dat","r");
     rst_tb  = 1'd1;
 #20 rst_tb  = 1'd0;
 
     if (data_in == `NULL) begin
        $display("data_file handle was NULL");
         $finish;
    end
 
end

always @(posedge clk) begin
   if(rst_tb) begin
      rst  = 1'd1;
  #20 rst  = 1'd0;
         end 
         else if(!$feof(data_in))  begin
             scan_in0 = $fscanf(data_in, "%b\n", fftIn0_up);
             scan_in1 = $fscanf(data_in, "%b\n", fftIn0_down);
             scan_in2 = $fscanf(data_in, "%b\n", fftIn1_up);
             scan_in3 = $fscanf(data_in, "%b\n", fftIn1_down);
             end
             else begin
             fftIn0_up  ={NBITS*2{1'bz}};
             fftIn0_down={NBITS*2{1'bz}};
             fftIn1_up  ={NBITS*2{1'bz}};
             fftIn1_down={NBITS*2{1'bz}};
              #25;
              $finish;
 end

   end


//if(!$feof(data_in)) 




endmodule
