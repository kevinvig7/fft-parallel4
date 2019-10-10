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
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data0_0.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data0_0', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff0_0(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);


%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data0_1.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data0_1', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff0_1(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
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
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data1_0.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data1_0', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff1_0(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data1_1.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data1_1', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff1_1(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data1_2.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data1_2', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff1_2(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
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
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data2_0.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data2_0', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff2_0(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data2_1.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data2_1', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff2_1(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data2_2.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data2_2', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff2_2(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data2_3.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data2_3', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff2_3(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
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
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data3_0.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data3_0', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff3_0(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);


%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data3_1.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data3_1', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff3_1(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
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
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data4_0.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data4_0', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff4_0(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data4_1.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data4_1', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff4_1(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data4_2.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data4_2', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff4_2(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data4_3.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data4_3', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff4_3(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
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
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data5_0.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data5_0', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff5_0(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data5_1.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data5_1', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff5_1(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data5_2.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data5_2', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff5_2(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data5_3.v','wt'); %guardo un archivo con los coef. cuantizados de la se�al filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data5_3', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' coeff5_3(index,:) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);