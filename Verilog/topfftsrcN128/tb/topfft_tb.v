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


`define NULL 0
    //Para escaneo de entrada obtenia de Matlab
integer data_in; // file handler
integer scan_in0; // file handler
integer scan_in1; // file handler
integer scan_in2; // file handler
integer scan_in3; // file handler

    //Para escaneo de archivo de salida de Matlab
integer data_out; // file handler
integer scan_out0; // file handler
integer scan_out1; // file handler
integer scan_out2; // file handler
integer scan_out3; // file handler

  
    
    
parameter NBITS=10;
parameter NBITScoeff=NBITS+1;
parameter NBITS_out = 15;
parameter N=32;   


reg clk = 0;
reg rst;  
reg rst_tb;
reg rst_file;
 
reg [NBITS*2-1:0] fftIn0_up;
reg [NBITS*2-1:0] fftIn0_down;
reg [NBITS*2-1:0] fftIn1_up;
reg [NBITS*2-1:0] fftIn1_down;
 
wire [NBITS_out*2-1:0] fftOut0_up;
wire [NBITS_out*2-1:0] fftOut0_down;
wire [NBITS_out*2-1:0] fftOut1_up;
wire [NBITS_out*2-1:0] fftOut1_down;

reg [NBITS_out*2-1:0] file_fftOut0_up;
reg [NBITS_out*2-1:0] file_fftOut0_down;
reg [NBITS_out*2-1:0] file_fftOut1_up;
reg [NBITS_out*2-1:0] file_fftOut1_down;
    
/*reg comp_fftOut0_up;
reg comp_fftOut0_down;
reg comp_fftOut1_up;
reg comp_fftOut1_down;*/

wire comp_fftOut0_up;
wire comp_fftOut0_down;
wire comp_fftOut1_up;
wire comp_fftOut1_down;
    
//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;
        
topfft#(
.NBITS(NBITS),
.NBITScoeff(NBITScoeff),
.NBITS_out(NBITS_out))
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
    










initial begin

data_in = $fopen("Input128.dat","r");  //lectura de entrada obtenida de Matlab
if (data_in == `NULL) begin
        $display("Input128.dat NULL");
         $finish;
    end
    
data_out = $fopen("Output128.dat","r"); //lectura de salida desde Matlab para comparar con la salida de verilog   
if (data_out == `NULL) begin
        $display("Output128.dat NULL");
         $finish;
    end    

 rst_tb  = 1'b1;
 #5 rst_tb  = 1'b0;
    rst_file=1'b1;
 
#12 rst_file=1'b0; //para alinear archivo con salida y poder comparar 8 para sat0 

 fftIn0_up   ={NBITS*2{1'b0}} ;
 fftIn0_down ={NBITS*2{1'b0}};
 fftIn1_up   ={NBITS*2{1'b0}};
 fftIn1_down ={NBITS*2{1'b0}};

end



always @(posedge clk) begin
   if(rst_tb) begin
      rst  = 1'd1;
   #5 rst  = 1'd0;
    fftIn0_up   ={NBITS*2{1'b0}} ;
    fftIn0_down ={NBITS*2{1'b0}};
    fftIn1_up   ={NBITS*2{1'b0}};
    fftIn1_down ={NBITS*2{1'b0}};
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
             
             #50;
              

              $finish;
        end
 end






always @(posedge clk) begin
   if(rst_file) begin
    file_fftOut0_up   ={NBITS_out*2{1'b0}};
    file_fftOut0_down ={NBITS_out*2{1'b0}};
    file_fftOut1_up   ={NBITS_out*2{1'b0}};
    file_fftOut1_down ={NBITS_out*2{1'b0}};
             end 
        else if(!$feof(data_out))  begin
             scan_out0 = $fscanf(data_out, "%b\n", file_fftOut0_up);
             scan_out1 = $fscanf(data_out, "%b\n", file_fftOut0_down);
             scan_out2 = $fscanf(data_out, "%b\n", file_fftOut1_up);
             scan_out3 = $fscanf(data_out, "%b\n", file_fftOut1_down);
             end
             
              else begin
    file_fftOut0_up   ={NBITS_out*2{1'b0}};
    file_fftOut0_down ={NBITS_out*2{1'b0}};
    file_fftOut1_up   ={NBITS_out*2{1'b0}};
    file_fftOut1_down ={NBITS_out*2{1'b0}};
             
        end
 end

/////////Comparador de salidas 
assign comp_fftOut0_up  = (fftOut0_up   === file_fftOut0_up  ) ? 1'b1 : 1'b0;
assign comp_fftOut0_down= (fftOut0_down === file_fftOut0_down) ? 1'b1 : 1'b0;
assign comp_fftOut1_up  = (fftOut1_up   === file_fftOut1_up  ) ? 1'b1 : 1'b0;
assign comp_fftOut1_down= (fftOut1_down === file_fftOut1_down) ? 1'b1 : 1'b0;



/////////////// Fin de comparador de salidas 



endmodule
