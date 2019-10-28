%% Registros Dato Actualizados
function [OutLat1, InReg1] = RegUp(OutLat, InReg)

% Transfiero datos de entrada de un FlipFlop a su salida
for index = (1:length(InReg))
    OutLat(index).ff.q = OutLat(index).ff.d;
end
 
% Actualizo el InReg, se desplaza una muestra
for index = ( 1:length(InReg)-1 )
    InReg(index+1) = OutLat(index).ff.q;
end

% Asignacion
OutLat1 = OutLat;
InReg1 = InReg;

end