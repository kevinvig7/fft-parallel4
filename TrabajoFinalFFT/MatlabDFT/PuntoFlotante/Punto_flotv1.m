%% Punto Flotante Paralelo4 - Radix8 - 16puntos
clc; close all; clear;

% Butterfly
in1 = 1;
in2 = 1;
out = zeros(1,2);
[out(1)] = BF(in1, in2);

% Multiplicador
variable = 6;
constante = 6;
Producto = Mult(variable,constante,"true");


%% Multiplicador
function [out] = Mult(variable, constante, enable)

if (enable=='true')
    out = variable*constante;
else
    out = 0;
end

end

%% Butterfly
function [out1, out2] = BF(in1, in2)

out1 = in1+in2;
out2 = in1+(-1*in2);

% Forma 1
% salida = [0, 0];
% [salida(1)] = BF(1,1)

end

%% Persistent
% Clearing the function also clears the persistent variable: clear myFun
function miFun()
    persistent n;
    if isempty(n)
        n = 0;
    end
    n = n+1
end
