function [twiddleFi,twiddleFlot,twiddleEq] = TwiddlesPfijo(S,W,F)

%% Twiddles Constantes
wn8  = exp(-1i*pi/4);     %  0.7071 - 0.7071i
w3n8 = exp(-1i*pi/4)*-1i; % -0.7071 - 0.7071i

%% Twiddles Constantes N128
% Indices Obtenidos con otra funcion para la Tercera Etapa
  
% Para n = 0,1,2,...,N/8-1 = 0,...,15 
% W0n = 0;
N = 128;
% W4n = [0 1 2  3  4  5  6  7  8  9  10 11 12 13 14 15];
Nw1  = (exp(-2i*pi/N))^1;  
Nw2  = (exp(-2i*pi/N))^2;  
Nw3  = (exp(-2i*pi/N))^3;  
Nw4  = (exp(-2i*pi/N))^4;  
Nw5  = (exp(-2i*pi/N))^5;  
Nw6  = (exp(-2i*pi/N))^6;  
Nw7  = (exp(-2i*pi/N))^7;  
Nw8  = (exp(-2i*pi/N))^8;  
Nw9  = (exp(-2i*pi/N))^9;  
Nw10 = (exp(-2i*pi/N))^10;  
Nw11 = (exp(-2i*pi/N))^11;  
Nw12 = (exp(-2i*pi/N))^12;  
Nw13 = (exp(-2i*pi/N))^13;  
Nw14 = (exp(-2i*pi/N))^14;  
Nw15 = (exp(-2i*pi/N))^15;  
% W2n = [0 2 4  6  8  10 12 14 16 18 20 22 24 26 28 30];
%Nw2  = (exp(-2i*pi/N))^2;  
%Nw4  = (exp(-2i*pi/N))^4;  
%Nw6  = (exp(-2i*pi/N))^6;  
%Nw8  = (exp(-2i*pi/N))^8;  
%Nw10 = (exp(-2i*pi/N))^10;  
%Nw12 = (exp(-2i*pi/N))^12;  
%Nw14 = (exp(-2i*pi/N))^14;  
Nw16 = (exp(-2i*pi/N))^16;  
Nw18 = (exp(-2i*pi/N))^18;  
Nw20 = (exp(-2i*pi/N))^20;  
Nw22 = (exp(-2i*pi/N))^22;  
Nw24 = (exp(-2i*pi/N))^24;  
Nw26 = (exp(-2i*pi/N))^26;  
Nw28 = (exp(-2i*pi/N))^28;  
Nw30 = (exp(-2i*pi/N))^30;
% W6n = [0 3 6  9  12 15 18 21 24 27 30 33 36 39 42 45];
%Nw3  = (exp(-2i*pi/N))^3;  
%Nw6  = (exp(-2i*pi/N))^6;  
%Nw9  = (exp(-2i*pi/N))^9;  
%Nw12 = (exp(-2i*pi/N))^12;  
%Nw15 = (exp(-2i*pi/N))^15;  
%Nw18 = (exp(-2i*pi/N))^18;  
Nw21 = (exp(-2i*pi/N))^21;  
%Nw24 = (exp(-2i*pi/N))^24;  
Nw27 = (exp(-2i*pi/N))^27;  
%Nw30 = (exp(-2i*pi/N))^30;  
Nw33 = (exp(-2i*pi/N))^33;  
Nw36 = (exp(-2i*pi/N))^36;  
Nw39 = (exp(-2i*pi/N))^39;  
Nw42 = (exp(-2i*pi/N))^42;  
Nw45 = (exp(-2i*pi/N))^45;
% W1n = [0 4 8  12 16 20 24 28 32 36 40 44 48 52 56 60];
%Nw4  = (exp(-2i*pi/N))^4;  
%Nw8  = (exp(-2i*pi/N))^8;  
%Nw12 = (exp(-2i*pi/N))^12;  
%Nw16 = (exp(-2i*pi/N))^16;  
%Nw20 = (exp(-2i*pi/N))^20;  
%Nw24 = (exp(-2i*pi/N))^24;  
%Nw28 = (exp(-2i*pi/N))^28;  
Nw32 = (exp(-2i*pi/N))^32;  
%Nw36 = (exp(-2i*pi/N))^36;  
Nw40 = (exp(-2i*pi/N))^40;  
Nw44 = (exp(-2i*pi/N))^44;  
Nw48 = (exp(-2i*pi/N))^48;  
Nw52 = (exp(-2i*pi/N))^52;  
Nw56 = (exp(-2i*pi/N))^56;  
Nw60 = (exp(-2i*pi/N))^60;
% W5n = [0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75];
%Nw5  = (exp(-2i*pi/N))^5;  
%Nw10 = (exp(-2i*pi/N))^10;  
%Nw15 = (exp(-2i*pi/N))^15;  
%Nw20 = (exp(-2i*pi/N))^20;  
Nw25 = (exp(-2i*pi/N))^25;  
%Nw30 = (exp(-2i*pi/N))^30;  
Nw35 = (exp(-2i*pi/N))^35;  
%Nw40 = (exp(-2i*pi/N))^40;  
%Nw45 = (exp(-2i*pi/N))^45;  
Nw50 = (exp(-2i*pi/N))^50;  
Nw55 = (exp(-2i*pi/N))^55;  
%Nw60 = (exp(-2i*pi/N))^60;  
Nw65 = (exp(-2i*pi/N))^65;  
Nw70 = (exp(-2i*pi/N))^70;  
Nw75 = (exp(-2i*pi/N))^75;
% W3n = [0 6 12 18 24 30 36 42 48 54 60 66 72 78 84 90];
%Nw6  = (exp(-2i*pi/N))^6;  
%Nw12 = (exp(-2i*pi/N))^12;  
%Nw18 = (exp(-2i*pi/N))^18;  
%Nw24 = (exp(-2i*pi/N))^24;  
%Nw30 = (exp(-2i*pi/N))^30;  
%Nw36 = (exp(-2i*pi/N))^36;  
%Nw42 = (exp(-2i*pi/N))^42;  
%Nw48 = (exp(-2i*pi/N))^48;  
Nw54 = (exp(-2i*pi/N))^54;  
%Nw60 = (exp(-2i*pi/N))^60;  
Nw66 = (exp(-2i*pi/N))^66;  
Nw72 = (exp(-2i*pi/N))^72;  
Nw78 = (exp(-2i*pi/N))^78;  
Nw84 = (exp(-2i*pi/N))^84;  
Nw90 = (exp(-2i*pi/N))^90;
% W7n = [0 7 14 21 28 35 42 49 56 63 70 77 84 91 98 105];
%Nw7  = (exp(-2i*pi/N))^7;  
%Nw14 = (exp(-2i*pi/N))^14;  
%Nw21 = (exp(-2i*pi/N))^21;  
%Nw28 = (exp(-2i*pi/N))^28;  
%Nw35 = (exp(-2i*pi/N))^35;  
%Nw42 = (exp(-2i*pi/N))^42;  
Nw49 = (exp(-2i*pi/N))^49;  
%Nw56 = (exp(-2i*pi/N))^56;  
Nw63 = (exp(-2i*pi/N))^63;  
%Nw70 = (exp(-2i*pi/N))^70;  
Nw77 = (exp(-2i*pi/N))^77;  
%Nw84 = (exp(-2i*pi/N))^84;  
Nw91 = (exp(-2i*pi/N))^91;  
Nw98 = (exp(-2i*pi/N))^98;  
Nw105= (exp(-2i*pi/N))^105;

%% Twiddles Constantes N16
n = 16;
w1 = (exp(-2i*pi/n))^1;   %  0.9239 - 0.3827i  :w128^8
w2 = (exp(-2i*pi/n))^2;   %  0.7071 - 0.7071i  :w128^16
w3 = (exp(-2i*pi/n))^3;   %  0.3827 - 0.9239i  :w128^24
w4 = (exp(-2i*pi/n))^4;   % -0.0000 - 1.0000i  :w128^32
w5 = (exp(-2i*pi/n))^5;   % -0.3827 - 0.9239i  :w128^40
w6 = (exp(-2i*pi/n))^6;   % -0.7071 - 0.7071i  :w128^48
w7 = (exp(-2i*pi/n))^7;   % -0.9239 - 0.3827i  :w128^56

% w16^(7) = w128^(7*128/16) = w128(7*8) = w128^(56)

%% Multiplicadores Line1/Line2
% N=128
% Stage1
twiddle1 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1;...
            1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 -1i -1i -1i -1i -1i -1i -1i -1i -1i -1i -1i -1i -1i -1i -1i -1i;...
            1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1;...
            1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 -1i -1i -1i -1i -1i -1i -1i -1i -1i -1i -1i -1i -1i -1i -1i -1i];
% Stage2
twiddle2 = [1 1 1 1 1 1 1 1  1    1    1    1    1    1    1    1   1 1 1 1 1 1 1 1  1    1    1    1    1    1    1    1;...
            1 1 1 1 1 1 1 1 -1i  -1i  -1i  -1i  -1i  -1i  -1i  -1i  1 1 1 1 1 1 1 1 -1i  -1i  -1i  -1i  -1i  -1i  -1i  -1i;... 
            1 1 1 1 1 1 1 1 wn8  wn8  wn8  wn8  wn8  wn8  wn8  wn8  1 1 1 1 1 1 1 1 wn8  wn8  wn8  wn8  wn8  wn8  wn8  wn8;...
            1 1 1 1 1 1 1 1 w3n8 w3n8 w3n8 w3n8 w3n8 w3n8 w3n8 w3n8 1 1 1 1 1 1 1 1 w3n8 w3n8 w3n8 w3n8 w3n8 w3n8 w3n8 w3n8];
% Stage3
twiddle3 = [1 1    1    1    1    1    1    1    1 Nw4  Nw8  Nw12 Nw16 Nw20 Nw24 Nw28  1   1    1    1    1    1    1    1    Nw2 Nw6  Nw10 Nw14 Nw18 Nw22 Nw26 Nw30;... 
            1 Nw8  Nw16 Nw24 Nw32 Nw40 Nw48 Nw56 1 Nw12 Nw24 Nw36 Nw48 Nw60 Nw72 Nw84  Nw4 Nw12 Nw20 Nw28 Nw36 Nw44 Nw52 Nw60 Nw6 Nw18 Nw30 Nw42 Nw54 Nw66 Nw78 Nw90;...
            1 Nw2  Nw4  Nw6  Nw8  Nw10 Nw12 Nw15 1 Nw6  Nw12 Nw18 Nw24 Nw30 Nw36 Nw42  Nw1 Nw3  Nw5  Nw7  Nw9  Nw11 Nw13 Nw14 Nw3 Nw9  Nw15 Nw21 Nw27 Nw33 Nw39 Nw45;...
            1 Nw10 Nw20 Nw30 Nw40 Nw50 Nw60 Nw70 1 Nw14 Nw28 Nw42 Nw56 Nw70 Nw84 Nw98  Nw5 Nw15 Nw25 Nw35 Nw45 Nw55 Nw65 Nw75 Nw7 Nw21 Nw35 Nw49 Nw63 Nw77 Nw91 Nw105];

% n=16
% Stage4
twiddle4 = [1 1  1   1  1 1  1   1  1 1  1   1  1 1  1   1   1 1  1   1  1 1  1   1  1 1  1   1  1 1  1   1;...
            1 1 -1i -1i 1 1 -1i -1i 1 1 -1i -1i 1 1 -1i -1i  1 1 -1i -1i 1 1 -1i -1i 1 1 -1i -1i 1 1 -1i -1i;...
            1 1  1   1  1 1  1   1  1 1  1   1  1 1  1   1   1 1  1   1  1 1  1   1  1 1  1   1  1 1  1   1;...
            1 1 -1i -1i 1 1 -1i -1i 1 1 -1i -1i 1 1 -1i -1i  1 1 -1i -1i 1 1 -1i -1i 1 1 -1i -1i 1 1 -1i -1i];
% Stage5
twiddle5 = [1  1  1 wn8  1  1  1 wn8  1  1  1 wn8  1  1  1 wn8   1  1  1 wn8  1  1  1 wn8  1  1  1 wn8  1  1  1 wn8;...
            1 -1i 1 w3n8 1 -1i 1 w3n8 1 -1i 1 w3n8 1 -1i 1 w3n8  1 -1i 1 w3n8 1 -1i 1 w3n8 1 -1i 1 w3n8 1 -1i 1 w3n8;...
            1  1  1 wn8  1  1  1 wn8  1  1  1 wn8  1  1  1 wn8   1  1  1 wn8  1  1  1 wn8  1  1  1 wn8  1  1  1 wn8;...  
            1 -1i 1 w3n8 1 -1i 1 w3n8 1 -1i 1 w3n8 1 -1i 1 w3n8  1 -1i 1 w3n8 1 -1i 1 w3n8 1 -1i 1 w3n8 1 -1i 1 w3n8];
% Stage6
twiddle6 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  1  w2 w1 w3 1  w2 w1 w3 1  w2 w1 w3 1  w2 w1 w3;... 
            1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  w4 w6 w5 w7 w4 w6 w5 w7 w4 w6 w5 w7 w4 w6 w5 w7;... 
            1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  1  w2 w1 w3 1  w2 w1 w3 1  w2 w1 w3 1  w2 w1 w3;...
            1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  w4 w6 w5 w7 w4 w6 w5 w7 w4 w6 w5 w7 w4 w6 w5 w7];

% Matriz Rotadores en Punto Flotante
twiddleFlot = [twiddle1;twiddle2;twiddle3;twiddle4;twiddle5;twiddle6];

%% Rotadores Punto Fijo
% S: Signo:
% W: Cantidad Total de bits
% F: Cantidad Fraccional

% La clase de la variable es: 'embedded.fi' 
Fmath = fimath('RoundingMethod', 'Floor');
twiddle1Fi = fi(twiddle1, S,W,F, Fmath);
twiddle2Fi = fi(twiddle2, S,W,F, Fmath);
twiddle3Fi = fi(twiddle3, S,W,F, Fmath);
twiddle4Fi = fi(twiddle4, S,W,F, Fmath);
twiddle5Fi = fi(twiddle5, S,W,F, Fmath);
twiddle6Fi = fi(twiddle6, S,W,F, Fmath);

% Matriz Rotadores en Punto Fijo
% twiddleFi = [twiddle1Fi.double;twiddle2Fi.double;twiddle3Fi.double;...
%              twiddle4Fi.double;twiddle5Fi.double;twiddle6Fi.double];
twiddleFi = [twiddle1Fi;twiddle2Fi;twiddle3Fi;...
             twiddle4Fi;twiddle5Fi;twiddle6Fi];

%% Conversion al Equivalente Entero
N = 128;
row = 4;
clm = N/row;

twiddle1Dec = zeros(row,clm);
twiddle2Dec = zeros(row,clm);
twiddle3Dec = zeros(row,clm);
twiddle4Dec = zeros(row,clm);
twiddle5Dec = zeros(row,clm);
twiddle6Dec = zeros(row,clm);

for fila = (1:row)
    for columna = (1:clm)
        Decimal1 = twiddle1Fi(fila,columna);
        twiddle1Dec(fila,columna) = str2double(Decimal1.dec);
        
        Decimal2 = twiddle2Fi(fila,columna);
        twiddle2Dec(fila,columna) = str2double(Decimal2.dec);
        
        Decimal3 = twiddle3Fi(fila,columna);
        twiddle3Dec(fila,columna) = str2double(Decimal3.dec); 
        
        Decimal4 = twiddle4Fi(fila,columna);
        twiddle4Dec(fila,columna) = str2double(Decimal4.dec);        
        
        Decimal5 = twiddle5Fi(fila,columna);
        twiddle5Dec(fila,columna) = str2double(Decimal5.dec);
        
        Decimal6 = twiddle6Fi(fila,columna);
        twiddle6Dec(fila,columna) = str2double(Decimal6.dec);    
    end
end

% Matriz Rotadores Equivalente entero
twiddleEq = [twiddle1Dec;twiddle2Dec;twiddle3Dec;...
             twiddle4Dec;twiddle5Dec;twiddle6Dec];

end

