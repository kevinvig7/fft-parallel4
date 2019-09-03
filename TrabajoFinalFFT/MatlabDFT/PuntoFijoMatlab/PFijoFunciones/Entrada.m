function [out] = Entrada()

% Señal de entrada en Punto flotante:
% Puntos fft: 128.
% Sumo 2 cosenoidales de diferente frecuencias.
% Factor de sobremuestreo: 5, es posible cambiar parametro.
% Solo me quedo con 128 puntos de la señal de entrada a la Transformada.

% Señal discreta obtenia a partir de muestrear a la señal continua:
% x(t) = cos(w*t)
% x[n] = cos(w*n*Ts)

% Puntos
Nfft = 128; 
% Frecuencias de las señales
f1 = 100;
f2 = 1000;
f = max(f1,f2);
% Factor de sobremuestreo
% Muestreo: Compresion en tiempo, incremento en frecuencia.
overSampRate = 5;       
fs = overSampRate*f; 
n = (1:1:Nfft);
t = n*1/fs;

w1 = 2*pi*f1*t;
w2 = 2*pi*f2*t;
fase1 = degtorad(0);
fase2 = degtorad(0);
% señal compuesta formada por la suma de dos tonos
x = cos(w1+fase1) + cos(w2+fase2);    
% normalizamos la amplitud maxima de la señal, para que no haya armonicos
x = x/max(x);

%% Cuantizo la señal de entrada
% Paramertros de la operacion en punto fijo
Pmath = fimath('RoundingMethod', 'Floor', ...
               'OverflowAction', 'Saturate', ...
               'ProductMode',    'FullPrecision', ...
               'SumMode',        'FullPrecision');

% La clase de la variable es: 'embedded.fi' 
% Signado:
S = 1;
% Cantidad entera
I = 6;
% Cantidad Fraccional
F = 3;
% Cantidad Total de bits
W = S+I+F;
xfi = fi(x, S,W,F, Pmath);
% Tranformo la clase: 'double' 
out = xfi.double;


end
