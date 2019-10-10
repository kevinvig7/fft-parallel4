%% Descripcion de la secuencia de entrada
% Establece en que orden deben de ingresar las muestras al diagrama de butterflys (burbujas)
clc;
clear;
close;

N = 16;
in = (1:N);
out = zeros(1, N);

cnt = 0;
for pnt = (0:N/2-1)
    for index = (1+pnt:N/2:N)
        index;
        cnt = cnt+1;
        out(cnt) = index;
    end
end

% salida
out

%% Ceacion de una Matriz 4xn
datos = out-1;
filas = 4;
matriz = zeros(filas,floor(N/filas));

for columnas = (1:length(matriz))
    n1 = 1+4*(columnas-1);
    n2 = 4+4*(columnas-1);
    matriz(:,columnas) = datos(n1:n2);
end