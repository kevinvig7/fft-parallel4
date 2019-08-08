clc
close all
clear
% Funcion SIN TERMINAR en el ultimo Stage30

%% Parametros
% Señal de entrada
% xn = [1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0];
xn = ones(1,16);

% Butterflys por etapa
num_butterfly = length(xn)/2;
% Butterfly de dos entradas
bf = [1,1];
stage1_bf = [];

for index = 1:num_butterfly
    stage1_bf = [stage1_bf, bf];
end
stage2_bf = stage1_bf;
stage3_bf = stage1_bf;

%% Stage 10
% Interconexiones
% Puntero, recorre cada Butterfly
p = 0;
for index = 1: num_butterfly  
   salidaPosBut = p+index;
   salidaNegBut = p+index+1;
   nBut         = [salidaPosBut: salidaNegBut];
   
   sample1 = index;
   sample2 = index+num_butterfly;
   
   stage1_bf(nBut) = Butterfly(xn(sample1), xn(sample2)); 
   
   p=p+1;
end

% Factores Complejos que multiplican la primer etapa
for index = (num_butterfly/2)+1: num_butterfly 
    outBut = index*2;
    % Multiplica la linea negativa de BF5/6/7/8, caso N=16p
    stage1_bf(outBut) = stage1_bf(outBut)*-j;
end

%% Stage 20
p = 0;
for index = 1: num_butterfly/2 
   salidaPosBut = p+index;
   salidaNegBut = p+index+1;
   nBut         = [salidaPosBut: salidaNegBut];
   
   outBut1 = salidaPosBut;
   outBut2 = salidaPosBut+ num_butterfly;
   
   stage2_bf(nBut) = Butterfly( stage1_bf(outBut1), stage1_bf(outBut2) );
   
   p=p+1;
end

p = 0;
for index = num_butterfly/2 +1: num_butterfly 
   salidaPosBut = num_butterfly/2 +index+p;
   salidaNegBut = num_butterfly/2 +index+p+1;
   nBut         = [salidaPosBut: salidaNegBut];
   
   outBut1 = index - num_butterfly/2 +p +1;
   outBut2 = index + num_butterfly/2 +p +1;
   
   stage2_bf(nBut) = Butterfly( stage1_bf(outBut1), stage1_bf(outBut2) );
   
   p=p+1;
end

% Factores Complejos que multiplican la Segunda etapa
wn8  = exp(-j*pi/4);    %  0.7071 - 0.7071i
w3n8 = exp(-j*pi/4)*-j; % -0.7071 - 0.7071i

for index = (num_butterfly/4)+1: num_butterfly/2 
   nBut   = index*2;
   stage2_bf(nBut) = stage2_bf(nBut)*-j;
end

for index = (num_butterfly*3/4)+1: num_butterfly
   nButpos = (index*2)-1;
   nButneg = index*2;
   
   stage2_bf(nButpos) = stage2_bf(nButpos)*wn8;
   stage2_bf(nButneg) = stage2_bf(nButneg)*w3n8;
end

%% Stage 30
% Falta la 3era etapa de conexion y el bloque de multiplicaciones complejas
% Terminarlo, luego. u optar por otro metodo

