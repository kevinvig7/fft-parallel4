%% Inicio
clc; close all; clear;

filtro = fir1(31,0.04,'low'); % filtro fir
filtrow = fft(filtro,1024);   % filtro fir en el dominio de la frecuencia
plot((0:512)/1024*50e3,20*log10(abs(filtrow(1:513))))   % grafica de respuesta en frecuencia para punto flotante

filtro_fx = fi(filtro,1,12,11);   %filtro fir en punto fijo
filtrow_fx = fft(filtro_fx.double,1024); %filtro fir en punto fijo en el dominio de la frecuencia 
hold all
plot((0:512)/1024*50e3,20*log10(abs(filtrow_fx(1:513))))  % grafica de respuesta en frecuencia para punto fijo

fid=fopen ('coef_filter.txt','wt'); %guardo un archivo con los coef. cuantizados del filtro
for i=1:length(filtro_fx)
    fx = filtro_fx(i);
    fprintf(fid,[fx.dec '\n']);
end

%% Señal
% se�al compuesta formada por la suma de un tono de 500hz y otro de 5khz.
a1 = sin(2*pi*500/50e3*(0:999))+sin(2*pi*5e3/50e3*(0:999));    
% normalizamos la amplitud maxima de la se�al, para que no haya armonicos
a = a1/max(a1);
% se�al de salida completada con ceros
y = zeros(1,1000);    
pp = zeros(1,32);     

for n=1:length(a)-length(filtro)+1
    accum = 0;
    for i=1:length(filtro)
        pp(i) = a(n+length(filtro)-i)*filtro(i);
        accum = accum +pp(i);
    end
    y(n) = accum;
end

a_fx = fi(a,1,12,11);
y_fx = fi(zeros(1,1000),1,12,11,'RoundingMethod','floor','OverflowAction','wrap');
% seguir las reglas de producto de las filminas
pp_fx = fi(zeros(1,32),1,22,20,'RoundingMethod','floor', 'OverflowAction','wrap');
% seguir las reglas de suma de las filminas
accum_fx = fi(0,1,22+5,20,'RoundingMethod','floor','OverflowAction','wrap');
% 24+logen base 2 de cantidad de taps

% guardo un archivo con los coef. cuantizados de la se�al compuesta de entrada
fid = fopen ('entrada.txt','wt'); 
for i=1:length(a_fx)
    fx = a_fx(i);
    fprintf(fid,[fx.dec '\n']);
end

for n=1:length(a)-length(filtro)+1
    accum_fx.double = 0;
    for i=1:length(filtro)
        pp_fx.double(i) = a_fx.double(n+length(filtro)-i)*filtro_fx.double(i);
        accum_fx.double = accum_fx.double + pp_fx.double(i);
    end
    y_fx.double(n) = accum_fx.double;
end

% grafico entrada y salida en el dominio del tiempo
figure(2)
plot(a_fx.double)
hold all
plot(y_fx.double)

aw_fx = fft(a_fx.double,1024);
yw_fx = fft(y_fx.double,1024);

% grafico entrada y salida en el dominio de la frecuencia
figure(3) 
plot((0:512)/1024*50e3,20*log10(abs(aw_fx(1:513))))   
hold all
plot((0:512)/1024*50e3,20*log10(abs(yw_fx(1:513))))

% guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fid = fopen ('salida.txt','wt'); 
for i=1:length(y_fx)
    fx = y_fx(i);
    fprintf(fid,[fx.dec '\n']);
end

% se divide por el max de y_fx.double y se multiplica por el max de y para que 
% no distorsione la diferencia de amplitud entre ambas.
snr = 10*log10(var(y)/var(y-y_fx.double/max(y_fx.double)*max(y)))
