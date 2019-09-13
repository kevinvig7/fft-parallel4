NBITSverilog=10;
NBITScoeff=NBITSverilog+1;
NBITSF=9;
N=32;


fid = fopen('RotadorStage1.dat','r');
Stage1 = textscan(fid,'%s');


%  break;
  
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



fid = fopen('RotadorStage2.dat','r');
Stage2 = textscan(fid,'%s');


%  break;
  
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







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

