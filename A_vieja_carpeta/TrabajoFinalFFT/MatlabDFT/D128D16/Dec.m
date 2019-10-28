function [ dec ] = Dec( out )

% Decima la secuencia de entrada en 2
% Primero las posiciones pares, segundo las impares y luego las cancatena.
dec = [];
for index = (1:2)
    dec1 = out(index:2:end);
    dec = [dec, dec1];
end

end

