%% Set Fixed-Point Math Attributes
clear; clc; close all;
% Bit Growth
% https://la.mathworks.com/help/fixedpoint/gs/fixed-point-arithmetic_bt25flf-1.html

%% PROGRAMA
clear; clc; close all;

%%%
% Rounding Method
% ceil:   in the direction of positive infinity.
% floor:  in the direction of negative infinity, equivalent to two’s complement truncation.
% nearest:in the direction of positive infinity. 
% round:  Positive numbers: in the direction of positive infinity.
%         Negative numbers: in the direction of negative infinity.
% fix:    in the direction of zero.
%%%
%%%
% F = fimath;
% F.RoundingMethod = 'Floor';
% F.OverflowAction = 'Wrap';
% 
% fimath( 'RoundingMethod',   'Nearest', ...
%         'OverflowAction',   'Saturate', ...
%         'ProductMode',      'FullPrecision', ...
%         'SumMode',          'FullPrecision');
%%%

y = sum(5, 1);

n_original = 2^2+2^0+2^(-1)+2^(-2)+2^(-3); %000101,111 = 5.875 s(9,3)
n_truncado = 2^2+2^0+2^(-1)+2^(-2);
n_inf_pos  = 2^2+2^1;
n_cero_pos = 2^2+2^0 + 2^(-1)+2^(-2);

a = fi(3.63,1,7,3);
b = fi(2.3, 1,7,2);
       
c = a+b;
c.bin;
c_fi = fi(c,1,8,2,'RoundingMethod', 'nearest');
c_fi.bin;

% Test POSITIVO
% Redondeo: Truncado de 'a'
% documentacion: the direction of negative infinity
a;
a.bin;
aTruncado = fi(a,1,6,2,'RoundingMethod', 'Floor' );
aTruncado.bin;
% Redondeo: Infinito '+'
aInfPos = fi(a,1,6,2,'RoundingMethod', 'Ceiling' );
aInfPos.bin;
% Redondeo: Usando 'nearest'. La documentacion: direction of positive infinity. 
aNear = fi(a,1,6,2,'RoundingMethod', 'Nearest' );
aNear.bin;
% Redondeo: en la direccion de cero 
aCero = fi(a,1,6,2,'RoundingMethod', 'Zero' );
aCero.bin;

% Test NEGATIVO
a_neg = fi(-3.63, 1,7,3);
a_neg.bin;
% Truncado
aNegTruncado = fi(a_neg,1,6,2,'RoundingMethod', 'Floor' );
aNegTruncado.bin;
% Redondeo con +1, no importa el signo
aNegInfPos = fi(a_neg,1,6,2,'RoundingMethod', 'nearest' );
aNegInfPos.bin;

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
% Casting with the cast Function
% FimathDisplay: {full, none}
fipref('NumericTypeDisplay', 'full');
a = pi;
b = fi([],1,16,13,'RoundingMethod', 'Floor'); 
c= cast(a,'like',b);

% Tipo de dato
T8 = numerictype(1,8,0);
T16 = numerictype(1,16,0);
B = fi(32767,T16);
A = fi(B, T8);

% Separating the data types of your variables from your algorithm
T.z = fi([],1,16,0);
z = zeros(2,3,'like',T.z);

% F specifies the word length and fraction length of the sum. 
F = fimath('SumMode', 'SpecifyPrecision', 'SumWordLength', 8,...
           'SumFractionLength', 0);
a = fi(8,1,8,0, F);
b = fi(3, 1, 8, 0);
c = a+b;

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