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

fxwn8 = fi(wn8,1,4,2);
fxw3n8 = fi(wn8,1,4,2);



fx1i=fi(-1i,1,4,2);





bf1_stage3 = Butterfly(bf1_stage2(i+0), bf3_stage2(i+0), N);
bf2_stage3 = Butterfly(bf2_stage2(i+0), bf4_stage2(i+0), N);

bf3_stage3 = Butterfly(bf1_stage2(i+1), fi(bf3_stage2(i+1)*fx1i,1,4,2), N);
bf4_stage3 = Butterfly(bf2_stage2(i+1), fi(bf4_stage2(i+1)*fx1i,1,4,2), N);

bf5_stage3 = Butterfly(bf5_stage2(i+0), fi(bf7_stage2(i+0)*fxwn8,1,4,2), N);
bf6_stage3 = Butterfly(bf6_stage2(i+0), fi(bf8_stage2(i+0)*fxwn8,1,4,2), N);

bf7_stage3 = Butterfly(bf5_stage2(i+1), fi(bf7_stage2(i+1)*fxw3n8,1,4,2), N);
bf8_stage3 = Butterfly(bf6_stage2(i+1), fi(bf8_stage2(i+1)*fxw3n8,1,4,2), N);

%% Stage 4
w1 = (exp(-1i*2*pi/N))^1; %  0.9239 - 0.3827i
w2 = (exp(-1i*2*pi/N))^2; %  0.7071 - 0.7071i
w3 = (exp(-1i*2*pi/N))^3; %  0.3827 - 0.9239i
w4 = (exp(-1i*2*pi/N))^4; % -0.0000 - 1.0000i
w5 = (exp(-1i*2*pi/N))^5; % -0.3827 - 0.9239i
w6 = (exp(-1i*2*pi/N))^6; % -0.7071 - 0.7071i
w7 = (exp(-1i*2*pi/N))^7; % -0.9239 - 0.3827i


fxw1 = fi(w1,1,4,2);
fxw2 = fi(w2,1,4,2);
fxw3 = fi(w3,1,4,2);
fxw4 = fi(w4,1,4,2);
fxw5 = fi(w5,1,4,2);
fxw6 = fi(w6,1,4,2);
fxw7 = fi(w7,1,4,2);


fid=fopen ('coefficientes.txt','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida

w1f=fxw1;
fprintf(fid,[w1f.bin '\n']);
    
w2f=fxw2;
fprintf(fid,[w2f.bin '\n']);

w3f=fxw3;
fprintf(fid,[w3f.bin '\n']);

w4f=fxw4;
fprintf(fid,[w4f.bin '\n']);

w5f=fxw5;
fprintf(fid,[w5f.bin '\n']);

w6f=fxw6;
fprintf(fid,[w6f.bin '\n']);

w7f=fxw7;
fprintf(fid,[w7f.bin '\n']);
    
w3n8f=fxw3n8;
fprintf(fid,[w3n8f.bin '\n']);
    
wn8f=fxwn8;
fprintf(fid,[wn8f.bin '\n']);
    
fclose(fid);



bf1_stage4 = Butterfly(bf1_stage3(i+0), bf2_stage3(i+0), N);

bf2_stage4 = Butterfly(bf1_stage3(i+1), fi(bf2_stage3(i+1)*fxw4,1,4,2), N);

bf3_stage4 = Butterfly(bf3_stage3(i+0), fi(bf4_stage3(i+0)*fxw2,1,4,2), N);

bf4_stage4 = Butterfly(bf3_stage3(i+1), fi(bf4_stage3(i+1)*fxw6,1,4,2), N);

bf5_stage4 = Butterfly(bf5_stage3(i+0), fi(bf6_stage3(i+0)*fxw1,1,4,2), N);

bf6_stage4 = Butterfly(bf5_stage3(i+1), fi(bf6_stage3(i+1)*fxw5,1,4,2), N);

bf7_stage4 = Butterfly(bf7_stage3(i+0), fi(bf8_stage3(i+0)*fxw3,1,4,2), N);

bf8_stage4 = Butterfly(bf7_stage3(i+1), fi(bf8_stage3(i+1)*fxw7,1,4,2), N);

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
on = false;
if(on)
    figure();
    out_dft = real( fftshift(DFT16pRadix8) );
    stem(out_dft, 'm')
    title('$Radix 2^3: X[k]=\sum_{n=0}^{N-1} x(n)W_N^{nk}$','Interpreter','latex','FontSize',13)
    xlabel('16 Points'); ylabel('DFT X[k]'); grid minor;
end

end

