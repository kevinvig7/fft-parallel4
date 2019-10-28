%% Registros Dato de Entrada
function [OutLat, OutReg] = RegIn(Lat, InReg)

% De InReg a Lat.ff
for index = (1:length(InReg))
    Lat(index).ff.d = InReg(index);
end
% salida de toda la Latencia
OutLat = Lat;
% salida del ultimo registro
OutReg = Lat(length(InReg)).ff.q;

end