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

module contador_tb();
    
//-- Registro para generar la señal de reloj
reg clk = 0;
wire clk_out;
    
//-- Instanciar el componente y establecer el valor del divisor
contador #(8)
  dut(
    .clk_in(clk),
    .clk_out(clk_out)
  );
    
//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;
    
//-- Proceso al inicio
initial begin
    
  //-- Fichero donde almacenar los resultados
  $dumpfile("contador_tb.vcd");
  $dumpvars(0, contador_tb);
    
  # 120 $display("FIN de la simulacion");
  $finish;
end
endmodule
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
