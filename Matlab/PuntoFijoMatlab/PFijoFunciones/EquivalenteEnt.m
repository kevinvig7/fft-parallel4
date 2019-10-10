function [out] = EquivalenteEnt(in)

% "Entero equivalente" de la representacion binaria. Hacepta matrices
if(class(in)=='embedded.fi')   
   
    [row,column] = size(in);
    EntEq = zeros(row,column);

    for fila = (1:row)
        for columna = (1:column)
            Decimal = in(fila,columna);
            EntEq(fila,columna) = str2double(Decimal.dec);   
        end
    end
    
    out = EntEq;      
else
    % Si no es del tipo 'embedded.fi', te retorna el mismo valor de entrada
    out = in;
end

end


