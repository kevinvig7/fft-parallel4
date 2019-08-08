%% Test
figure()

% signal = [0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0];
signal = [ones(1,6), zeros(1,128-6)];
valor = real(fftshift(fft(signal,128)));
stem(valor)

return;
signal = ones(1,16);
valor = real(fftshift(fft(signal,128)));
plot(valor)

%% Reading signal RMS values out of a Matlab pwelch periodogram

% % pwelch with a given window length
% [Pxx,f]=pwelch(x);
% [Pxx,f]=pwelch(x,1000);
% 
% % pwelch with a different window
% pwelch(x,hamming(1000))
% pwelch(x,hanning(1000)) 
% pwelch(x,blackmanharris(1000))
% 
% % pwelch without overlap
% pwelch(x,hanning(1000),0) 
% 
% % pwelch with real frequencies
% % All the above examples still work with normalised frequencies, i.e., a sampling frequency of 1 Hz is
% % assumed and the single-sided spectrum goes from 0,..,0.5 Hz. To use a real sampling frequency of256 kHz
% pwelch(x,hanning(1000),0,[],256e3)
% 
% % Recommended practice
% nx = max(size(x));
% na = 16; %the averaging factor
% w = hanning(floor(nx/na));
% [Pxx,f]=pwelch(x,w,0,[],256e3);

%% pwelch: Welch’s power spectral density estimate

% fft(Y) will give you a complex-valued output, which is the discrete Fourier transform of Y.
% pwelch(Y, ...., 'twosided') is giving you a Welch's overlapped segment averaging power 
% spectral density estimate where there is some averaging done to reduce the variablity of 
% the spectral estimate.

% Welch PSD Estimate of Signal with Frequency in Hertz
% ====================================================
rng default

fs = 1000;
t = 0:1/fs:5-1/fs; 
% t = 0: 0.001: 4.999

noisevar = 1/4;
x = cos(2*pi*100*t)+sqrt(noisevar)*randn(size(t));

% Obtain the DC-centered power spectrum using Welch's method. Use a segment length of 500 samples 
% with 300 overlapped samples and a DFT length of 500 points. 
[pxx,f] = pwelch(x,500,300,500,fs,'centered','power');

plot(f,10*log10(pxx))
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
grid

% [pxx,f]= pwelch(x,window,noverlap,nfft,fs)
% https://www.dsprelated.com/showarticle/1221.php
fs= 4000;                % Hz sample rate
Ts= 1/fs;
f0= 500;                 % Hz sine frequency
A= sqrt(2);              % V sine amplitude for P= 1 W into 1 ohm.
N= 1024;                 % number of time samples
n= 0:N-1;                % time index
x= A*sin(2*pi*f0*n*Ts) + .1*randn(1,N)*0;    % 1 W sinewave + noise




