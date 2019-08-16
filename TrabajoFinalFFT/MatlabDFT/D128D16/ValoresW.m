%% Valores las Exponenciales
% N=128
% Para n=0,1,2,...,N/8-1
% W = exp(-j*2*pi/N)^(k*n)
% 
% W^0n
% W^4n
% W^2n
% W^6n
% W^1n
% W^5n
% W^3n
% W^7n

clc
close
clear

N = 128;
W0 = zeros(1, N/8);
W4 = zeros(1, N/8);
W2 = zeros(1, N/8);
W6 = zeros(1, N/8);
W1 = zeros(1, N/8);
W5 = zeros(1, N/8);
W3 = zeros(1, N/8);
W7 = zeros(1, N/8);

% El siguiente for almacerara en cada vector la correspondiente potencia
% que debera tener el factor de Twiddle en la Tercera estapa d elos
% Butterflys para Radix-2^3
for n = 0:N/8-1
    n;
    W0(n+1) = 0*n;
    W4(n+1) = 4*n;
    W2(n+1) = 2*n;
    W6(n+1) = 6*n;
    W1(n+1) = 1*n;
    W5(n+1) = 5*n;
    W3(n+1) = 3*n;
    W7(n+1) = 7*n;    
end