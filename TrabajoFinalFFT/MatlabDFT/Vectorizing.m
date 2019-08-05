%% using loops
% Ejemplo de un sitio Web
clear
N = 1e6;
tstart = cputime ;
for k = 1:N
    x(k) = k;
    y(k) = N - k + 1;
end
for k = 1:N
    z(k) = x(k) + y(k);
end
tstop = cputime ;
fprintf (1, ' Time using loops = %.3f\n ' , tstop - tstart);

%% preallocated using loops
clear 
N = 1e6;
tstart = cputime ;
x = zeros (N, 1);
y = zeros (N, 1);
z = zeros (N, 1);
for k = 1:N
    x(k) = k;
    y(k) = N - k + 1;
end
for k = 1:N
    z(k) = x(k) + y(k);
end
tstop = cputime ;
fprintf (1, ' Using preallocation = %.3f\n ' , tstop - tstart);

%% using vectorized code
clear
N = 1e6;
tstart = cputime ;
k = 1:N;
x = k;
y = N - k + 1;
z = x + y;
tstop = cputime ;
fprintf (1, ' Using vectorization = %.3f\n ' , tstop - tstart);

%% test
clear
N = 1000;
x = rand (N, 1);

plot (x);
sound (x, 8000);







