%% Inicio
clc; close all; clear;

filtro=fir1(31,0.04,'low'); % filtro fir
filtrow=fft(filtro,1024);   % filtro fir en el dominio de la frecuencia


    
%%plot((0:512)/1024*50e3,20*log10(abs(filtrow(1:513))))   % grafica de respuesta en frecuencia para punto flotante

filtro_fx=fi(filtro,1,12,11);   %filtro fir en punto fijo
filtrow_fx=fft(filtro_fx.double,1024); %filtro fir en punto fijo en el dominio de la frecuencia 

%hold all

%%plot((0:512)/1024*50e3,20*log10(abs(filtrow_fx(1:513))))  % grafica de respuesta en frecuencia para punto fijo

fid=fopen ('coef_filter.txt','wt'); %guardo un archivo con los coef. cuantizados del filtro
for i=1:length(filtro_fx)
    fx=filtro_fx(i);
    fprintf(fid,[fx.dec '\n']);
    end



a1=sin(2*pi*500/50e3*(0:999))+sin(2*pi*5e3/50e3*(0:999));    %se�al compuesta formada por la suma de un tono de 500hz y otro de 5khz.
a=a1/max(a1);% normalizamos la amplitud maxima de la se�al, para que no haya armonicos

y=zeros(1,1000);    %se�al de salida completada con ceros

pp=zeros(1,32);     

for n=1:length(a)-length(filtro)+1

accum=0;
	for i=1:length(filtro)

		pp(i)=a(n+length(filtro)-i)*filtro(i);
		accum=accum +pp(i);
	end
y(n)=accum;
end

a_fx=fi(a,1,12,11);
y_fx=fi(zeros(1,1000),1,12,11,'roundmode','floor','overflowmode','wrap'); 
pp_fx=fi(zeros(1,32),1,22,20,'roundmode','floor', 'overflowmode','wrap');%seguir las reglas de producto de las filminas

accum_fx=fi(0,1,22+5,20,'roundmode','floor','overflowmode','wrap');%seguir las reglas de suma de las filminas
                %24+logen base 2 de cantidad de taps
fid=fopen ('entrada.txt','wt'); %guardo un archivo con los coef. cuantizados de la se�al compuesta de entrada
for i=1:length(a_fx)
    fx=a_fx(i);
    fprintf(fid,[fx.dec '\n']);
    end



for n=1:length(a)-length(filtro)+1

accum_fx.double=0;
	for i=1:length(filtro)

		pp_fx.double(i)=a_fx.double(n+length(filtro)-i)*filtro_fx.double(i);
		accum_fx.double=accum_fx.double + pp_fx.double(i);
	end
y_fx.double(n)=accum_fx.double;
end


%%figure(2)% grafico entrada y salida en el dominio del tiempo
%%plot(a_fx.double)
%%hold all
%%plot(y_fx.double)

aw_fx=fft(a_fx.double,1024);
yw_fx=fft(y_fx.double,1024);

%%figure(3) % grafico entrada y salida en el dominio de la frecuencia
%%plot((0:512)/1024*50e3,20*log10(abs(aw_fx(1:513))))   
%%hold all
%%plot((0:512)/1024*50e3,20*log10(abs(yw_fx(1:513))))

fid=fopen ('salida.txt','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
for i=1:length(y_fx)
    fx=y_fx(i);
    fprintf(fid,[fx.dec '\n']);
    end


snr=10*log10(var(y)/var(y-y_fx.double/max(y_fx.double)*max(y)))%se divide por el max de y_fx.double y se multiplica por el max de y para que no distorsione la diferencia de amplitud entre ambas.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('coeff.vhd','wt');
vhd_start = {'library IEEE;',...
'use IEEE.STD_LOGIC_1164.ALL;',...
'use IEEE.STD_LOGIC_ARITH.ALL;',...
'use IEEE.STD_LOGIC_UNSIGNED.ALL;',...
'\n',...
'entity coeff is',...
['port( b : out std_logic_vector( ' num2str(NTAPS*NBI-1) '  downto 0));'],...
'end entity;',...
'architecture behavioral of coeffs is',...
'begin'};

for i=1:length(vhd_start)
    fprintf(fid,[vhd_start{i} '\n']);
end

for i=1 : length(filtro_fx)
   tmp = filtro_fx(i);
   fprintf( fid , ['b(' num2str(i*NBI-1) ' downto ' num2str((i-1)*NBI) ') <= "' tmp.bin '";','\n']); 
end
%%  b(11 downto 0) <= "000000000011";
fprintf(fid,['\n','end architecture behavioral;' , '\n']);
fclose(fid);
