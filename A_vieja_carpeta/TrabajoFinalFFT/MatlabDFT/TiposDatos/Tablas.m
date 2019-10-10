%% Tablas
clear; clc; close all;

LastName      = {'Sanchez';'Johnson';'Li';'Diaz';'Brown'};
Age           = [38;43;38;40;49];
Smoker        = logical([1;0;1;0;1]);
Height        = [71;69;64;67;64];
Weight        = [176;163;131;133;119];
BloodPressure = [124 93; 109 77; 125 83; 117 75; 122 80];

T = table(LastName,Age,Smoker,Height,Weight,BloodPressure)

% Accede a toda la columna
T.LastName
T.Age

% Accede a un solo elemento
% Considerar si a lo que se accede es una Celda u otro tipo de dato
T.Age(1)
T.LastName{1} % Dato
T.LastName(1) % Celda

% Obtengo la Pimer Fila de la Tabla
T(1,:)

%% Idea 1
clear; clc; close all;

% Especificar nombres de fila
InOut    = {'d';'q'};
ff1      = [38;43];
ff2      = [71;69];
ff3      = [176;163];
% La tabla sólo tiene tres variables. Los nombres de fila NO son una variable 
% de tabla, sino una propiedad de la tabla.
Flip = table(ff1,ff2,ff3,'RowNames',InOut)

% Write
Flip('d','ff1') = {5}
% Read
Flip('d','ff1').ff1
Flip('q','ff1').ff1
% Transfiero de una posicion de Tabla a Otra 
Flip('d','ff2') = Flip('q','ff1')


%% Idea 2
clear; clc; close all;

% La tabla Debe de tener igual numero de columnas
% Esta sentencia no puede cumplirse si los variables no tienen igual numero
% de columnas: D1 = [1;0;1;0;1];
D1 = 0;
Q1 = 0;
D2 = 0;
Q2 = 0;

FF = table(D1, Q1, D2, Q2)
% Write
FF.D1 = 5
% Read
FF.D1
% Transferencia
FF.Q1 = FF.D1





