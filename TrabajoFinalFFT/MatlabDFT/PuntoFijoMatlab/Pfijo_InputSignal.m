%% Señal de entrada
clc; close all; clear;
addpath('PFijoFunciones');
fipref('NumericTypeDisplay','short',  'FimathDisplay','none');

%% Señal de entrada en Punto Fijo:
% Signo:
S = 1;
% Cantidad entera
I = 0;
% Cantidad Fraccional
F = 9;
% Cantidad Total de bits
W = S+I+F;

% Rango: s(10,8) Q(2,8) -2.0000  1.9961
% Rango: s(10,9) Q(1,9) -1.0000  0.9980 
% Rango: s(9,8)  Q(1,8) -1.0000  0.9961
[xFi,xFlot,t,xEq] = InputSignal(S,W,F);

%% Error cuadratico
%  Error: 1.1342e-05
xError = max((xFlot-xFi.double).^2)

% Error: Con una Snr aproximadamente de 50dB, se tiene una buena aproximación.
% Para F=3, la varianza=0.0014
% Para F=8, la varianza=9.3374e-07
SNRx = 10*log10( var(xFlot)/var(xFlot-xFi.double) )

% Plot
xonPlot = 1;
if(xonPlot)
    figure();
    plot(t,xFi.double, 'm');
    hold on;
    plot(t,xFlot);
    xlabel('Time(s)');
    ylabel('Amplitude');
    grid minor;
end
