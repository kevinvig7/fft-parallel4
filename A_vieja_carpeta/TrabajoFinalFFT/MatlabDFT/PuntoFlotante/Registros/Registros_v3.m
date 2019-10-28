%% Registros v3
clc; close all; clear;

% Numero de Latencia 
numreg = 3;
InReg = zeros(1,numreg);  
% Estructuras de Latencia
D.ff = struct('d',0, 'q',0);
% replico FlipFlops
Lat = repmat(D, 1,numreg);

% Transiciones Clock: Comwnzandpo desde el '0'.
% 1clk: 0->1
% 2clk: 1->2
% 3clk: 2->3
for clk = (0:3)
    
    % Dato de entrada
    InReg(1) = 5;
    % Asignacion de Datos al Registro
    [OutLat, OutReg] = RegIn(Lat, InReg);
    
    % Procesamiento de Datos
    % Dato de salida
    OutReg
    InReg(end);
    
    % Actualizo Registros
    [Lat, InReg] = RegUp(OutLat, InReg);
    
end

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
