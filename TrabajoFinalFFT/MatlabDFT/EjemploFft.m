%% Shift Vector Elements

Xeven = [1 2 3 4 5 6];
fftshift(Xeven)

Xodd = [1 2 3 4 5 6 7];
fftshift(Xodd)

%% Shift 1-D Signal

fs = 100;               % sampling frequency
t = 0:(1/fs):(10-1/fs); % time vector
S = cos(2*pi*15*t);
n = length(S);
X = fft(S);
f = (0:n-1)*(fs/n);     %frequency range
power = abs(X).^2/n;    %power
plot(f,power)

% return;

Y = fftshift(X);
fshift = (-n/2:n/2-1)*(fs/n); % zero-centered frequency range
powershift = abs(Y).^2/n;     % zero-centered power
plot(fshift,powershift)

%% Sintaxis
% Y = fft(X,n,dim)
% Señal ruidosa

Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector

S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);

X = S + 2*randn(size(t));

figure()
plot(1000*t(1:50),X(1:50))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')

Y = fft(X);

% Calcule el espectro bilateral P2. A continuación, 
% calcule el espectro unilateral P1 basado en P2 y la longitud de la señal de valor uniforme L.
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

% Defina el dominio de la frecuencia f y represente gráficamente el espectro de amplitud unilateral 
% P1. Las amplitudes no son exactamente de 0,7 y 1, como se esperaba, debido 
% al ruido añadido. Como promedio, las señales más largas producen mejores aproximaciones de frecuencia.
f = Fs*(0:(L/2))/L;
figure()
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% Ahora, tome la transformada de Fourier de la señal 
% original, la señal sin dañar y recupere las amplitudes exactas, 0,7 y 1,0.
Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure()
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of S(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')






















