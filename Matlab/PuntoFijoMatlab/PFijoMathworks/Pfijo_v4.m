%% Cast fi Objects
clc;
clear;

A = int8(0);
B = int16(32767);
A = B;
class(A);

% Casting by Subscripted Assignment
% The following subscripted assignment statement retains the 
% type of A and saturates the value of B to an int8:
A = int8(0);
B = int16(32767);
A(:) = B;
class(A);

fipref('NumericTypeDisplay', 'short');
A = fi(0, 1, 8, 0);
B = fi(32767, 1, 16, 0);
A(:) = B;

% valor: 0.0146
% signo: s5,10

% Using a numerictype Object in the fi Conversion Function
T8 = numerictype(1,8,0);
T16 = numerictype(1,16,0);
B = fi(32767,T16);
A = fi(B, T8);

% Casting with the reinterpretcast Function
% B is an unsigned fi object with a word length of 8 bits and a fraction length of 5 bits. The 
% reinterpretcast function  converts B into a signed fi object A with a word length of 8 bits and a fraction length of 1 bit.
B = fi([pi/4 1 pi/2 4], 0, 8, 5);
T = numerictype(1, 8, 1);
A = reinterpretcast(B, T);
% The real-world values of A and B differ, but their binary representations are the same.
binary_B = bin(B);
binary_A = bin(A);

% Casting with the cast Function
fipref('NumericTypeDisplay', 'full');
a = pi;
b = fi([],1,16,13,'RoundingMethod', 'Floor'); 
c= cast(a,'like',b);

%% Perform Binary-Point Scaling
a = fi(0.5,true,8,7);

a = fi(-0.5,true,3,1);  % 0.5
bin(a);                 % '111' cadena de caracteres
dec(a);                 % '7'   cadena de caracteres
storedInteger(a)        % -1    equivalente entero

%% The Fraction Length is Positive and Greater than the Word Length
% a signed 3-bit word with fraction length of 4 and value of -0.0625 is ._111
% The first 1 after the _ is the MSB or the sign bit.
% The real world value of -0.0625 is computed as follows:
% (1*2^-4) + (1*2^-3) + (-1*2^-2) = -0.0625
clc;
b = fi(-0.0625,true,3,4);
bin(b); % se imprime '111', no es visible el valor de ._111
storedInteger(b)

%%% The Fraction Length is a Negative Integer and Less than the Word Length
c = fi(-4,true,3,-2);
bin(c);
storedInteger(c);

%%% The Fraction Length is Set Automatically to the Best Precision Possible and is Negative
%  011_. = (1*2^1) + (1*2^2) + (-0*2^3) = 6
d = fi(5,true,3),
bin(d);
storedInteger(d);

%% Ir a tabla de Bit Growth de Mtalab
a = fi(pi,1,16,13);  % s(16,13)
b = fi(0.1,1,12,14); % s(12,14)
c = a + b;           % s(18,14)

%% The fimath Object
% fimath properties define the rules for performing arithmetic operations on fi objects, including math, rounding, and overflow properties. 
% A fi object can have a local fimath object, or it can use the default fimath properties. 
% You can attach a fimath object to a fi object by using setfimath
clc
a = fi(5,1,16,4,'ProductMode','KeepMSB');

%% Bit Growth
% The word length of acc increases with each iteration of the loop. 
% This increase causes two problems: One is that code generation does not allow changing data types in a loop. 
% The other is that, if the loop is long enough, you run out of memory in MATLAB
clc; clear;
T.acc = fi([],1,32,0);
T.x = fi([],1,16,0);

x = cast(1:3,'like',T.x);
acc = zeros(1,1,'like',T.acc);

for n = 1:length(x)
    acc = acc + x(n)
end
    
%% Controlling Bit Growth - fimath Object Properties
% https://la.mathworks.com/help/fixedpoint/ug/fimath-object-properties.html
% The fi object a has a local fimath object F.
% F specifies the word length and fraction length of the sum. 
clc; clear;
F = fimath('SumMode', 'SpecifyPrecision', 'SumWordLength', 8,...
           'SumFractionLength', 0);
a = fi(8,1,8,0, F);
b = fi(3, 1, 8, 0);
c = a+b;

%%%
% You can also use fimath properties to control bit growth in a for-loop.
fipref('NumericTypeDisplay', 'short');
F = fimath('SumMode', 'SpecifyPrecision','SumWordLength',32,...
           'SumFractionLength',0);
T.acc = fi([],1,32,0,F);
T.x = fi([],1,16,0);

x = cast(1:3,'like',T.x);
acc = zeros(1,1,'like',T.acc);

for n = 1:length(x)
    acc = acc + x(n);
end

%%%
% Subscripted Assignment
% Another way to control bit growth is by using subscripted assignment. a(I) = b
% Evita que la variable 'acc' crezca en número de bits
T.acc = fi([],1,32,0);
T.x = fi([],1,16,0);

x = cast(1:3,'like',T.x);
acc = zeros(1,1,'like',T.acc);

% Assign in to acc without changing its type
for n = 1:length(x)
    acc(:) = acc + x(n) % acc(1) = acc + x(n); % Misma accion
end

%% accumpos and accumneg
% Another way you can control bit growth is by using the accumpos and accumneg 
% functions to perform addition and subtraction operations. 

%% Overflows
% Overflows can occur when the result of an operation exceeds the maximum or 
% minimum representable value. The fimath object has an OverflowAction property which offers 
% two ways of dealing with overflows: saturation and wrap.

%% Rounding 
% ceil; convergent; floor; nearest;round; fix

%% fimath Object Properties - Math, Rounding, and Overflow Properties
% https://la.mathworks.com/help/fixedpoint/ug/fimath-object-properties.html

% CastBeforeSum
% MaxProductWordLength
% ProductMode: FullPrecision, KeepLSB, KeepMSB, SpecifyPrecision
% OverflowAction
% RoundingMethod
%     Nearest (default), Round toward nearest. Ties round toward positive infinity.
%     Ceiling — Round toward positive infinity.
%     Convergent — Round toward nearest. Ties round to the nearest even stored integer (least biased).
%     Zero — Round toward zero.
%     Floor — Round toward negative infinity.
%     Round — Round toward nearest. Ties round toward negative infinity for negative numbers, and toward positive infinity for positive numbers.
% 
% SumFractionLength
% SumMode

F = fimath('OverflowAction','Saturate','RoundingMethod','Convergent')
% to get the RoundingMethod of F
F.RoundingMethod
% To set the OverflowAction of F,
F.OverflowAction = 'Wrap'
