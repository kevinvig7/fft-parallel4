%% Test PFijo
clc; close all; clear;

% Preferencia de visualizacion de la funcion 'fi()'
fipref('NumericTypeDisplay','short',  'FimathDisplay','none');
Fmath = fimath('RoundingMethod','Floor',  'OverflowAction','Saturate');

% Valor
v = 1;

% Signo:
S = 1;
% Cantidad entera
I = 0;
% Cantidad Fraccional
F = 9;
% Cantidad Total de bits
W = S+I+F;

% Fijo
test = fi(1, S,20,9, Fmath)
%range(test)
tes = fi(test.double,S, 11,9, Fmath)

% Test complejo
cre = 3;
dim = 4;
C = cre+dim*1i;
Cprim = C*-1j;
Cfi = fi(C, S,7,2, Fmath);

%% Cambio de signo
val = 1;
signoPos = fi(+val,  S,5,2, Fmath)
signoPos.bin
signoNeg = fi(-val, S,5,2, Fmath)
signoNeg.bin

range(signoNeg)

%% Test complejo
Cfi1 = fi(C, S,7,2, Fmath)
Cfi2 = fi(C, S,7,2, Fmath)

resultado = Cfi1*Cfi2

fi1 = fi(24, S,7,2, Fmath)
fi2 = fi(24, S,7,2, Fmath)

fi1*Cfi