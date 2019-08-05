clc
close all
clear
%% Parametros
% señal de prueba
x = [1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0];
N = 16;
i = 1;

%% Stage 1
bf1_stage1 = Butterfly_clasico(x(i+0), x(i+8), N);
bf2_stage1 = Butterfly_clasico(x(i+1), x(i+9), N);
bf3_stage1 = Butterfly_clasico(x(i+2), x(i+10), N);
bf4_stage1 = Butterfly_clasico(x(i+3), x(i+11), N); 
bf5_stage1 = Butterfly_clasico(x(i+4), x(i+12), N); bf5_stage1(i+1) = bf5_stage1(i+1)*-j;
bf6_stage1 = Butterfly_clasico(x(i+5), x(i+13), N); bf6_stage1(i+1) = bf6_stage1(i+1)*-j;
bf7_stage1 = Butterfly_clasico(x(i+6), x(i+14), N); bf7_stage1(i+1) = bf7_stage1(i+1)*-j;
bf8_stage1 = Butterfly_clasico(x(i+7), x(i+15), N); bf8_stage1(i+1) = bf8_stage1(i+1)*-j;

%% Stage 2
w1 = (exp(-j*2*pi/N))^1;
w2 = (exp(-j*2*pi/N))^2;
w3 = (exp(-j*2*pi/N))^3;
w4 = (exp(-j*2*pi/N))^4;
% w5 = (exp(-j*2*pi/N))^5;
w6 = (exp(-j*2*pi/N))^6;
% w7 = (exp(-j*2*pi/N))^7;
% w8 = (exp(-j*2*pi/N))^8;
w9 = (exp(-j*2*pi/N))^9;

bf1_stage2 = Butterfly_clasico(bf1_stage1(i+0), bf5_stage1(i+0), N);
bf2_stage2 = Butterfly_clasico(bf2_stage1(i+0), bf6_stage1(i+0), N); bf2_stage2(i+1) = bf2_stage2(i+1)*w2;
bf3_stage2 = Butterfly_clasico(bf3_stage1(i+0), bf7_stage1(i+0), N); bf3_stage2(i+1) = bf3_stage2(i+1)*w4;
bf4_stage2 = Butterfly_clasico(bf4_stage1(i+0), bf8_stage1(i+0), N); bf4_stage2(i+1) = bf4_stage2(i+1)*w6;

bf5_stage2 = Butterfly_clasico(bf1_stage1(i+1), bf5_stage1(i+1), N);
bf6_stage2 = Butterfly_clasico(bf2_stage1(i+1), bf6_stage1(i+1), N); bf6_stage2(i+0) = bf6_stage2(i+0)*w1; bf6_stage2(i+1) = bf6_stage2(i+1)*w3;
bf7_stage2 = Butterfly_clasico(bf3_stage1(i+1), bf7_stage1(i+1), N); bf7_stage2(i+0) = bf7_stage2(i+0)*w2; bf7_stage2(i+1) = bf7_stage2(i+1)*w6;
bf8_stage2 = Butterfly_clasico(bf4_stage1(i+1), bf8_stage1(i+1), N); bf8_stage2(i+0) = bf8_stage2(i+0)*w3; bf8_stage2(i+1) = bf8_stage2(i+1)*w9;

%% Stage 3
bf1_stage3 = Butterfly_clasico(bf1_stage2(i+0), bf3_stage2(i+0), N);
bf2_stage3 = Butterfly_clasico(bf2_stage2(i+0), bf4_stage2(i+0), N); bf2_stage3(i+1) = bf2_stage3(i+1)*-j;

bf3_stage3 = Butterfly_clasico(bf1_stage2(i+1), bf3_stage2(i+1), N);
bf4_stage3 = Butterfly_clasico(bf2_stage2(i+1), bf4_stage2(i+1), N); bf4_stage3(i+1) = bf4_stage3(i+1)*-j;

bf5_stage3 = Butterfly_clasico(bf5_stage2(i+0), bf7_stage2(i+0), N);
bf6_stage3 = Butterfly_clasico(bf6_stage2(i+0), bf8_stage2(i+0), N); bf6_stage3(i+1) = bf6_stage3(i+1)*-j;

bf7_stage3 = Butterfly_clasico(bf5_stage2(i+1), bf7_stage2(i+1), N);
bf8_stage3 = Butterfly_clasico(bf6_stage2(i+1), bf8_stage2(i+1), N); bf8_stage3(i+1) = bf8_stage3(i+1)*-j;

%% Stage 4
bf1_stage4 = Butterfly_Adaptado(bf1_stage3(i+0), bf2_stage3(i+0), N);

bf2_stage4 = Butterfly_Adaptado(bf1_stage3(i+1), bf2_stage3(i+1), N);

bf3_stage4 = Butterfly_Adaptado(bf3_stage3(i+0), bf4_stage3(i+0), N);

bf4_stage4 = Butterfly_Adaptado(bf3_stage3(i+1), bf4_stage3(i+1), N);

bf5_stage4 = Butterfly_Adaptado(bf5_stage3(i+0), bf6_stage3(i+0), N);

bf6_stage4 = Butterfly_Adaptado(bf5_stage3(i+1), bf6_stage3(i+1), N);

bf7_stage4 = Butterfly_Adaptado(bf7_stage3(i+0), bf8_stage3(i+0), N);

bf8_stage4 = Butterfly_Adaptado(bf7_stage3(i+1), bf8_stage3(i+1), N);

%% Salida
% Ordeno directamente la salida de la FFT
% [X0,  X1,  X2,  X3,  ...
%  X4,  X5,  X6,  X7,  ...
%  X8,  X9,  X10, X11, ...
%  X12, X13, X14, X15]

DFT16pRadix4 = [bf1_stage4(i+0), bf5_stage4(i+0), bf3_stage4(i+0), bf7_stage4(i+0), ...
                bf2_stage4(i+0), bf6_stage4(i+0), bf4_stage4(i+0), bf8_stage4(i+0), ...
                bf1_stage4(i+1), bf5_stage4(i+1), bf3_stage4(i+1), bf7_stage4(i+1), ...
                bf2_stage4(i+1), bf6_stage4(i+1), bf4_stage4(i+1), bf8_stage4(i+1) ];

%% Plot FFT
figure();
out_dft = real( fftshift(DFT16pRadix4) );
plot( out_dft )
abs(DFT16pRadix4)



