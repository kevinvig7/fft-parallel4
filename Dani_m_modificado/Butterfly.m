function [ output_butterfly ] = Butterfly( input_a, input_b, N ,Nbits,Nbitsf)
%BUTTERFLY_CLASICO 
N = N;
twiddle_butterfly = -1;

fxtwiddle_butterfly =fi(twiddle_butterfly,1,Nbits,Nbitsf);
fxinput_b=fi(input_b,1,Nbits,Nbitsf);
fxinput_a=fi(input_a,1,Nbits,Nbitsf);

mult=fxtwiddle_butterfly*fxinput_b;
fxmult=fi(mult,1,Nbits,Nbitsf);

% Calculo las 2 salidas
output_a = fxinput_a + fxinput_b;
output_b = fxinput_a + fxmult;
% Asigno vector de salida

fxoutput_a=fi(output_a,1,Nbits,Nbitsf);
fxoutput_b=fi(output_b,1,Nbits,Nbitsf);

output_butterfly = [fxoutput_a, fxoutput_b];

end

%% Uso del Butterfly
% 
% input_a = 1;
% input_b = 1;
% N = 16;
% % Llamo al butterfly
% output_butterfly = Butterfly( input_a, input_b, N );