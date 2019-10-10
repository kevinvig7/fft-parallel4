%% Datos desde la web de Matlab
% Perform Fixed-Point Arithmetic
clc;
clear;
% Save warning states before beginning.
warnstate = warning;

% el dato c, sufrio un incremento de 1bit
a = ufi(0.234375,4,6);
c = a + a;

a.bin;
c.bin;

% the sign extension required to correctly represent the result.
a = sfi(0.078125,4,6);
b = sfi(-0.125,4,6);
c = a + b;
a.bin;
b.bin;
c.bin;

% If you add or subtract two numbers with different precision, 
% the radix point first needs to be aligned to perform the operation.
a = sfi(pi,16,13);
b = sfi(0.1,12,14);
c = a + b;

%%%%%%%%%%%%%%%%%%%
% Since scalar additions are performed at each iteration in the for-loop, a bit is added to temp during each 
% iteration. As a result, instead of a ceil(log2(Nadds)) bit-growth, the bit-growth is equal to Nadds.

% s = rng; rng('default');
% b = sfi(4*rand(16,1)-2,32,30);
% rng(s); % restore RNG state
% Nadds = length(b) - 1;
% temp  = b(1);
% for n = 1:Nadds
%     temp = temp + b(n+1); % temp has 15 more bits than b
% end

% If the sum command is used instead, the bit-growth is curbed as expected.
% c = sum(b) % c has 4 more bits than b
%%%%%%%%%%%%%%%%%%

% Multiplication: a full precision product requires a word 
% length equal to the sum of the word lengths of the operands.
a = sfi(pi,20);
b = sfi(exp(1),16);
c = a * b

%% https://la.mathworks.com/help/fixedpoint/examples/perform-fixed-point-arithmetic.html
%% Assignment: Ir a la web mencionada arriba
% En una multiplicacion en un 'for': 
% c(n) = a(n).*b(n); 
% the right-hand-side of the expression is quantized by rounding to nearest and then saturating

%% Quantizing Results Explicitly
% y(n) = x(n) - quantize(a.*z, true, 16, 14, 'Floor', 'Wrap');

%% Modeling Accumulators
% The behavior corresponds to the += and -= operators in C

x = sfi(2*rand(300,1)-1,16,15);     % Input data
z = sfi(zeros(256,1),16,15);        % Used to store the states
b = sfi(1/256*[1:128,128:-1:1],16); % Filter coefficients
y = sfi(zeros(size(x)),40,31);      % Initialize Output data
for n = 1:length(x)
    acc = sfi(0,40,31); % Reset accumulator
    z(1) = x(n);        % Load input sample
    for k = 1:length(b)
        acc = accumpos(acc,b(k).*z(k)); % Multiply and accumulate
    end
    z(2:end) = z(1:end-1); % Update states
    y(n) = acc;            % Assign output
end

%% Modeling a Counter
% Since the 3-bit counter naturally "wraps" back to 0 after reaching 7,
% the final value of the counter is mod(20,8) = 4.
c = ufi(0,3,0);
Ncounts = 20; % Number of times to count
for n = 1:Ncounts
    c = accumpos(c,1);
    c.bin;
end

% Restore warning states.
warning(warnstate);
%#ok<*NASGU,*NOPTS>



