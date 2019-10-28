%% Celdas
clear; clc; close all;

% Una matriz de celdas es un tipo de datos 
% cada celda puede contener cualquier tipo de datos. 
% Las matrices de celdas comúnmente contienen listas de texto, combinaciones de 
% texto y números o matrices numéricas de diferentes tamaños.
% 
% Consulte conjuntos de celdas mediante (). 
% Acceda al contenido de las celdas indexando con llaves, {}.

C = { 1,2,3;
     'text',rand(2,3,2),{11; 22; 33} };

% También puede utilizar {} para crear una matriz de celdas vacía de 0 por 0.
C2 = {}
% Crea celda vacia de 2x2
C_vacia      = cell(2)
C_vacia{2,2} = []

% Crear una matriz de celdas con un tamaño especificado, utilice la función cell 
n = (1:2);
C3 = cell(n)

C(1,:); % Lee la primer fila
C(2,:); % Lee la segunda fila
C(:,1); % Lee la primer columna

C{2,1}; % Obtiene la posicion especifica de la Matriz-Celda, el indice

% Clonar el tamaño de la matriz existente
A = [7 9; 2 1; 8 3];
Cz = cell(size(A));

%% Datos de acceso en matriz de celdas
clear; clc; close all;

C = {'one', 'two', 'three';       1, 2, 3}
%  reemplace las celdas de la Primera Fila de C
C(1, 1:3) = {'first','second','third'}
% Reemplazo celdas de la Fila 2, los primeros 2 Elementos
C(2, 1:2) = {'A', 'B'}
% Reemplazo las celdas de la Tercer Columna
C(:,3) = {'fourth', 'fifth'}

%% convertir las celdas a una matriz numérica 
clear; clc; close all;

C = {'one', 'two', 'three';       1, 2, 3}
numericCells = C(2,1:3)
numericVector = cell2mat(numericCells)

% Diferencia entre C(indice) y C{indice}
C(2,1) % Obtiene la Celda
C{2,1} % obtiene el Contenido de la celda

% Asigna un Valor a la Celda
C{2,3} = 30

% Para obtener los valores de Fila 2 numerica, Matlab lo va obteniendo de a uno
C{2,:}
% Guardandolo en un vector
nums = [ C{2,:} ]

%% Generación de una lista separada por comas
clear; clc; close all;

% [2] [6] [10]
% [4] [8] [12]
C = cell(2,3); 
for k = 1:6     
    C{k} = k*2; 
end
C

% Generar una lista a partir de una estructura
C = cell(4,6); 
for k = 1:24     
    C{k} = k*2; 
end
C

% Anteriormente s egenero una Matriz_Celda de 4x6
% Genera una estructura de 6 Campos = 6 columnas de Celdas
% Cada Campo Posee 4 valores correspondientes a columna de la celda
S = cell2struct(C,{'f1','f2','f3','f4','f5','f6'},2)
S.f4;
S.f5;
S.f6;
% Esto es lo mismo que escribir explícitamente
% Lee cada Dato dle Campo f5
S(1).f5, S(2).f5, S(3).f5, S(4).f5


%% Programa
y = sum(5, 1)
%% Funciones
function y = sum(a, b)

y = a+b;

end