%% Referencias para comprender el Punto fijo de Matlab
 
% Best Practices for Converting MATLAB Code to Fixed Point Using Fixed-Point Designer
 
% En la documentacion buscar: Quantization, Fixed-Point Basics in MATLAB (Ways to Construct fi Objects),
% Data Types and Scaling in Digital Hardware.

% fixdt: Create an object describing a fixed-point or floating-point data type

clc;
clear;

% Referencias para utilizar Punto Fijo
i = 10;
A = pi
A = fi(pi, true, 32, 24)

A.int
A.lsb
A.int * A.lsb

B = cast(pi, 'like', A)

a = fi(2)
a = a*a

% Control crecimiento de Bits
a = fi(2,1,8,0)
a(:) = a*a

% Check each user function to see the problem area
% coder.screener('nombre_de_la_funcion')

binario = bin( fi(3.613, 1,7,4) )
bin( fi(3.613, 1,10,7) )
dec2bin(7)


% fi(16, 1, 16)
% numerictype(1, 16, 7)
% fimath('RoundingMethod', 'Round', ...
%     'OverflowAction', 'Saturate', ...
%     'ProductMode', 'FullPrecision', ...
%     'SumMode', 'FullPrecision')