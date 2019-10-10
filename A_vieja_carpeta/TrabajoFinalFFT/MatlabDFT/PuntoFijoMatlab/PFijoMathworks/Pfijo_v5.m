%% Set Fixed-Point Math Attributes
clear; clc;
% You can attach a fimath object to a fi object using setfimath. You can remove a fimath object from a fi object using 

% fimath 
% setfimath 
% removefimath

%% PROGRAMA
u = fi(1:10,true,16,11);
y = user_written_sum(u)

%% Mismatched FIMATH
A = fi(pi,'ProductMode','KeepLSB');
B = fi(2,'ProductMode','SpecifyPrecision');
% C = A * B
% El caso anterior producira un error
% To avoid this error, you can remove fimath from one of the variables in the expression.
C = A * removefimath(B)

%% test


%% Funcion
function y = user_written_sum(u)
    % Setup
    F = fimath('RoundingMethod','Floor',...
        'OverflowAction','Wrap',...
        'SumMode','KeepLSB',...
        'SumWordLength',32);
    u = setfimath(u,F);
    y = fi(0,true,32,get(u,'FractionLength'),F);
    % Algorithm
    for i=1:length(u)
        y(:) = y + u(i);
    end
    % Cleanup
    y = removefimath(y);
end