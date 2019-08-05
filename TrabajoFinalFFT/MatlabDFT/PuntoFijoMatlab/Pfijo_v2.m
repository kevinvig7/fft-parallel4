%% Teoria desde la web de Matlab

% Fixed-point data types can be either signed or unsigned. Signed binary fixed-point numbers are 
% typically represented in one of three ways:
% Sign/magnitude
% One's complement
% Two's complement
% Two's complement is the most common representation of signed fixed-point numbers and is 
% the only representation used by Fixed-Point Designer™ documentation.

%% OPeraciones a nivel de Bits: BitWise
clc;
clear;
% Create a fixed-point vector.
a = fi([1,2,5,7],0,4,0)
disp(bin(a))

% Concatenate the bits of the elements of a.
y = bitconcat(a)
disp(bin(y))

%% Glorario Punto fijo
% https://la.mathworks.com/help/fixedpoint/ref/glossary.html#f6935

%% Ejemplos
% https://la.mathworks.com/products/fixed-point-designer/code-examples.html
% https://la.mathworks.com/help/fixedpoint/examples.html?s_cid=doc_ftr

%% Data Quantizing
% https://la.mathworks.com/help/fixedpoint/fixed-point-functions.html 
% https://la.mathworks.com/help/dsp/fixed-point-design.html
 
%% Fixed-Point Designer
% https://la.mathworks.com/help/fixedpoint/index.html

%% Recommendations for Arithmetic and Scaling
% https://la.mathworks.com/help/fixedpoint/ug/recommendations-for-arithmetic-and-scaling.html

%% Fixed-Point Designer — Functions
% https://la.mathworks.com/help/fixedpoint/referencelist.html?type=function&s_cid=doc_ftr

%% Create Fixed-Point Data in MATLAB
clc;
clear;
format short

pi;
f = fi(pi);

fi(pi,1,15,12);

fi( (1:3), 0,8,0 );

fi(rand(4),0,12,8);

% Separating the data types of your variables from your algorithm makes testing much simpler.
T.z = fi([],1,16,0);
z = zeros(2,3,'like',T.z)

% specifies a 16-bit signed fractional number with 4 guard bits. 
% The guard bits lie to the left of the default binary point.
sfrac(16,4);













