xn= [1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0];
out=DFT16pR8( xn );

out=real( fftshift(out) );

xn_fx=fi(xn,1,8,6);
out_fx=fi(out,1,12,11);

fid=fopen ('EntradaFFT.dat','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
for i=1:length(xn_fx)
    fft_in=xn_fx(i);
    fprintf(fid,[fft_in.bin '\n']);
end
fclose(fid);


fid=fopen ('SalidaFFT.dat','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
for i=1:length(out_fx)
    fft_out=out_fx(i);
    fprintf(fid,[fft_out.bin '\n']);
end
fclose(fid);