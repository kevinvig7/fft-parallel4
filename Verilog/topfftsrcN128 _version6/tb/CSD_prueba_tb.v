`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.01.2020 10:18:40
// Design Name: 
// Module Name: CSD_prueba_tb
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


module CSD_prueba_tb(

    );
    
    reg signed [15:0] h0;
    reg signed [15:0] a;
  //  reg signed [10:0] b;
    reg signed [31:0] c;
    reg signed [31:0] d;
    reg signed [31:0] dd;
    
    reg signed [31:0] pp[0:4];
   
initial begin
     a = 16'b0111111001110111;
 //    b = 11'b00101101010;
      h0=16'b0000001100100101;
     
     pp[0]=32'h0;
     pp[1]=32'h0;
     pp[2]=32'h0;
     pp[3]=32'h0;
     pp[4]=32'h0;
     
    c=a*h0;

    pp[0] = a<<<10; // a>>>5;
    pp[1] =-a<<<8;  //-a>>>7;
    pp[2] = a<<<5;  // a>>>10;          Se deberia calcular --- tamaño del pp - tamaño de la muestra
    pp[3] = a<<<2;  // a>>>13;          
    pp[4] = a>>>0;  // a>>>15;   
  
/*    pp[0][31- 5-1:31-5 -1-15]  = a;
    pp[1][31- 7-1:31-7 -1-15]  =-a; /// con esta version hay problemas porque no considero la exp de signo cuando hay un valor negativo
    pp[2][31-10-1:31-10-1-15]  = a;      Tendria que cambiarlo y ponerlo en la sumatoria , no aqui 
    pp[3][31-13-1:31-13-1-15]  = a;          
    pp[4][31-15-1:31-15-1-15]  = a;  */ 

d= pp[0]+pp[1]+pp[2]+pp[3]+pp[4];

dd = d<<15;


end













/*   pp[0] = a<<<10;
    pp[1] =-a<<<8;
    pp[2] = a<<<5;
    pp[3] = a<<<2;
    pp[4] = a>>>0;    
*/
















/*
    reg signed [15:0] h0;
    reg signed [15:0] a;
  //  reg signed [10:0] b;
    reg signed [31:0] c;
    reg signed [31:0] d;
    reg signed [31:0] dd;
    
     reg signed [31:0] e;
    reg signed [31:0] ee;
    
    reg signed [31:0] pp[0:5];
   
initial begin
     a = 16'b1110110001000001;
 //    b = 11'b00101101010;
      h0=16'b0000001100100101;
     
    c=a*h0;

//Normal
//+(-1) -(-3) -(-5) +(-7) +(-9) 

*//*pp[0]=a>>>2;
pp[1]=a>>>4;
pp[2]=a>>>5;
pp[3]=a>>>7;
pp[4]=a>>>9;*//*

//CSD
//+(-1) -(-3) -(-5) +(-7) +(-9) 

*//*pp[0]=a>>>1;
pp[1]=-a>>>3;
pp[2]=-a>>>5;
pp[3]=a>>>7;
pp[4]=a>>>9;
*//*

    pp[0] = a>>>5;
    pp[1] = -a>>>7;
    pp[2] = a>>>10;
    pp[3] = a>>>13;
    pp[4] = a>>>15;    
    pp[5] = {16'b0,{a}};   

d= pp[0]+pp[1]+pp[2]+pp[3]+pp[4];

dd = d<<15;

end*/
endmodule
