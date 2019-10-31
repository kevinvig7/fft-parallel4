function [out] = OrdSalida(in)

%%% Test: Probar este ordenamiento para N:128p %%%

% Se ingresa a la funcion con vector de informacion 'in', el cual esta
% desordenado, la funcion solo lo ordena en una determinada forma: 
% in  = [0,8,1,9,2,10,3,11,4,12, 5,13, 6,14, 7,15];
% out = [0,1,2,3,4, 5,6, 7,8, 9,10,11,12,13,14,15];

N = length(in);
datos = zeros(1,N);
cnt = 0;

for pnt = (0:N/2-1)
    for index = (1+pnt:N/2:N)
        cnt = cnt+1; 
        datos(index) = in(cnt);
    end
end

out = datos;

end