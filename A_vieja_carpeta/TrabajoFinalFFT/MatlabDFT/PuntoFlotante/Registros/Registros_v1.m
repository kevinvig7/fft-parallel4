%% Registros v1
clc; close all; clear;

% Datos
datos = (1:3);
cnt = 0;
% Latencia 
numreg = 3;
RegAux = zeros(1,numreg);  
% Inicializacion
in1 = 5;
RegAux(1) = in1;

% Estructuras
D.ff = struct('d',0, 'q',0);
% replico FlipFlops
OutLat1 = repmat(D, 1,numreg);

for clk = (0:3)
    % ingreso de datos
    in1 = 5;
    RegAux(1) = in1;
    [OutLat, OutReg] = Registros(OutLat1,numreg, clk, RegAux);
    % Procesamiento de Datos
    OutReg
    cnt = cnt+1;
    % Actualizo datos
    [OutLat1, RegAux] = RegUp(OutLat, RegAux);
end



%% Registros Actualizados
function [OutLat1, RegAux1] = RegUp(OutLat, RegAux)

OutLat(1).ff.q = OutLat(1).ff.d;
OutLat(2).ff.q = OutLat(2).ff.d;
OutLat(3).ff.q = OutLat(3).ff.d;
 
RegAux(2) = OutLat(1).ff.q;
RegAux(3) = OutLat(2).ff.q;

% Asignacion
OutLat1 = OutLat;
RegAux1 = RegAux;

end

%% Registros
function [OutLat, OutReg] = Registros(outLat1, numreg, clk, RegAux)

% D.ff = struct('d',0, 'q',0);
% % replico FlipFlops
% Lat = repmat(D, 1,numreg);

Lat = outLat1;

% De RegAux a Lat.ff
Lat(1).ff.d = RegAux(1);
Lat(2).ff.d = RegAux(2);
Lat(3).ff.d = RegAux(3);

% salida del ultimo registro
OutReg = Lat(3).ff.q;
% salida de toda la Latencia
OutLat = Lat;

end
