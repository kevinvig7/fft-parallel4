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

%% Implement FIR Filter Algorithm for Floating-Point
% https://la.mathworks.com/help/fixedpoint/ug/convert-fir-filter-to-fixed-point-with-types-separate-from-code.html

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
z = zeros(2,3,'like',T.z);

% specifies a 16-bit signed fractional number with 4 guard bits. 
% The guard bits lie to the left of the default binary point.
sfrac(16,4);

format long
b = fi(0.1);

% returns the double-precision floating-point "real-world" value of a, quantized to the precision of a.
a = fi(pi);
double(a);

a.double = exp(1);
storedInteger(a);
% set the stored integer from binary, octal, unsigned decimal,
a.bin = '0110010010001000';
a.dec = '22268';

a = fi(pi,'WordLength',20);

%% doc pi
% RealWorldValue = StoredInteger * 2 ^ -FractionLength
% RealWorldValue = 5 * 2 ^ -10 = 0.0049
% Create a signed fi object with a value of 0.0048828125, a word length of 8 bits, and a fraction length of 10 bits.
a = fi(0.0048828125, true, 8, 10);
% Get the stored integer value of a.
a.int;
a.bin;
% Because the fraction length is 2 bits longer than the word length, the binary value of the stored 
% integer is x.xx00000101 , where x is a placeholder for implicit zeros. 0.0000000101 (binary) is equivalent to 0.0049 (decimal).

% Create a signed fi object with a value of 20, a word length of 8 bits, and a fraction length of –2 bits.
a = fi(20, true, 8, -2);
a.int;
a.bin;
% Because the fraction length is negative, the binary value of the stored integer is 00000101xx , where x is a placeholder for implicit 
% zeros. 000000010100 (binary) is equivalent to 20 (decimal).

%% Create a fi Object Specifying Rounding and Overflow
a = fi(pi, 'RoundingMethod', 'Floor', 'OverflowAction', 'Wrap') 
% Remove Local fimath
a = removefimath(a)
a = setfimath(a, fimath('ProductMode', 'KeepLSB'))

%% Numeric Type Properties
T = numerictype
T = numerictype('WordLength',40,'FractionLength',37)
T.Signed = false
a = fi(pi,'numerictype',T)
a1 = fi(pi,T)

%% Display of Real-World Values
format long g
a = sfi(1,8,7)
bin(a)

%% Setup
originalFormat = get(0, 'format');
format loose
format long g
% Capture the current state of and reset the fi display and logging
% preferences to the factory settings.
fiprefAtStartOfThisExample = get(fipref);
reset(fipref);

% Cleanup
% The following code sets any display settings or preferences that the example changed back to their original states.
% Reset the fi display and logging preferences
fipref(fiprefAtStartOfThisExample);
set(0, 'format', originalFormat);
%#ok<*NOPTS,*NASGU>

%%
a = sfi(1,8,7)
a.WordLength
% range(T.x)
range(a)

%% Manage Data Types and Control Bit Growth
% (:)  retains the existing data type and array size. This is particularly important in 
% keeping fixed-point variables fixed point
% acc = 0;
% for n = 1:numel(x)
%   acc(:) = acc + x(n);
% end
