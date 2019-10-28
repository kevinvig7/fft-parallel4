%% Dato de Interes
% Par obtener el mismo valor de potencia en ambos dominios 'tiempo',
% 'frecuencia', se debe de ingresar a la funcion de 'fft()' con el numero de
% muestras igual a la longitud de la señal a analizar, sino la potencia en los
% dominios será diferente.

% LEER: Si el numero de muestras de la señal es menor con respecto al numero de
% puntos de la 'fft()', ej: 33muestras<128puntos, la energia d ela señal en la
% frecuencia se ingrementa y los taps de la Dft toman valores mas grandes. 
% Caso contrario, si la longitud de la señal es muy grande con respecto a los
% piuntos de la Dft, los taps de frecuencia toman valores muy pequeños.

%% How to plot FFT using Matlab – FFT of basic signals : Sine and Cosine waves
% https://www.gaussianwaves.com/2014/07/how-to-plot-fft-using-matlab-fft-of-basic-signals-sine-and-cosine-waves/

%% Programa
clc; close all; clear;

% Frecuencia de la señal
f = 10; 
% Factor de sobremuestreo
overSampRate = 32; 
fs = overSampRate*f; 
% Fase de la señal
FaseGrados = 0;
phase = degtorad(FaseGrados);

% Señal discreta obtenia a partir de muestrear a la señal continua:
% x(t) = cos(w*t)
% x[n] = cos(w*n*Ts)

% 128Muestras/32FactoDeMuestreo = 4Ciclos 
nCiclos = 1;  
% Cuando 't' alcance el periodo de la señal 'T', entonces: T=n*Ts, por lo cual
% T/Ts = n = overSamRate
n = (1:1:nCiclos*overSampRate);
t = n*1/fs;
x = cos(2*pi*f*t+phase);
%x = x/norm(x);

% Grafico en funcion del numero de muestras 'n'
% stem(n,x);
% Grafico en funcion del tiempo 't'
%figure();
plot(t,x);
title(['Cosine Wave f=', num2str(f), 'Hz']);
xlabel('Time(s)');
ylabel('Amplitude');
grid minor;

%% 1. Plotting raw values of DFT:
NFFT = 128;      
X = fft(x,NFFT);  
% DFT Sample points      
nVals = (0:NFFT-1);
%figure();
stem(nVals,abs(X));      
title('Double Sided FFT - without FFTShift');        
xlabel('Sample points (N-point DFT)')        
ylabel('DFT Values');
grid minor;

%% 2. FFT plotting Normalized Frequency:
NFFT = 128;      
X = fft(x,NFFT);     
% Sample points   
nVals = (0:NFFT-1)/NFFT;      
stem(nVals,abs(X));      
title('Double Sided FFT - without FFTShift');        
xlabel('Normalized Frequency')       
ylabel('DFT Values');
grid minor;

%% 3. FFT plotting normalized frequency (positive & negative frequencies)
NFFT = 128; 
X = fftshift(fft(x,NFFT));
% Sample points  
fVals = (-NFFT/2:NFFT/2-1)/NFFT;   
figure;
stem(fVals,abs(X));      
title('Double Sided FFT - with FFTShift');       
xlabel('Normalized Frequency')       
ylabel('DFT Values');
grid minor;

%% 4. Absolute frequency on the x-axis Vs Magnitude on Y-axis:
% Realizar el grafico hasta este paso 
NFFT = 128;  
L = length(x);
X = fftshift(fft(x,NFFT)); 
% Sample points  
fVals = fs*(-NFFT/2:NFFT/2-1)/NFFT; 
figure;
  
% Grafica el valor absoluto que se obtine a la salida de la Dft
%stem(fVals,abs(X),'b'); 
%stem(fVals,abs(X)/(L),'b'); 
stem(fVals,abs(X)/(NFFT),'b'); 

title('Double Sided FFT - with FFTShift');          
xlabel('Frequency (Hz)')         
ylabel('|DFT Values|');
grid minor;

%% 5.1 Power Spectrum – Absolute frequency on the x-axis Vs Power on Y-axis:
NFFT = 128;
L = length(x);         
X = fftshift(fft(x,NFFT));         
% Power of each freq components
%Px = abs(X).^2/L^2;
Px = X.*conj(X)/(NFFT*L); 
%Px = (X.*conj(X))/(L^2);

% Potencia en ambos dominios
% Si empleo esta expresion, la Potencia va combiando
%PowerF = (norm(X)^2)/(L*L);

% Si empleo esta expresion, la PotenciaF se aproxima a PotenciaT
PowerF = (norm(X)^2)/(NFFT*L);
PowerT = (norm(x)^2)/L;

% Sample points  
fVals = fs*(-NFFT/2:NFFT/2-1)/NFFT;  
figure;
stem(fVals,Px,'b');      
title('Power Spectral Density');         
xlabel('Frequency (Hz)')         
ylabel('Power');
grid minor;

%% 5.2 PSD
NFFT = 128;      
L = length(x);         
X = fftshift(fft(x,NFFT));         
% Power of each freq components   
Px = X.*conj(X)/(NFFT*L);   
%Px = (X.*conj(X))/(L^2);

% Sample points 
fVals = fs*(-NFFT/2:NFFT/2-1)/NFFT;        
plot(fVals,10*log10(Px),'b');        
title('Power Spectral Density (dB)');         
xlabel('Frequency (Hz)')         
ylabel('Power');
grid minor;

%% 6. Power Spectrum – One-Sided frequencies
L = length(x);        
NFFT = 128;       
X = fft(x,NFFT);       
Px = X.*conj(X)/(NFFT*L);
% Sample points
fVals = fs*(0:NFFT/2-1)/NFFT;    
%figure;
plot(fVals,Px(1:NFFT/2),'b');         
title('One Sided Power Spectral Density');       
xlabel('Frequency (Hz)')         
ylabel('PSD');
grid minor;
