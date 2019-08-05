clc
close all
clear

%% Stage 1
%Input samples
% x = zeros(1,16);
% x = 1:16;
% x = [zeros(1,3), ones(1,10)*1, zeros(1,3)];
% x = [0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1];
x = [1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0];
N = 16;
i = 1;

bf1_stage1 = Butterfly(x(i+0), x(i+8), N);
bf2_stage1 = Butterfly(x(i+1), x(i+9), N);
bf3_stage1 = Butterfly(x(i+2), x(i+10), N);
bf4_stage1 = Butterfly(x(i+3), x(i+11), N);
bf5_stage1 = Butterfly(x(i+4), x(i+12), N);
bf6_stage1 = Butterfly(x(i+5), x(i+13), N);
bf7_stage1 = Butterfly(x(i+6), x(i+14), N);
bf8_stage1 = Butterfly(x(i+7), x(i+15), N);


%% Stage 2
bf1_stage2 = Butterfly(bf1_stage1(i+0), bf5_stage1(i+0), N);
bf2_stage2 = Butterfly(bf2_stage1(i+0), bf6_stage1(i+0), N);
bf3_stage2 = Butterfly(bf3_stage1(i+0), bf7_stage1(i+0), N);
bf4_stage2 = Butterfly(bf4_stage1(i+0), bf8_stage1(i+0), N);

bf5_stage2 = Butterfly(bf1_stage1(i+1), bf5_stage1(i+1)*-j, N);
bf6_stage2 = Butterfly(bf2_stage1(i+1), bf6_stage1(i+1)*-j, N);
bf7_stage2 = Butterfly(bf3_stage1(i+1), bf7_stage1(i+1)*-j, N);
bf8_stage2 = Butterfly(bf4_stage1(i+1), bf8_stage1(i+1)*-j, N);

%% Stage 3
bf1_stage3 = Butterfly(bf1_stage2(i+0), bf3_stage2(i+0), N);
bf2_stage3 = Butterfly(bf2_stage2(i+0), bf4_stage2(i+0), N);

bf3_stage3 = Butterfly(bf1_stage2(i+1), bf3_stage2(i+1)*-j, N);
bf4_stage3 = Butterfly(bf2_stage2(i+1), bf4_stage2(i+1)*-j, N);

bf5_stage3 = Butterfly(bf5_stage2(i+0), bf7_stage2(i+0)*( (exp(-j*2*pi/N))^(N/8) ), N);
bf6_stage3 = Butterfly(bf6_stage2(i+0), bf8_stage2(i+0)*( (exp(-j*2*pi/N))^(N/8) ), N);

bf7_stage3 = Butterfly(bf5_stage2(i+1), bf7_stage2(i+1)*( (exp(-j*2*pi/N))^(3*N/8) ), N);
bf8_stage3 = Butterfly(bf6_stage2(i+1), bf8_stage2(i+1)*( (exp(-j*2*pi/N))^(3*N/8) ), N);

%% Stage 4
bf1_stage4 = Butterfly_Adaptado(bf1_stage3(i+0), bf2_stage3(i+0), N);

bf2_stage4 = Butterfly_Adaptado(bf1_stage3(i+1), bf2_stage3(i+1)*( (exp(-j*2*pi/N))^4 ), N);

bf3_stage4 = Butterfly_Adaptado(bf3_stage3(i+0), bf4_stage3(i+0)*( (exp(-j*2*pi/N))^2 ), N);

bf4_stage4 = Butterfly_Adaptado(bf3_stage3(i+1), bf4_stage3(i+1)*( (exp(-j*2*pi/N))^6 ), N);

bf5_stage4 = Butterfly_Adaptado(bf5_stage3(i+0), bf6_stage3(i+0)*( (exp(-j*2*pi/N))^1 ), N);

bf6_stage4 = Butterfly_Adaptado(bf5_stage3(i+1), bf6_stage3(i+1)*( (exp(-j*2*pi/N))^5 ), N);

bf7_stage4 = Butterfly_Adaptado(bf7_stage3(i+0), bf8_stage3(i+0)*( (exp(-j*2*pi/N))^3 ), N);

bf8_stage4 = Butterfly_Adaptado(bf7_stage3(i+1), bf8_stage3(i+1)*( (exp(-j*2*pi/N))^7 ), N);

%% Salida
% Ordeno directamente la salida de la FFT
% [X0,  X1,  X2,  X3,  ...
%  X4,  X5,  X6,  X7,  ...
%  X8,  X9,  X10, X11, ...
%  X12, X13, X14, X15]

DFT16pRadix8 = [bf1_stage4(i+0), bf5_stage4(i+0), bf3_stage4(i+0), bf7_stage4(i+0), ...
                bf2_stage4(i+0), bf6_stage4(i+0), bf4_stage4(i+0), bf8_stage4(i+0), ...
                bf1_stage4(i+1), bf5_stage4(i+1), bf3_stage4(i+1), bf7_stage4(i+1), ...
                bf2_stage4(i+1), bf6_stage4(i+1), bf4_stage4(i+1), bf8_stage4(i+1) ];

%% Plot FFT
figure();
out_dft = real( fftshift(DFT16pRadix8) );
stem( out_dft )



