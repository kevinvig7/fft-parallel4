`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2019 16:24:45
// Design Name: 
// Module Name: contador_tb
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

module coeff_tb();
    
parameter Nbits=2;
parameter N=8;
//integer index=2;
//-- Registro para generar la señal de reloj
reg clk = 0;
reg rst;
wire [Nbits*2-1:0] coeff_out;
wire [Nbits*N*2-1:0] coeff_s;
//wire [Nbits*2-1:0] coeff_index;
    
//-- Instanciar el componente y establecer el valor del divisor
coeff 
  dut(
.clk(clk),
.coeff_out(coeff_out),
.coeff_s(coeff_s),
.rst(rst)
  );
    
//assign coeff_index= coeff_s[Nbits*N*2-index*Nbits*2-1-:4];  
    
    
//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;


    
//-- Proceso al inicio
initial begin
    rst  = 1'd1;
    #19 rst  = 1'd0;
  //-- Fichero donde almacenar los resultados
  $dumpfile("coeff_tb.vcd");
  $dumpvars(0, coeff_tb);
    
  # 200 $display("FIN de la simulacion");
  $finish;
end
endmodule
    