%y(t) = 3r(t + 3) − 6r(t + 1) + 3r(t) − 3u(t − 3)
%%%%%%%%%%%%%%%%%%%
% Example 1.16 LIbro Skalar comunicacion digital
%%%%%%%%%%%%%%%%%%%
clear all; clf
Ts = 0.01; t = -5:Ts:5; % support of signal
% ramp with support [-5, 5], slope of 3 and advanced
% (shifted left) with respect to the origin by 3
y1 = ramp(t,3,3);
y2 = ramp(t,-6,1);
y3 = ramp(t,3,0);
% unit-step function with support [-5,5], delayed by 3
y4 = -3 * ustep(t,-3);
y  = y1 + y2 + y3 + y4;
plot(t,y,’k’); axis([-5 5 -1 7]); grid

%Tradeoff between
%Accurately minimising ISI and Minimising the noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%from webSite
% Ejemplo para Obtener QAM Theoretical BER in AWGN
% The bit error rate (BER) of QAM can be calculated through 
% Monte Carlo simulations, The BER for Gray coded QAM
% 1.Each additional bit/symbol requires about 2dB extra in SNR to achieve the same BER.
% http://www.raymaps.com/index.php/qam-theoretical-ber/
EbNodB	= -6:2:24
EbNo 	= 10.^(EbNodB/10);
k		= 8;
M 		= 2^k;
x 		= sqrt(3*k*EbNo/(M-1));
Pb 		= (4/k)*(1-1/sqrt(M))*(1/2)*erfc(x/sqrt(2));
semilogy(EbNodB,Pb)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = ramp(t,m,ad)
% ramp generation
% t: time support
% m: slope of ramp
% ad : advance (positive), delay (negative) factor
% USE: y = ramp(t,m,ad)
N = length(t);
y = zeros(1,N);
for i = 1:N,
	if t(i) >= -ad,
		y(i) = m * (t(i)+ad);
	end
end

function y = ustep(t,ad)
% generation of unit step
% t: time
% ad : advance (positive), delay (negative)
% USE y = ustep(t,ad)
N = length(t);
y = zeros(1,N);
for i = 1:N,
	if t(i) >= -ad,
		y(i) = 1;
	end
end