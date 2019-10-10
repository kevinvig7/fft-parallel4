function [out] = OrdSalidaParhi(in)

%%% Volver a Automatizar esta funcion %%%

% Mediante este metodo de ordenamiento, el cual le paso un puntero que lo toma
% de un vector de referencia para generar ordenamiento.
% Una mejor opcion es que este puntero 'pnt' se genere de forma automatica.

% Orden de salida en el cual van apareciendo las muestras de Dft.
ref = [0,64,1,65,     16,80,17,81,   8,72,9,73,     24,88,25,89,...
       4,68,5,69,     20,84,21,85,   12,76,13,77,   28,92,29,93,...
       2,66,3,67,     18,82,19,83,   10,74,11,75,   26,90,27,91,...
       6,70,7,71,     22,86,23,87,   14,78,15,79,   30,94,31,95,...
       32,96,33,97,   48,112,49,113, 40,104,41,105, 56,120,57,121,...
       36,100,37,101, 52,116,53,117, 44,108,45,109, 60,124,61,125,...
       34,98,35,99,   50,114,51,115, 42,106,43,107, 58,122,59,123,...
       38,102,39,103, 54,118,55,119, 46,110,47,111, 62,126,63,127];

N = length(in);
datos = zeros(1,N);
cnt = 0;
for index = (1:N)
    cnt = cnt+1; 
    pnt = ref(index)+1;
    datos(pnt) = in(cnt);
end
out = datos;

% N = length(in);
% datos = zeros(1,N);
% cnt = 0;
% for OddEven = (1:2)
%     for bf = (OddEven:2:N/4)
%         for index = (1:N/2:N)
%             index;
%         end
%     end
% end

end