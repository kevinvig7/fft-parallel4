%Hola

% GENERO SE�AL


a1=sin(2*pi*500/50e3*(0:999))+sin(2*pi*5e3/50e3*(0:999));    %se�al compuesta formada por la suma de un tono de 500hz y otro de 5khz.

a2=a1/max(a1);% normalizamos la amplitud maxima de la se�al, para que no haya armonicos


p=nextpow2(length(a2));      %%para hacer el largo de la se�al potencia de 2 llenando de ceros 
a=[a2 zeros(1,(2^p)-length(a2))];

%%Matlab
figure()
subplot 311
plotPYYf(a,50e3);
ylim([-60 0])
xlim([0 10000])


%%Radix 4 floating point
afft_float=radix4FFT1_Float(a);
afft_float = bitrevorder(afft_float);

subplot 312
plot((0:512)/1024*50e3,20*log10(abs(afft_float(1:513)/max(afft_float)))); grid;
xlabel('Frequency (Hz)');ylabel('Magnitude');title('Signal spectrum');
ylim([-60 0])
xlim([0 10000])

%%Radix 4 fixed point
afft_fix=radix4FFT2_FixPt(a);
afft_fix = bitrevorder(afft_fix);

subplot 313
plot((0:512)/1024*50e3,20*log10(abs(afft_fix(1:513)/max(afft_fix)))); grid;
xlabel('Frequency (Hz)');ylabel('Magnitude');title('Signal spectrum');
ylim([-60 0])
xlim([0 10000])






%a_fx=fi(a,1,12,11);
%ay_fx=fi(a,1,12,11,'RoundMode','floor','OverflowMode','wrap'); 

           %datos,signado o no signado, bit enteros, bits fraccionales,
           %RoundMode Method: floor
           %Overflow Method wrap
            
           %Overflow y saturacion sobre la parte entera
           %Truncado y redondeo es sobre la parte fraccional
           

% a_flot=fft(a,1024);
% aw_fx=fft(a_fx.double,1024);
% ayw_fx=fft(ay_fx.double,1024);

%a_flot=FFT_DIF_R2_float(a);
%aw_fx=FFT_DIF_R2(a_fx);
%ayw_fx=FFT_DIF_R2(ay_fx);

%figure() % grafico entrada y salida en el dominio de la frecuencia
%subplot 311
%plot((0:512)/1024*50e3,20*log10(abs(a_flot(1:513))))
%ylim([-50 50])
%subplot 312
%plot((0:512)/1024*50e3,20*log10(abs(aw_fx(1:513))))   
%subplot 313
%plot((0:512)/1024*50e3,20*log10(abs(ayw_fx(1:513))))

% fid=fopen ('salida_aflot.txt','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
% for i=1:length(a_fx)
%     fx=a_fx(i);
%     fprintf(fid,[fx.dec '\n']);
% end

% fid=fopen ('salida_afix.txt','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
% for i=1:length(a_fx)
%     fx=a_fx(i);
%     fprintf(fid,[fx.dec '\n']);
% end
%     
% fid=fopen ('salida_ayfix.txt','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
% for i=1:length(ay_fx)
%     fx=ay_fx(i);
%     fprintf(fid,[fx.dec '\n']);
% end


%fclose('all');