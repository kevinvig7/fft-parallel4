%% Estructuras
clear; clc; close all;
% https://la.mathworks.com/help/fixedpoint/ug/convert-fir-filter-to-fixed-point
% -with-types-separate-from-code.html

% Es un tipo de datos que agrupa datos relacionados mediante contenedores de 
% datos denominados campos. Cada campo puede contener cualquier tipo de datos.

s.a = 1;
s.b = {'A','B','C'}

% También puede crear una matriz de estructura
% Valores:
% Valores, especificados como cualquier tipo de Array
% Cualquier entrada value es una matriz de celdas vacía, {}, el resultado es
% Para especificar un único campo vacío, utilice [].

s = struct('x',{'a','b'},'y','c') 
s.x

%% Idea 1
clear; clc; close all;

% Flip = struct(field1,value1, field2,value2)
Flip = struct('ff1',{'d','q'}, 'ff2',{'d','q'}) 
% Se lee: Flip(Fila de dato).Campo
Flip.ff1

d = 1;
q = 2;
% Read
Flip(d).ff1 % Obtengo 'd'
Flip(q).ff1 % Obtengo 'q'
% Write
Flip(d).ff2 = Flip(q).ff1 

%% Idea 2
clear; clc; close all;

% Estructuras Anidadas
% Forma 1
FF.ff1 = struct('d',1, 'q',2)  
FF.ff2 = struct('d',3, 'q',4) 
% Forma 2
Z = struct( 'ff1',struct('d',5, 'q',5),  'ff2',struct('d',5, 'q',5) ) 

% Repetir copias de array
% devuelve una matriz que contiene n copias de A en las cotas de fila y columna.
% Replicacion
D.ff = struct('d',1, 'q',2)
% Sigo utilizando un unico Campo 'ff', pero de 3 Columnas de datos, donde cada
% columna corresponderia a un FlipFlop con 'd, q'
Lat = repmat(D, 1,3)
% Lectura Escritura
Lat(1).ff.d = 1
Lat(1).ff.q = 2
Lat(2).ff.d = 3
Lat(2).ff.q = 4
Lat(3).ff.d = 5
Lat(3).ff.q = 6


%% Estructura con un campo
clear; clc; close all;

field = 'f';
value = {'some text';
         [10, 20, 30];
         magic(5)};
% s = 3 Filas de datos x 1 Columna de Campo     
s = struct(field,value)
% Se lo lee: s(Fila de dato).Campo
s(1).f

% Repeticion
% s: Es una estructura de 3Datos x 1Campo
% Repeticion: Mantiene el mismo Campo, pero Replica 2 veces los 3Datos:

% Usan el mismo Campo'f'
% some_text     some_text
% [10, 20, 30]  [10, 20, 30];
% magic(5)      magic(5)
Repeticion = repmat(s,1,2)
% Se accede 
Repeticion(1,2).f

%% Estructura con varios campos
clear; clc; close all;

%                        1erCol_Campos  2ndCol_Campos
%                        s(1)           s(2)
field1 = 'f1';  value1 = zeros(1,10);
field2 = 'f2';  value2 = {'a',         'b'};
field3 = 'f3';  value3 = {pi,           pi.^2};
field4 = 'f4';  value4 = {'fourth'};

s = struct(field1,value1,field2,value2,field3,value3,field4,value4)

% Accedo al 2nd Campo, Primer elemento
s(1).f2
% Accedo al 2nd Campo, Segundo elemento
s(2).f2

% Si un dato ocupa 2 columnas y otro dato solo una, este ultimo para la segunda
% columna tendra el mismo valor que en la primera
% s(2).f4 == s(1).f4 % seran iguales
% s(3).f4            % gerena error

% Estructura con campo vacío
s = struct('f1','a','f2',[])
% Estructura vacía
s = struct('a',{},'b',{},'c',{})








