
% GENERO SEÑAL
a1=sin(2*pi*500/50e3*(0:999))+sin(2*pi*5e3/50e3*(0:999));    %señal compuesta formada por la suma de un tono de 500hz y otro de 5khz.
a=a1/max(a1);% normalizamos la amplitud maxima de la señal, para que no haya armonicos









a_fx=fi(a,1,12,11);
ay_fx=fi(a,1,12,11,'roundmode','floor','overflowmode','wrap'); 

           
%%%

% a_flot=fft(a,1024);
% aw_fx=fft(a_fx.double,1024);
% ayw_fx=fft(ay_fx.double,1024);

a_flot=FFT_DIF_R2_float(a);
%aw_fx=FFT_DIF_R2(a_fx);
%ayw_fx=FFT_DIF_R2(ay_fx);

figure() % grafico entrada y salida en el dominio de la frecuencia
%subplot 311
plot((0:512)/1024*50e3,20*log10(abs(a_flot(1:513))))
ylim([-50 50])
%subplot 312
%plot((0:512)/1024*50e3,20*log10(abs(aw_fx(1:513))))   
%subplot 313
%plot((0:512)/1024*50e3,20*log10(abs(ayw_fx(1:513))))

fid=fopen ('salida_aflot.txt','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
for i=1:length(a_fx)
    fx=a_fx(i);
    fprintf(fid,[fx.dec '\n']);
end

% fid=fopen ('salida_afix.txt','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
% for i=1:length(a_fx)
%     fx=a_fx(i);
%     fprintf(fid,[fx.dec '\n']);
% end
%     
% fid=fopen ('salida_ayfix.txt','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
% for i=1:length(ay_fx)
%     fx=ay_fx(i);
%     fprintf(fid,[fx.dec '\n']);
% end


fclose('all');