%% Multiplicador
function [out] = Mult(variable, constante, enable)

if (enable=='true')
    out = variable*constante;
else
    out = 0;
end

end