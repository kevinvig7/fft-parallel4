%% Set Fixed-Point Math Attributes
clear; clc; close all;

%% PROGRAMA
y = sum(5, 1);

%% FP
round(3.56); % 4
round(-1.9); % -2
round(-1.5); % -2

format short g
fi(3.613,1,7,4);  % 3.625   % 011.1010
fi(3.613,1,10,7); % 3.6094  % 011.1001110      = 462   -> 462*2^(-7)    = 3.6064
fi(3.613,1,15,12) % 3.613   % 011.100111001111 = 14799 -> 14799*2^(-12) = 3.623
% Valor en Binario: bin(variable_fixed)
% Valor en Decimal: dec(variable_fixed)

%% Diferentes metodos de trabajo
%% In both methods: real_value = Integer_Value*2^(-Fractional_length)

%%% A = 3.013, (W,f) = (8,3)
%%% Method 1:
fi(3.013,1,8,3);  % 3 --> 00011.000   
%%% Method 2:
a = 3.013*2^(+3); % 24.104
b = round(a);     % 24
c = dec2bin(b);   % 11000 --> 00011.000 


%%% A = -9.0514, (W,f) = (14,9)
%%% Method 1:
fi(-9.0514 ,1,14,9)  % -9.0508 --> 10110.111100110  
%%% Method 2:
% La aultima linea de este metodo no funciono como el pfd de referencia
a = -9.0514*2^(+9);   % -4634.3 
b = round(a);         % -4634 
%c = dec2bin(b)       % 10110.111100110

%% Multiplication 1
% a = 3.613; (W,f) = (8,4); 
% b = 2;     (W,f) = (5,2);  
% (W,F) for the result of multiplication is (13,6). 
d = fi(3.613,1,8,4); % 3.625
e = fi(2,1,5,2);     % 2 

% El valor real = 2*3.613 = 7.226
% El valor cuantizado es  = 7.25 S(13,6)

mult = d*e;          % 7.25 -> 0000111.010000 

%% Multiplication 2
% a = 2.13;       (W,f) = (8,5); 
% b = 3.2456;     (W,f) = (12,9);  
% (W,F) for the result of multiplication is (20,14). 
d = fi(2.13,  1, 8,5); % 2.125  
e = fi(3.2456,1,12,9); % 3.2461    

mult = d*e;            % 6.8979 = 000110.11100101111000 

%% Addition.1
% a = 3.613;   (W,f) = (7,3); 
% b = 2.3;     (W,f) = (7,2);
d = fi(3.613,1,7,3); % 3.625
e = fi(2.3,  1,7,2); % 2.25

add = d+e;                  % 5.875 = '000101.111' S(9,3)
adD = fi((2.3+3.613),1,9,3);% 5.875
% Al realizar la suma y luego FixedPoint funciono directamente.

%% Addition.3
% a = -9.613;   (W,f) = (10,5); 
% b = -3.421;   (W,f) = (8,5);
d = fi(-9.613,1,10,5); % -9.625 
e = fi(-3.421,1,8,5);  % -3.4063  

add = d+e;             % -13.0313 = 110010.11111 S(11,5)

%%% Norm Calculation
b = fi(3.25+4.26i, 1, 8, 4); % 3.2500 + 4.2500i
c = abs(b);                  % 5.3750 '0101.0110'

%% Test

    



%% Funciones
function y = sum(a, b)
% Si no usas los argumentos de la funcion, agregas
% y = sum(~, ~)

% Fuerza a los argumentos a tomar nuevos valores
% a = 1; 
% b = 1;

% suma
y = a+b;

end