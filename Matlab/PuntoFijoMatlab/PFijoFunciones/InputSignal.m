function [xFi,xFlot,t,xEq,fs] = InputSignal(S,W,F)

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
xn = x/max(x);

%% Señal de entrada en Punto Fijo:
% The property values
Fmath = fimath('RoundingMethod','Floor',  'OverflowAction','Saturate');
% S: Signo:
% W: Cantidad Total de bits
% F: Cantidad Fraccional

% La clase: 'embedded.fi' 
xfi = fi(xn, S,W,F, Fmath);

% Version flotante del numero "Cuantizado"
%xFi = xfi.double;
% Version 'Embedded.fi'  del numero "Cuantizado"
xFi   = xfi;

% Version flotante del numero "No Cuantizado"
xFlot = xn; 

% "Entero equivalente" de la representacion binaria
EntEq = zeros(1,length(xfi));
for index = (1:length(xfi))
    Decimal = xfi(index);
    EntEq(index) = str2double(Decimal.dec);
end
xEq = EntEq;

end
