%% Registros v2
clc; close all; clear;

% Numero de Latencia 
numreg = 3;
InReg = zeros(1,numreg);  
% Estructuras de Latencia
D.ff = struct('d',0, 'q',0);
% replico FlipFlops
Lat = repmat(D, 1,numreg);

% Transiciones Clock:
% 1clk: 0->1
% 2clk: 1->2
% 3clk: 2->3
for clk = (0:3)
    
    % Dato de entrada
    in1 = 5;
    InReg(1) = in1;
    % Asignacion de Datos al Registro
    [OutLat, OutReg] = RegIn(Lat, InReg);
    
    % Procesamiento de Datos
    OutReg
    InReg(3);
    
    % Actualizo Registros
    [Lat, InReg] = RegUp(OutLat, InReg);
    
end

%% Registros Dato de Entrada
function [OutLat, OutReg] = RegIn(Lat, InReg)

% De InReg a Lat.ff
Lat(1).ff.d = InReg(1);
Lat(2).ff.d = InReg(2);
Lat(3).ff.d = InReg(3);

% salida de toda la Latencia
OutLat = Lat;
% salida del ultimo registro
OutReg = Lat(3).ff.q;

end

%% Registros Dato Actualizados
function [OutLat1, InReg1] = RegUp(OutLat, InReg)

% Transfiero datos de entrada de un FlipFlop a su salida
OutLat(1).ff.q = OutLat(1).ff.d;
OutLat(2).ff.q = OutLat(2).ff.d;
OutLat(3).ff.q = OutLat(3).ff.d;
 
% Actualizo el InReg, se desplaza una muestra
InReg(2) = OutLat(1).ff.q;
InReg(3) = OutLat(2).ff.q;

% Asignacion
OutLat1 = OutLat;
InReg1 = InReg;

end
