%% Computation of Power of a Signal in Matlab – Simulation and Verification

% https://www.gaussianwaves.com/2013/12/computation-of-power-of-a-signal-in-matlab-simulation-and-verification/
% https://www.gaussianwaves.com/2015/11/interpreting-fft-results-complex-dft-frequency-bins-and-fftshift/
% https://www.gaussianwaves.com/2013/12/power-and-energy-of-a-signal/
% https://www.gaussianwaves.com/2014/07/generating-basic-signals-rectangule-pulse-and-power-spectral-density-using-fft/
% https://www.gaussianwaves.com/2015/11/interpreting-fft-results-obtaining-magnitude-and-phase-information/

clc; close all; clear;

% Amplitude of sine wave
A = 1;          
% Frequency of sine wave
Fc = 100;      
% Sampling rate - oversampled by the rate of 10
Fs = 10000;     
% Sampling period
Ts = 1/Fs;      
% Number of cycles of the sinewave
nCycles = 100;  
 
subplot(2,1,1);
% Time base
t = 0:Ts:nCycles/Fc-Ts;
% Sinusoidal function
x = A*sin(2*pi*Fc*t); 
%x = x/norm(x);
plot(t,x); 

%% Dato de Interes
% Par obtener el mismo valor de potencia en ambos dominios 'tiempo',
% 'frecuencia', se debe de ingresar a la funcion de 'fft()' con el numero de
% muestras igual a la longitud de la señal a analizar, sino la potencia en los
% dominios será diferente.

%% Norma
L = length(x);
% energia = norm(x)^2;
P = (norm(x)^2)/L;
sprintf('Power of the Signal from Time domain %f',P);

%% Power
X = fft(x);
% Compute power with proper scaling.
Px = sum(X.*conj(X))/(L^2); 
subplot(2,1,2)
% Plot single-sided amplitude spectrum.
stem(Px);
sprintf('Total Power of the Signal from DFT %f',P);

