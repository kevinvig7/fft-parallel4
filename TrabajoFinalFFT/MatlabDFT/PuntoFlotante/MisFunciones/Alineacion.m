function [out] = Alineacion(in)

% Esta misma funcion logra Alinear o Desalinear una secuencia.
% El valor que retorna la funcion cambia de acuerdo, a si el numero de puntos
% 'N' es mayor a 16.

% Indices:
% i{0,1,...,7}->index{1,2,...,8}
N           = length(in);
radix       = 8;
intermedio  = zeros(1,N);
salida      = zeros(1,N);

% Orden Intermedio que toma la señal de entrada
for index = 1:N/radix
    intermedio(index+0*N/radix) = in( 8*(index-1)+1 );
    intermedio(index+1*N/radix) = in( 8*(index-1)+5 );
    intermedio(index+2*N/radix) = in( 8*(index-1)+3 );
    intermedio(index+3*N/radix) = in( 8*(index-1)+7 );

    intermedio(index+4*N/radix) = in( 8*(index-1)+2 );
    intermedio(index+5*N/radix) = in( 8*(index-1)+6 );
    intermedio(index+6*N/radix) = in( 8*(index-1)+4 );
    intermedio(index+7*N/radix) = in( 8*(index-1)+8 );
end

% Orden Final que toma la señal con respecto al orden intermedio, si N>16
for cnt = (0:N/radix:N-(N/radix))
    for index = 1:(N/radix)/radix
        pnt1 = index +0*(N/radix)/radix +cnt;
        pnt2 = index +1*(N/radix)/radix +cnt; 
        pnt3 = index +2*(N/radix)/radix +cnt;
        pnt4 = index +3*(N/radix)/radix +cnt;
        pnt5 = index +4*(N/radix)/radix +cnt;
        pnt6 = index +5*(N/radix)/radix +cnt;
        pnt7 = index +6*(N/radix)/radix +cnt;
        pnt8 = index +7*(N/radix)/radix +cnt;
        
        n1 =  8*(index-1)+1 +cnt;
        n2 =  8*(index-1)+5 +cnt;
        n3 =  8*(index-1)+3 +cnt;
        n4 =  8*(index-1)+7 +cnt;
        n5 =  8*(index-1)+2 +cnt;
        n6 =  8*(index-1)+6 +cnt;
        n7 =  8*(index-1)+4 +cnt;
        n8 =  8*(index-1)+8 +cnt;
        
        % Cada iteracion de salida() almacenara N/radix muestras
        % Ej: 64/8=8, 128/8=16 a medida que el cnt aumente.
        salida(pnt1) = intermedio(n1);
        salida(pnt2) = intermedio(n2);
        salida(pnt3) = intermedio(n3);
        salida(pnt4) = intermedio(n4);

        salida(pnt5) = intermedio(n5);
        salida(pnt6) = intermedio(n6);
        salida(pnt7) = intermedio(n7);
        salida(pnt8) = intermedio(n8);
    end
end

% Decision
if (N<=16)
    out = intermedio;
else
    out = salida;
end

end