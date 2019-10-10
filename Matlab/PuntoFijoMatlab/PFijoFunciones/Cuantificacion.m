function [out1, out2] = Cuantificacion(in1,S1,W1,F1, in2,S2,W2,F2, enable)

% in1, in2: Son entradas en Punto Fijo con un determinado valor de bits enteros
% y fracionales, son de clase: 'embedded.fi'

% Cada variable es Cuantizada independientemente con su s(W,F)

% Para cambiar el factor de Cuantizacion, las entradas se convierten a su
% respectivos valores en Flotante para poder ser afectadas por la funcion 'fi()'

%% Fmath
% Sobre el cuaderno estuve realizando operaciones en binario de truncado y
% redondeo sin importar el signo de la señal (siempre sumo +1 redondeo no
% simetrico) y el redondeo simetrico, el cual se necesita saber el signo de la
% señal para sumar 1 o restar 1 hacia infinito+/- o hacia cero.

% Probando la funcion de matlab, llegue a que el uso de 'floor' es equivalente a
% truncar, 'ceiling' es equivalente a redondear sumando siempre 1, 'round'
% redondea simetricamente considerando el signo de la señal. Las demas
% especificacione no las probe del todo.

% Obtener caracteristicas del numero PFijo
% get(C1,'WordLength')
% get(C1,'FractionLength')
% get(C1,'Signed')
% get(C1,'RoundingMethod')

Fmath = fimath('RoundingMethod','Floor',  'OverflowAction','Saturate');
% S: Signo:
% W: Cantidad Total de bits
% F: Cantidad Fraccional

% s(W,F) = Q(W-F,F) = Q(I,F)
% s(8,2) = Q(6,2)

if (strcmp(enable,'true'))
    % Genera una Cuantizacion Nueva
    % Clase: 'embedded.fi' 
    out1 = fi(in1.double, S1,W1,F1, Fmath);
    out2 = fi(in2.double, S2,W2,F2, Fmath);
else 
    % No cambia la Cuantizacion, la mantiene igual que la entrada
    out1 = in1;
    out2 = in2;
end

end

