%% Switch
function [out1, out2] = llave(in1, in2, control)

% for clk = (0:5)    
%     % Genera para n=2: 010101...
%     % Genera para n=3: 012012...
%     % Genera para n=4: 012301...
%     control = mod(clk,4);
% end

if(control==0)
    out1 = in1;
    out2 = in2;
else
    out1 = in2;
    out2 = in1;
end

end
