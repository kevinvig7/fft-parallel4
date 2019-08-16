function [ out ] = UnalignAlign( in )

% Esta Funcion logra representar el ordenamiento que poseen los datos al trabajar con una DFT
% Simula Desalineacion (salida de la DFT)
% Simula Alineacion (salida de la DFT --> Bloque de ordenamiento)

% Orden que toma la salida N=128p, 7 etapas de butterfly Radix-8
% En primera instancia la secuencia de datos se encuetra ordenada de
% 1,...,128, luego que la señal atraviesa las primeras etapas de butterflys
% para la señal intermedia toma un orden diferente. Por ultimo, esta nueva
% secuencia vuelve a ingresar a otro conjunto de butterflys, produciendo un
% nuevo cambio en el orden.
% Funcion valida para N = 64,128

%% UnalignAlign
% clc
% clear
% N = 64;
% in16 = [1,9, 5,13, 3,11, 7,15,   2,10, 6,14, 4,12, 8,16];
% in64 = [1 33 17 49 9 41 25 57 5 37 21 53 13 45 29 61 3 35 19 51 11 43 27 59 7 39 23 55 15 47 31 63 ...
%          2 34 18 50 10 42 26 58 6 38 22 54 14 46 30 62 4 36 20 52 12 44 28 60 8 40 24 56 16 48 32 64];

% in = (1:N);
N = length(in);
in_intermedio = (1:N);
out = (1:N);
radix = 8;

% Ecuaciones, i{0,1,...,7} --> index{1,2,...,8}
% C8k+0
% C8k+4
% C8k+2
% C8k+6
% C8k+1
% C8k+5
% C8k+3
% C8k+7

% Orden Intermedio que toma la señal de entrada
for index = 1:N/radix
    in_intermedio(index+0*N/radix) = in( 8*(index-1)+1 );
    in_intermedio(index+1*N/radix) = in( 8*(index-1)+5 );
    in_intermedio(index+2*N/radix) = in( 8*(index-1)+3 );
    in_intermedio(index+3*N/radix) = in( 8*(index-1)+7 );

    in_intermedio(index+4*N/radix) = in( 8*(index-1)+2 );
    in_intermedio(index+5*N/radix) = in( 8*(index-1)+6 );
    in_intermedio(index+6*N/radix) = in( 8*(index-1)+4 );
    in_intermedio(index+7*N/radix) = in( 8*(index-1)+8 );
end

% Orden Final que toma la señal con respecto al orden que tenia la señal
% intermedia.
% Recordar que para N=128p las ultimas etapas de butterflys computan 8 bloques de 16puntos
% En cambio para N=64p las ultimas etapas de butterflys computan 8 bloques de 8puntos

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
        
        % Cada iteracion de out() almacenara N/radix muestras; ej: 64/8=8;
        % 128/8=16 a medida que el cnt aumente.
        out(pnt1) = in_intermedio(n1);
        out(pnt2) = in_intermedio(n2);
        out(pnt3) = in_intermedio(n3);
        out(pnt4) = in_intermedio(n4);

        out(pnt5) = in_intermedio(n5);
        out(pnt6) = in_intermedio(n6);
        out(pnt7) = in_intermedio(n7);
        out(pnt8) = in_intermedio(n8);
    end
end

% out

end
