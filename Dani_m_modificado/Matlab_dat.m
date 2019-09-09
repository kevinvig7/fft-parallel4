%xn= [1+1i,0,1+2i,1,2,4,2+9i,6,1,7i,1i,6i,1,0,1,1i];


Nbits=10;
Nbitsf=9;
z=0;

xn=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];


xn_fx=fi(xn,1,Nbits,Nbitsf);

out=DFT16pR8( xn_fx, Nbits,Nbitsf);

%out=real( fftshift(out) );

out_fx=fi(out,1,Nbits,Nbitsf);

fid=fopen ('C:\fft-parallel4\verilog\topfftsrc\v\Entrada_parFFT.dat','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
for z=1:(length(xn_fx)/2)
    fft_inParr=real(xn_fx(2*z-1));
    fft_inPari=imag(xn_fx(2*z-1));
    fprintf(fid,[fft_inParr.bin fft_inPari.bin '\n']);
end
fclose(fid);



fid=fopen ('C:\fft-parallel4\verilog\topfftsrc\v\Entrada_imparFFT.dat','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
for z=1:(length(xn_fx)/2)
    fft_inImparr=real(xn_fx(2*z+1-1));
    fft_inImpari=imag(xn_fx(2*z+1-1));
    fprintf(fid,[fft_inImparr.bin fft_inImpari.bin '\n']);
end
fclose(fid);



%%%%%%%%%%%%%%%%%%%%%%%%%%Salida%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid=fopen ('SalidaFFT.dat','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
for i=1:length(out_fx)
    fft_outr=real(out_fx(i));
    fft_outi=imag(out_fx(i));
    fprintf(fid,[fft_outr.hex fft_outi.hex '\n']);
end
fclose(fid);