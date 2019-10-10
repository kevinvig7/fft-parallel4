%% Butterfly y Multiplicador
clc; close all; clear;
addpath('PFijoFunciones');
R = Rutas();
addpath(R.R2);

fipref('NumericTypeDisplay','short',  'FimathDisplay','none');

% in1,  in2: Cuantizadas Previamente
% out1, out2: Salidas en Full Resolucion

% La entradas al Butterfly ya se deben encontar cuantizadas, para que la suma y
% resta interna en el Butterfly salgan con FullResolución

%% Butterfly 1
Fmath = fimath('RoundingMethod','Floor',  'OverflowAction','Saturate');
% S: Signo:
% W: Cantidad Total de bits
% F: Cantidad Fraccional
S = 1;
I = 0;
F = 9;
W = S+I+F;

in1 = 0.65;
in2 = 0.15;
% La clase: 'embedded.fi' 
% s10,9
in1fi = fi(in1, S,W,F, Fmath)
in2fi = fi(in2, S,W,F, Fmath);

% Salida Full REsolución
% s11,9
% suma1: 0.7969
[suma1, resta1] = BF(in1fi, in2fi)

%% Producto 1
% s22,18
[mlt1] = Mult(suma1, resta1,'true')

%% Butterfly 2
% s23,18
% suma2: 1.1953
[suma2, resta2] = BF(mlt1, suma1)

%% Producto 2
%  s34,27
% mlt2: 0.9525
[mlt2] = Mult(suma2, suma1,'true')

%% Bloque de Cuantificación
S1 = 1;
I1 = 0;
F1 = 9;
W1 = S1+I1+F1;

S2 = 1;
I2 = 1;
F2 = 9;
W2 = S2+I2+F2;

[C1, C2] = Cuantificacion(mlt2,S1,W1,F1, suma2,S2,W2,F2, 'true')

%% Entero Equivalente
[entero] = EquivalenteEnt([C1, C2])


