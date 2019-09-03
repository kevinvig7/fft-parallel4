%% Punto Fijo
clc; close all; clear;
onPlot = 1;

%% Completo muestras
delay_line = 3; 
paralelo = 2;  

% Salida DFT Paralelo 4
Xsalida = zeros(2*paralelo, 2*paralelo);
Xsalida = [Xsalida, zeros(2*paralelo,delay_line)];

% LINE 1
datos_line1 = [0, 2, 4, 6;...
               8,10,12,14];
% completo con ceros las muestras de datos_line1, para asegurar la propagacion.
datos_line1 = [datos_line1, zeros(paralelo,delay_line)];

% LINE 2
datos_line2 = [1, 3, 5, 7;...
               9,11,13,15];
% completo con ceros las muestras de datos_line1
datos_line2 = [datos_line2, zeros(paralelo,delay_line)];

%% Definiciones auxiliares
% stage 1

%% Reloj
for clk = (0:length(datos_line1)-1)
    
    clk
    
end
