`timescale 1ns/100ps 
// 1ns es la unidad, 100ps=0.1ns= pasos
module tb_ChannelTruncado();

// Localparam
localparam nbt_sig   = 10; // S(10,8)  Q(2,8)
localparam nbt_coef  = 14; // S(14,12) Q(2,12)
localparam nbt_sat   = 16;

// Puertos
reg  CLK100MHZ;   
reg  ck_rst;      
reg  i_enable;    
reg  signed [nbt_sig-1:0]  i_sigma;

reg  signed [nbt_coef-1:0] i_coefA;    
reg  signed [nbt_coef-1:0] i_coefB;    
reg  signed [nbt_coef-1:0] i_coefC;     
reg  signed [nbt_coef-1:0] i_coefD;    
reg  signed [nbt_coef-1:0] i_coefE;     
reg  signed [nbt_coef-1:0] i_coefF;     
reg  signed [nbt_coef-1:0] i_coefG;     
reg  signed [nbt_coef-1:0] i_coefH;

wire signed [nbt_sat-1:0]  o_r1i_noise;     
wire signed [nbt_sat-1:0]  o_r1q_noise;     
wire signed [nbt_sat-1:0]  o_r2i_noise;
wire signed [nbt_sat-1:0]  o_r2qc_noise;

      
initial begin
  CLK100MHZ = 1;
  ck_rst    = 0; // Activo en Bajo
  i_enable  = 0;

  // Sigma 10
  i_sigma = 10'b00_00111001; 
  // Case 20: ep=0, phi=0, tau=0
  i_coefA = 14'b01_000000000000;     
  i_coefB = 14'b01_000000000000;     
  i_coefC = 14'b00_000000000000;     
  i_coefD = 14'b00_000000000000;     
  i_coefE = 14'b00_000000000000;     
  i_coefF = 14'b00_000000000000;     
  i_coefG = 14'b00_000000000000;     
  i_coefH = 14'b00_000000000000;

  #100  ck_rst   = 1;   
  #40   i_enable = 1;
  #300  i_enable = 0;
  #100  i_enable = 1;

  #40 $finish;
end

// Periodo 10ns
always #5 CLK100MHZ = ~CLK100MHZ; 

// Instanciacion
ChannelTruncado
u_ChannelTruncado
(
  .CLK100MHZ    (CLK100MHZ)   ,
  .ck_rst       (ck_rst)      ,
  .i_enable     (i_enable)    ,
  .i_sigma      (i_sigma)     ,

  .i_coefA      (i_coefA)     ,   
  .i_coefB      (i_coefB)     ,   
  .i_coefC      (i_coefC)     ,    
  .i_coefD      (i_coefD)     ,   
  .i_coefE      (i_coefE)     ,    
  .i_coefF      (i_coefF)     ,    
  .i_coefG      (i_coefG)     ,    
  .i_coefH      (i_coefH)     ,

  .o_r1i_noise  (o_r1i_noise) ,   
  .o_r1q_noise  (o_r1q_noise) ,     
  .o_r2i_noise  (o_r2i_noise) ,
  .o_r2qc_noise (o_r2qc_noise)
);

// Fin Arquitectura
endmodule

// Desvio Estandar Sigma  S(10,8) Q(2,8)
// sigma10 = 10'b00_00111001;

// Case 14: ep=0, phi=0, tau=0.05T  S(14,12) Q(2,12)
// i_coefA = 14'b00_111111100100;     
// i_coefB = 14'b00_111111100100;     
// i_coefC = 14'b00_000111100001;     
// i_coefD = 14'b00_000111100001;     
// i_coefE = 14'b00_000000000000;     
// i_coefF = 14'b00_000000000000;     
// i_coefG = 14'b00_000000000000;     
// i_coefH = 14'b00_000000000000;
