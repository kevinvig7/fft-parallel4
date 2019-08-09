function [ DFT16pRadix8_out ] = DFT16pR8( xn , Nbits ,Nbitsf )

% clc
% close all
% clear
% Muestra de entrada para test
% x = [1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0];
x = xn;
N = 16;
z = 1;

%% Stage 1
bf1_stage1 = Butterfly(x(z+0), x(z+8), N,Nbits,Nbitsf);
bf2_stage1 = Butterfly(x(z+1), x(z+9), N,Nbits,Nbitsf);
bf3_stage1 = Butterfly(x(z+2), x(z+10), N,Nbits,Nbitsf);
bf4_stage1 = Butterfly(x(z+3), x(z+11), N,Nbits,Nbitsf);
bf5_stage1 = Butterfly(x(z+4), x(z+12), N,Nbits,Nbitsf);
bf6_stage1 = Butterfly(x(z+5), x(z+13), N,Nbits,Nbitsf);
bf7_stage1 = Butterfly(x(z+6), x(z+14), N,Nbits,Nbitsf);
bf8_stage1 = Butterfly(x(z+7), x(z+15), N,Nbits,Nbitsf);

%% Stage 2
bf1_stage2 = Butterfly(bf1_stage1(z+0), bf5_stage1(z+0), N,Nbits,Nbitsf);
bf2_stage2 = Butterfly(bf2_stage1(z+0), bf6_stage1(z+0), N,Nbits,Nbitsf);
bf3_stage2 = Butterfly(bf3_stage1(z+0), bf7_stage1(z+0), N,Nbits,Nbitsf);
bf4_stage2 = Butterfly(bf4_stage1(z+0), bf8_stage1(z+0), N,Nbits,Nbitsf);

bf5_stage2 = Butterfly(bf1_stage1(z+1), bf5_stage1(z+1)*-1i, N,Nbits,Nbitsf);
bf6_stage2 = Butterfly(bf2_stage1(z+1), bf6_stage1(z+1)*-1i, N,Nbits,Nbitsf);
bf7_stage2 = Butterfly(bf3_stage1(z+1), bf7_stage1(z+1)*-1i, N,Nbits,Nbitsf);
bf8_stage2 = Butterfly(bf4_stage1(z+1), bf8_stage1(z+1)*-1i, N,Nbits,Nbitsf);

%% Stage 3
wn8  = exp(-1i*pi/4);    %  0.7071 - 0.7071i
w3n8 = exp(-1i*pi/4)*-1i; % -0.7071 - 0.7071i

fxwn8 = fi(wn8,1,Nbits,Nbitsf);
wn8fr=real(fxwn8);
wn8fi=imag(fxwn8);


fxw3n8 = fi(w3n8,1,Nbits,Nbitsf);
w3n8fr=real(fxw3n8);
w3n8fi=imag(fxw3n8);


fx1i=fi(-1i,1,Nbits,Nbitsf);





bf1_stage3 = Butterfly(bf1_stage2(z+0), bf3_stage2(z+0), N,Nbits,Nbitsf);
bf2_stage3 = Butterfly(bf2_stage2(z+0), bf4_stage2(z+0), N,Nbits,Nbitsf);

bf3_stage3 = Butterfly(bf1_stage2(z+1), fi(bf3_stage2(z+1)*fx1i,1,4,2), N,Nbits,Nbitsf);
bf4_stage3 = Butterfly(bf2_stage2(z+1), fi(bf4_stage2(z+1)*fx1i,1,4,2), N,Nbits,Nbitsf);

bf5_stage3 = Butterfly(bf5_stage2(z+0), fi(bf7_stage2(z+0)*fxwn8,1,4,2), N,Nbits,Nbitsf);
bf6_stage3 = Butterfly(bf6_stage2(z+0), fi(bf8_stage2(z+0)*fxwn8,1,4,2), N,Nbits,Nbitsf);

bf7_stage3 = Butterfly(bf5_stage2(z+1), fi(bf7_stage2(z+1)*fxw3n8,1,4,2), N,Nbits,Nbitsf);
bf8_stage3 = Butterfly(bf6_stage2(z+1), fi(bf8_stage2(z+1)*fxw3n8,1,4,2), N,Nbits,Nbitsf);

%% Stage 4


w0 = (exp(-1i*2*pi/N))^0; %  1.0000 + 0.0000i
w1 = (exp(-1i*2*pi/N))^1; %  0.9239 - 0.3827i
w2 = (exp(-1i*2*pi/N))^2; %  0.7071 - 0.7071i
w3 = (exp(-1i*2*pi/N))^3; %  0.3827 - 0.9239i
w4 = (exp(-1i*2*pi/N))^4; % -0.0000 - 1.0000i
w5 = (exp(-1i*2*pi/N))^5; % -0.3827 - 0.9239i
w6 = (exp(-1i*2*pi/N))^6; % -0.7071 - 0.7071i
w7 = (exp(-1i*2*pi/N))^7; % -0.9239 - 0.3827i

fxw0 = fi(w0,1,Nbits,Nbitsf);
w0fr=real(fxw0);
w0fi=imag(fxw0);

fxw1 = fi(w1,1,Nbits,Nbitsf);
w1fr=real(fxw1);
w1fi=imag(fxw1);

fxw2 = fi(w2,1,Nbits,Nbitsf);
w2fr=real(fxw2);
w2fi=imag(fxw2);

fxw3 = fi(w3,1,Nbits,Nbitsf);
w3fr=real(fxw3);
w3fi=imag(fxw3);

fxw4 = fi(w4,1,Nbits,Nbitsf);
w4fr=real(fxw4);
w4fi=imag(fxw4);

fxw5 = fi(w5,1,Nbits,Nbitsf);
w5fr=real(fxw5);
w5fi=imag(fxw5);

fxw6 = fi(w6,1,Nbits,Nbitsf);
w6fr=real(fxw6);
w6fi=imag(fxw6);

fxw7 = fi(w7,1,Nbits,Nbitsf);
w7fr=real(fxw7);
w7fi=imag(fxw7);


fid=fopen ('coefficientes0.txt','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w4fr.bin w4fi.bin '\n']);
fprintf(fid,[w4fr.bin w4fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w4fr.bin w4fi.bin '\n']);
fprintf(fid,[w4fr.bin w4fi.bin '\n']);
fclose(fid);

fid=fopen ('coefficientes1.txt','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[wn8fr.bin wn8fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[wn8fr.bin wn8fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fclose(fid);



fid=fopen ('coefficientes2.txt','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w3n8fr.bin w3n8fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w4fr.bin w4fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w3n8fr.bin w3n8fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w4fr.bin w4fi.bin '\n']);
fclose(fid);


fid=fopen ('coefficientes3.txt','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w2fr.bin w2fi.bin '\n']);
fprintf(fid,[w1fr.bin w1fi.bin '\n']);
fprintf(fid,[w3fr.bin w3fi.bin '\n']);
fclose(fid);


fid=fopen ('coefficientes4.txt','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w4fr.bin w4fi.bin '\n']);
fprintf(fid,[w6fr.bin w6fi.bin '\n']);
fprintf(fid,[w5fr.bin w5fi.bin '\n']);
fprintf(fid,[w7fr.bin w7fi.bin '\n']);
fclose(fid);



bf1_stage4 = Butterfly(bf1_stage3(z+0), bf2_stage3(z+0), N,Nbits,Nbitsf);

bf2_stage4 = Butterfly(bf1_stage3(z+1), fi(bf2_stage3(z+1)*fxw4,1,4,2), N,Nbits,Nbitsf);

bf3_stage4 = Butterfly(bf3_stage3(z+0), fi(bf4_stage3(z+0)*fxw2,1,4,2), N,Nbits,Nbitsf);

bf4_stage4 = Butterfly(bf3_stage3(z+1), fi(bf4_stage3(z+1)*fxw6,1,4,2), N,Nbits,Nbitsf);

bf5_stage4 = Butterfly(bf5_stage3(z+0), fi(bf6_stage3(z+0)*fxw1,1,4,2), N,Nbits,Nbitsf);

bf6_stage4 = Butterfly(bf5_stage3(z+1), fi(bf6_stage3(z+1)*fxw5,1,4,2), N,Nbits,Nbitsf);

bf7_stage4 = Butterfly(bf7_stage3(z+0), fi(bf8_stage3(z+0)*fxw3,1,4,2), N,Nbits,Nbitsf);

bf8_stage4 = Butterfly(bf7_stage3(z+1), fi(bf8_stage3(z+1)*fxw7,1,4,2), N,Nbits,Nbitsf);

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

DFT16pRadix8 = [bf1_stage4(z+0), bf5_stage4(z+0), bf3_stage4(z+0), bf7_stage4(z+0), ...
                bf2_stage4(z+0), bf6_stage4(z+0), bf4_stage4(z+0), bf8_stage4(z+0), ...
                bf1_stage4(z+1), bf5_stage4(z+1), bf3_stage4(z+1), bf7_stage4(z+1), ...
                bf2_stage4(z+1), bf6_stage4(z+1), bf4_stage4(z+1), bf8_stage4(z+1) ];

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

