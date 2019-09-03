%% Test fft: suma de señales
clc; close all; clear;
% Señal discreta obtenia a partir de muestrear a la señal continua:
% x(t) = cos(w*t)
% x[n] = cos(w*n*Ts)

% Puntos fft
NFFT = 128; 
% Frecuencias de las señales
f1 = 100;
f2 = 1000;
f = max(f1,f2);
% Factor de sobremuestreo
% Señal se comprime en tiempo a medida que se incrementa en frecuencia.
overSampRate = 5;       %4; 32; 16
fs = overSampRate*f; 
%nCiclos = 4;           %32; 32; 64  
n = (1:1:NFFT);
t = n*1/fs;

w1 = 2*pi*f1*t;
w2 = 2*pi*f2*t;
fase1 = degtorad(0);
fase2 = degtorad(0);
% señal compuesta formada por la suma de un tono de 500hz y otro de 5khz.
x = cos(w1+fase1) + cos(w2+fase2);    
% normalizamos la amplitud maxima de la se�al, para que no haya armonicos
x = x/max(x);

figure;
plot(t(),x());
title(['Cosine Wave f=', num2str(f), 'Hz']);
xlabel('Time(s)');
ylabel('Amplitude');
grid minor;

%% Fourier
X = fftshift(fft(x,NFFT));
frec = fs*(-NFFT/2:NFFT/2-1)/NFFT;   

figure;
stem(frec,abs(X));      
title('Double Sided FFT');       
xlabel('Normalized Frequency')       
ylabel('DFT Values');
grid minor;
