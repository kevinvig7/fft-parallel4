function [ output_butterfly ] = Butterfly_Adaptado( input_a, input_b, N )
%BUTERFLY_ADAPTADO 
% Para " N=16p ", la siuiente expresión es (-1), por lo cual no modifica el Butterfly
twiddle_butterfly_adaptado = ( exp(-j*2*pi/N) )^8;

% Calculo las 2 salidas
output_a = input_a + input_b;
output_b = input_a + twiddle_butterfly_adaptado*input_b;
% Asigno vector de salida
output_butterfly = [output_a, output_b]; 

end

