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

% Llave
pulsos = 7;
% Muestras
datos = [0, 2, 4, 6;...
         8,10,12,14];

ceros = zeros(2,pulsos-length(datos));
datos = [datos, ceros];

% variables auxiliares
cnt = 0;
DivFrec = 2;

for clk = (0:pulsos-1)
    
    clk;
    % entrada
    in = datos(:,clk+1)
    
    % Divisor de Frecuencia
    % La salida del divisor será la entrada de control de la funcion "llave"
    if(cnt<=DivFrec-1)
        o_frec = 0;
    elseif(cnt>=DivFrec)
        o_frec = 1;
    end
    
    if(cnt==2*DivFrec-1)
        cnt = 0;
    else
        cnt = cnt+1;
    end
    
    % llave
    control = o_frec;
    [out1, out2] = llave(in(1), in(2), control);
    out_switch = [out1; out2]

end

%% Switch
function [out1, out2] = llave(in1, in2, control)

if(control==0)
    out1 = in1;
    out2 = in2;
else
    out1 = in2;
    out2 = in1;
end

end
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
