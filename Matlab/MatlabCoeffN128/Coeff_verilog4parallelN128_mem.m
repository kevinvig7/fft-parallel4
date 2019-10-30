NBITSverilog=10;
NBITScoeff=NBITSverilog+1;
NBITSF=9;
N=32;


fid = fopen('RotadorStage1.dat','r');
Stage1 = textscan(fid,'%s');


%  break;
%%Stage 1
  
for i=0 : N-1
coeff0_0(i+1,:)=Stage1{1,1}{2+i*4,1};
end

for i=0 : N-1
coeff0_1(i+1,:)=Stage1{1,1}{4+i*4,1};
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_0_0.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
for index=1 : N
    fprintf( fid ,[coeff0_0(index,:),'\n']); 
end
fclose(fid);


%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_0_1.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
for index=1 : N
    fprintf( fid , [coeff0_1(index,:),'\n']); 
end
fclose(fid);

%  break;
%%%%%%%Stage 2

fid = fopen('RotadorStage2.dat','r');
Stage2 = textscan(fid,'%s');


for i=0 : N-1
coeff1_0(i+1,:)=Stage2{1,1}{2+i*4,1};
end

for i=0 : N-1
coeff1_1(i+1,:)=Stage2{1,1}{3+i*4,1};
end

for i=0 : N-1
coeff1_2(i+1,:)=Stage2{1,1}{4+i*4,1};
end

%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_1_0.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
for index=1 : N
    fprintf( fid , [coeff1_0(index,:),'\n']); 
end

fclose(fid);

%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_1_1.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid ,[coeff1_1(index,:),'\n']); 
end

fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_1_2.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid ,[ coeff1_2(index,:),'\n']); 
end
fclose(fid);


%%%%%%%%%Stage 3

fid = fopen('RotadorStage3.dat','r');
Stage3 = textscan(fid,'%s');
%%%%%%Verificar esto....
  
for i=0 : N-1
coeff2_0(i+1,:)=Stage3{1,1}{1+i*4,1};
end

for i=0 : N-1
coeff2_1(i+1,:)=Stage3{1,1}{2+i*4,1};
end

for i=0 : N-1
coeff2_2(i+1,:)=Stage3{1,1}{3+i*4,1};
end

for i=0 : N-1
coeff2_3(i+1,:)=Stage3{1,1}{4+i*4,1};
end


%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_2_0.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid ,[coeff2_0(index,:),'\n']); 
end

fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_2_1.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
for index=1 : N
    fprintf( fid ,[ coeff2_1(index,:) ,'\n']); 
end

fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_2_2.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid ,[coeff2_2(index,:) ,'\n']); 
end

fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_2_3.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid ,[ coeff2_3(index,:) ,'\n']); 
end

fclose(fid);




%%%%%%%%%%%%%Stage 4


fid = fopen('RotadorStage4.dat','r');
Stage4 = textscan(fid,'%s');

  
for i=0 : N-1
coeff3_0(i+1,:)=Stage4{1,1}{2+i*4,1};
end

for i=0 : N-1
coeff3_1(i+1,:)=Stage4{1,1}{4+i*4,1};
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_3_0.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid ,[ coeff3_0(index,:),'\n']); 
end

fclose(fid);


%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_3_1.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid ,[ coeff3_1(index,:) ,'\n']); 
end

fclose(fid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%Stage 5

fid = fopen('RotadorStage5.dat','r');
Stage5 = textscan(fid,'%s');

  
for i=0 : N-1
coeff4_0(i+1,:)=Stage5{1,1}{1+i*4,1};
end

for i=0 : N-1
coeff4_1(i+1,:)=Stage5{1,1}{2+i*4,1};
end

for i=0 : N-1
coeff4_2(i+1,:)=Stage5{1,1}{3+i*4,1};
end

for i=0 : N-1
coeff4_3(i+1,:)=Stage5{1,1}{4+i*4,1};
end


%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_4_0.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid , [coeff4_0(index,:) ,'\n']); 
end

fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_4_1.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid , [coeff4_1(index,:) ,'\n']); 
end

fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_4_2.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid ,[ coeff4_2(index,:) ,'\n']); 
end

fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_4_3.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid ,[ coeff4_3(index,:) ,'\n']); 
end

fclose(fid);

%%%%%%%%%Stage 6

fid = fopen('RotadorStage6.dat','r');
Stage6 = textscan(fid,'%s');

  
for i=0 : N-1
coeff5_0(i+1,:)=Stage6{1,1}{1+i*4,1};
end

for i=0 : N-1
coeff5_1(i+1,:)=Stage6{1,1}{2+i*4,1};
end

for i=0 : N-1
coeff5_2(i+1,:)=Stage6{1,1}{3+i*4,1};
end

for i=0 : N-1
coeff5_3(i+1,:)=Stage6{1,1}{4+i*4,1};
end


%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_5_0.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid ,[ coeff5_0(index,:) ,'\n']); 
end

fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_5_1.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid ,[coeff5_1(index,:) ,'\n']); 
end

fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_5_2.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid , [coeff5_2(index,:) ,'\n']); 
end

fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data_5_3.mem','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida

for index=1 : N
    fprintf( fid ,[ coeff5_3(index,:) ,'\n']); 
end

fclose(fid);