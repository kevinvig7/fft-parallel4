%% Rotadores
clc; close all; clear;
addpath('PFijoFunciones');
fipref('NumericTypeDisplay','short',  'FimathDisplay','none');

% Signo:
S = 1;
% Cantidad entera
I = 0;
% Cantidad Fraccional
F = 9;
% Cantidad Total de bits
W = S+I+F;
[twiddleFi,twiddleFlot,twiddleEq] = TwiddlesPfijo(S,W,F);

%% Error cuadratico  de la Parte Real e Imaginaia
twiddleErrorR = real((twiddleFlot - twiddleFi.double)).^2;
twiddleErrorI = imag((twiddleFlot - twiddleFi.double)).^2;

%% Busco el maximo Error
Tfi = twiddleFi.double;
[fil,col] = size(Tfi);

maxReal = zeros(1,fil);
maxImag = zeros(1,fil);
posRcol = zeros(1,fil);
posIcol = zeros(1,fil);

for filas = (1:fil)
    % minReal/Imag: guarda el valor minimo de cada una de las 24 filas
    % posR/Icol: Me entrega un valor de posicion 1 entre 32 de cada fila en
    % donde se encontro el minimo
    [maxReal(filas),posRcol(filas)] = max(twiddleErrorR(filas,:));
    [maxImag(filas),posIcol(filas)] = max(twiddleErrorI(filas,:));
end

% Obtengo el minimo del vector de 24 elementos que contienen los minimos de las
% 24 filas.
[mRfil,posRfil] = max(maxReal);
[mIfil,posIfil] = max(maxImag);

% Posiciones de los Errores maximos
RowR = posRfil;
ColumnR = posRcol(posRfil);

RowI = posIfil;
ColumnI = posIcol(posIfil);

% Maximos Errores en las partes Real e Imaginaria
% Error: 1.5259e-05
ErrorR = twiddleErrorR(RowR, ColumnR)
ErrorI = twiddleErrorI(RowI, ColumnI)
