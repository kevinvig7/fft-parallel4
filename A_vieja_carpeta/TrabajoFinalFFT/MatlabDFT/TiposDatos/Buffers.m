%% Original Algorithm
 
% The formula for the nth output y(n) of an (FIR) filter given filter 
% coefficients b and input x is:

% y(n) = b(1)*x(n) + b(2)*x(n-1) + ... + b(end)*x(n-length(b)+1)

% https://la.mathworks.com/help/fixedpoint/ug/convert-fir-filter-to-fixed-point
% -with-types-separate-from-code.html

%% Linear Buffer Implementation
clear; clc; close all;

% One way is with a linear buffer like in the following function, where b is 
% a row vector and z is a column vector the same length as b.

% It is easy to read and understand. However, it introduces a full copy of the 
% state buffer for every sample of the input.

%% Circular Buffer Implementation
clear; clc; close all;

% To implement the FIR filter more efficiently, you can store the states in a 
% circular buffer, z, whose elements are 
% z(p) = x(n), where p=mod(n-1,length(b))+1, for n=1, 2, 3, ....

% For example, let length(b) = 3, and initialize p and z to:
% p = 0, z = [ 0    0    0  ]



%% Funciones
function [y,z] = fir_filt_linear_buff(b,x,z)
    y = zeros(size(x));
    for n=1:length(x)
        z = [x(n); z(1:end-1)];
        y(n) = b * z;
    end
end

function [y,z,p] = fir_filt_circ_buff_original(b,x,z,p)
    y = zeros(size(x));
    nx = length(x);
    nb = length(b);
    for n=1:nx
        p=p+1; if p>nb, p=1; end
        z(p) = x(n);
        acc = 0;
        k = p;
        for j=1:nb
            acc = acc + b(j)*z(k);
            k=k-1; if k<1, k=nb; end
        end
        y(n) = acc;
    end
end