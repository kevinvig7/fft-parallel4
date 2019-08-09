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
    
 parameter Nbits=2;
 parameter N=8;   
reg clk = 0;
reg rst;  
reg rst_tb;
 
 reg [Nbits*2-1:0] fftIn_up;
 reg [Nbits*2-1:0] fftIn_down;
wire [Nbits*2-1:0] fftOut_up;
wire [Nbits*2-1:0] fftOut_down;
    
       //-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;
        
topfft
  dut(
    .fftIn_up(fftIn_up),
    .fftIn_down(fftIn_down),
    .fftOut_up(fftOut_up),
    .fftOut_down(fftOut_down),
    .clk(clk),
    .rst(rst)
  );
    


//    //-- Proceso al inicio
//initial begin
//    rst  = 1'd1;
//    #20 rst  = 1'd0;
//    #10 fftIn_up ={Nbits*2{1'b1}};
//        fftIn_down ={Nbits*2{1'b1}};
        
//  //-- Fichero donde almacenar los resultados
//  $dumpfile("topfft_tb.vcd");
//  $dumpvars(0, topfft_tb);
    
//  # 500000 $display("FIN de la simulacion");
//  $finish;
//end
    
integer data_par; // file handler
integer data_impar;

integer scan_par; // file handler
integer scan_impar; // file handler

reg [Nbits*2-1:0] captured_data;

`define NULL 0

initial begin
data_par = $fopen("Entrada_parFFT.dat", "r");
data_impar = $fopen("Entrada_imparFFT.dat", "r");

        rst_tb  = 1'd1;
    #20 rst_tb  = 1'd0;

    if (data_par == `NULL) begin
        $display("data_file handle was NULL");
         $finish;
    end
end

always @(posedge clk) begin
   if(rst_tb) begin
  rst  = 1'd1;
  #20 rst  = 1'd0;
    end else begin
        scan_par = $fscanf(data_par, "%b\n", fftIn_up);
        scan_impar = $fscanf(data_impar, "%b\n", fftIn_down);
          if ($feof(data_par)) begin
          # 1000
           $finish;
         
          end
      end

end





endmodule
