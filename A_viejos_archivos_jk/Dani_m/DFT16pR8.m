function [ DFT16pRadix8_out ] = DFT16pR8( xn )

% clc
% close all
% clear
% Muestra de entrada para test
% x = [1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0];
x = xn;
N = 16;
i = 1;

%% Stage 1
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
wn8  = exp(-j*pi/4);    %  0.7071 - 0.7071i
w3n8 = exp(-j*pi/4)*-j; % -0.7071 - 0.7071i

bf1_stage3 = Butterfly(bf1_stage2(i+0), bf3_stage2(i+0), N);
bf2_stage3 = Butterfly(bf2_stage2(i+0), bf4_stage2(i+0), N);

bf3_stage3 = Butterfly(bf1_stage2(i+1), bf3_stage2(i+1)*-j, N);
bf4_stage3 = Butterfly(bf2_stage2(i+1), bf4_stage2(i+1)*-j, N);

bf5_stage3 = Butterfly(bf5_stage2(i+0), bf7_stage2(i+0)*wn8, N);
bf6_stage3 = Butterfly(bf6_stage2(i+0), bf8_stage2(i+0)*wn8, N);

bf7_stage3 = Butterfly(bf5_stage2(i+1), bf7_stage2(i+1)*w3n8, N);
bf8_stage3 = Butterfly(bf6_stage2(i+1), bf8_stage2(i+1)*w3n8, N);

%% Stage 4
w1 = (exp(-j*2*pi/N))^1; %  0.9239 - 0.3827i
w2 = (exp(-j*2*pi/N))^2; %  0.7071 - 0.7071i
w3 = (exp(-j*2*pi/N))^3; %  0.3827 - 0.9239i
w4 = (exp(-j*2*pi/N))^4; % -0.0000 - 1.0000i
w5 = (exp(-j*2*pi/N))^5; % -0.3827 - 0.9239i
w6 = (exp(-j*2*pi/N))^6; % -0.7071 - 0.7071i
w7 = (exp(-j*2*pi/N))^7; % -0.9239 - 0.3827i

bf1_stage4 = Butterfly(bf1_stage3(i+0), bf2_stage3(i+0), N);

bf2_stage4 = Butterfly(bf1_stage3(i+1), bf2_stage3(i+1)*w4, N);

bf3_stage4 = Butterfly(bf3_stage3(i+0), bf4_stage3(i+0)*w2, N);

bf4_stage4 = Butterfly(bf3_stage3(i+1), bf4_stage3(i+1)*w6, N);

bf5_stage4 = Butterfly(bf5_stage3(i+0), bf6_stage3(i+0)*w1, N);

bf6_stage4 = Butterfly(bf5_stage3(i+1), bf6_stage3(i+1)*w5, N);

bf7_stage4 = Butterfly(bf7_stage3(i+0), bf8_stage3(i+0)*w3, N);

bf8_stage4 = Butterfly(bf7_stage3(i+1), bf8_stage3(i+1)*w7, N);

%% Parametro que devuelve la funcion
% x[n] --> 0,1,2, 3,4, 5,6, 7,8,9,10,11,12,13,14,15
% X[k] --> 0,8,4,12,2,10,6,14,1,9, 5,13, 3,11, 7,15 

DFT16pRadix8_out = [bf1_stage4, bf2_stage4, bf3_stage4, bf4_stage4, ...
                    bf5_stage4, bf6_stage4, bf7_stage4, bf8_stage4 ];

%% Plot DFT
% Ordeno directamente la salida de la DFT para visualizarlo rapidamente
% [X0,  X1,  X2,  X3,  ...
%  X4,  X5,  X6,  X7,  ...
%  X8,  X9,  X10, X11, ...
%  X12, X13, X14, X15]

DFT16pRadix8 = [bf1_stage4(i+0), bf5_stage4(i+0), bf3_stage4(i+0), bf7_stage4(i+0), ...
                bf2_stage4(i+0), bf6_stage4(i+0), bf4_stage4(i+0), bf8_stage4(i+0), ...
                bf1_stage4(i+1), bf5_stage4(i+1), bf3_stage4(i+1), bf7_stage4(i+1), ...
                bf2_stage4(i+1), bf6_stage4(i+1), bf4_stage4(i+1), bf8_stage4(i+1) ];

% Plot
on = true;
if(on)
    figure();
    out_dft = real( fftshift(DFT16pRadix8) );
    stem(out_dft, 'm')
    title('$Radix 2^3: X[k]=\sum_{n=0}^{N-1} x(n)W_N^{nk}$','Interpreter','latex','FontSize',13)
    xlabel('16 Points'); ylabel('DFT X[k]'); grid minor;
end

end

