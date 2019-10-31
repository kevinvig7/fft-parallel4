function [out] = VecOrdMat(in)

% Se ingresa a la funcion con vector de informacion 'in', el cual luego es
% ordenado de acuerdo a los indices de datos que ingresan al diagrama de
% butterflys 'datos', luego este nuevo vector el cual posee un orden de sus
% muestras distintos al original se los convierte a una Matriz de 4xn 'matriz'

% in     = [0,1,2,3,4, 5,6, 7,8, 9,10,11,12,13,14,15];
% datos  = [0,8,1,9,2,10,3,11,4,12, 5,13, 6,14, 7,15];
% matriz = [0, 2, 4, 6;
%           8,10,12,14;
%           1, 3, 5, 7;
%           9,11,13,15];

N = length(in);
datos = zeros(1,N);
cnt = 0;

for pnt = (0:N/2-1)
    for index = (1+pnt:N/2:N)
        cnt = cnt+1;
        datos(cnt) = in(index);
    end
end

% Ceacion de una Matriz de: 4xn
filas = 4;
matriz = zeros(filas,floor(N/filas));

for columnas = (1:length(matriz))
    n1 = 1+4*(columnas-1);
    n2 = 4+4*(columnas-1);
    matriz(:,columnas) = datos(n1:n2);
end
out = matriz;

end
