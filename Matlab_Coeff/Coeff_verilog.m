NBITSverilog=8;
NBITScoeff=1+1;
NBITSF=2;
N=8;




%Coeficientes
w0   = (exp(-1i*2*pi/N))^0; %  1.0000 + 0.0000i
w1   = (exp(-1i*2*pi/N))^1; %  0.9239 - 0.3827i
w2   = (exp(-1i*2*pi/N))^2; %  0.7071 - 0.7071i
w3   = (exp(-1i*2*pi/N))^3; %  0.3827 - 0.9239i
w4   = (exp(-1i*2*pi/N))^4; % -1.0000 - 0.0000i
w5   = (exp(-1i*2*pi/N))^5; % -0.3827 - 0.9239i
w6   = (exp(-1i*2*pi/N))^6; % -0.7071 - 0.7071i
w7   = (exp(-1i*2*pi/N))^7; % -0.9239 - 0.3827i
wn8  =       exp(-1i*pi/4); %  0.7071 - 0.7071i
w3n8 =   exp(-1i*pi/4)*-1i; % -0.7071 - 0.7071i

fx1i=fi(1i,1,NBITScoeff,NBITSF);   % 0.0000 + 1.0000i
w1ir=real(fx1i);
w1ii=imag(fx1i);

fxn1i=fi(-1i,1,NBITScoeff,NBITSF); % 0.0000 - 1.0000i
wn1ir=real(fxn1i);
wn1ii=imag(fxn1i);

%%%%%%%%%%%%%%%%%%%
fxw0 = fi(w0,1,NBITScoeff,NBITSF);
w0fr=real(fxw0);
w0fi=imag(fxw0);
%%%%%%%%%%%%%%%%%%%
fxw1 = fi(w1,1,NBITScoeff,NBITSF);
w1fr=real(fxw1);
w1fi=imag(fxw1);
%%%%%%%%%%%%%%%%%%%
fxw2 = fi(w2,1,NBITScoeff,NBITSF);
w2fr=real(fxw2);
w2fi=imag(fxw2);
%%%%%%%%%%%%%%%%%%%
fxw3 = fi(w3,1,NBITScoeff,NBITSF);
w3fr=real(fxw3);
w3fi=imag(fxw3);
%%%%%%%%%%%%%%%%%%%
fxw4 = fi(w4,1,NBITScoeff,NBITSF);
w4fr=real(fxw4);
w4fi=imag(fxw4);
%%%%%%%%%%%%%%%%%%%
fxw5 = fi(w5,1,NBITScoeff,NBITSF);
w5fr=real(fxw5);
w5fi=imag(fxw5);
%%%%%%%%%%%%%%%%%%%
fxw6 = fi(w6,1,NBITScoeff,NBITSF);
w6fr=real(fxw6);
w6fi=imag(fxw6);
%%%%%%%%%%%%%%%%%%%
fxw7 = fi(w7,1,NBITScoeff,NBITSF);
w7fr=real(fxw7);
w7fi=imag(fxw7);
%%%%%%%%%%%%%%%%%%%
fxwn8 = fi(wn8,1,NBITScoeff,NBITSF);
wn8fr=real(fxwn8);
wn8fi=imag(fxwn8);
%%%%%%%%%%%%%%%%%%%
fxw3n8 = fi(w3n8,1,NBITScoeff,NBITSF);
w3n8fr=real(fxw3n8);
w3n8fi=imag(fxw3n8);
%%%%%%%%%%%%%%%%%%%





fid=fopen ('coeff_data0.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
index=0;
fprintf( fid , ['coeff_data(' num2str(N*NBITScoeff*2-1-index*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-index*NBITScoeff*2-NBITScoeff*2) ') = ' num2str(NBITScoeff*2) ''' b =' w0fr.bin w0fi.bin ';','\n']); 
index=1;
fprintf( fid , ['coeff_data(' num2str(N*NBITScoeff*2-1-index*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-index*NBITScoeff*2-NBITScoeff*2) ') = ' num2str(NBITScoeff*2) ''' b =' w0fr.bin w0fi.bin ';','\n']);
index=2;
fprintf( fid , ['coeff_data(' num2str(N*NBITScoeff*2-1-index*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-index*NBITScoeff*2-NBITScoeff*2) ') = ' num2str(NBITScoeff*2) ''' b =' wn1ir.bin wn1ii.bin ';','\n']);
index=3;
fprintf( fid , ['coeff_data(' num2str(N*NBITScoeff*2-1-index*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-index*NBITScoeff*2-NBITScoeff*2) ') = ' num2str(NBITScoeff*2) ''' b =' wn1ir.bin wn1ii.bin  ';','\n']);
index=4;
fprintf( fid , ['coeff_data(' num2str(N*NBITScoeff*2-1-index*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-index*NBITScoeff*2-NBITScoeff*2) ') = ' num2str(NBITScoeff*2) ''' b =' wn1ir.bin wn1ii.bin  ';','\n']);
index=5;
fprintf( fid , ['coeff_data(' num2str(N*NBITScoeff*2-1-index*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-index*NBITScoeff*2-NBITScoeff*2) ') = ' num2str(NBITScoeff*2) ''' b =' w0fr.bin w0fi.bin   ';','\n']);
index=6;
fprintf( fid , ['coeff_data(' num2str(N*NBITScoeff*2-1-index*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-index*NBITScoeff*2-NBITScoeff*2) ') = ' num2str(NBITScoeff*2) ''' b =' w0fr.bin w0fi.bin  ';','\n']);
index=7;
fprintf( fid , ['coeff_data(' num2str(N*NBITScoeff*2-1-index*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-index*NBITScoeff*2-NBITScoeff*2) ') = ' num2str(NBITScoeff*2) ''' b =' wn1ir.bin wn1ii.bin ';','\n']);
fclose(fid);




fid=fopen ('coeff_data1.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[wn8fr.bin wn8fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[wn8fr.bin wn8fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fclose(fid);

fid=fopen ('coeff_data2.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w3n8fr.bin w3n8fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[wn1ir.bin wn1ii.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w3n8fr.bin w3n8fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[wn1ir.bin wn1ii.bin '\n']);
fclose(fid);

fid=fopen ('coeff_data3.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w2fr.bin w2fi.bin '\n']);
fprintf(fid,[w1fr.bin w1fi.bin '\n']);
fprintf(fid,[w3fr.bin w3fi.bin '\n']);
fclose(fid);

fid=fopen ('coeff_data4.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w0fr.bin w0fi.bin '\n']);
fprintf(fid,[w4fr.bin w4fi.bin '\n']);
fprintf(fid,[w6fr.bin w6fi.bin '\n']);
fprintf(fid,[w5fr.bin w5fi.bin '\n']);
fprintf(fid,[w7fr.bin w7fi.bin '\n']);
fclose(fid);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

