function [ output_butterfly ] = Butterfly( input_a, input_b, N )
%BUTTERFLY_CLASICO 
N = N;
twiddle_butterfly = -1;

% Calculo las 2 salidas
output_a = input_a + input_b;
output_b = input_a + twiddle_butterfly*input_b;
% Asigno vector de salida
output_butterfly = [output_a, output_b];

end

%% Uso del Butterfly
% 
% input_a = 1;
% input_b = 1;
% N = 16;
% % Llamo al butterfly
% output_butterfly = Butterfly( input_a, input_b, N );