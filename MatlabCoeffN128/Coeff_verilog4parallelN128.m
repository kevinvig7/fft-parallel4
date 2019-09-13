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
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data0_0.v','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
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
fid=fopen ('C:\fft-parallel4\verilog\topfftsrcN128\v\coeff_data0_1.v','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
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

break;

%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrc\v\coeff_data2.v','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data2', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' num2str(coeff2(index,:)) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrc\v\coeff_data3.v','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data3', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' num2str(coeff3(index,:)) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);
%%%%%%%%%%%%%%%%%
fid=fopen ('C:\fft-parallel4\verilog\topfftsrc\v\coeff_data4.v','wt'); %guardo un archivo con los coef. cuantizados de la señal filtrada de salida
fprintf(fid,['`timescale 1ns / 1ps' , '\n']);
fprintf(fid,['module coeff_data4', '\n']);
fprintf(fid,['#(parameter NBITS=',num2str(NBITScoeff),',','\n']);
fprintf(fid,['  parameter N=',num2str(N),')\n']);
fprintf(fid,['(output reg [NBITS*N*2-1:0] coeff_data);','\n']);
fprintf(fid,['initial begin' , '\n']);
for index=1 : N
    fprintf( fid , ['coeff_data[' num2str(N*NBITScoeff*2-1-(index-1)*NBITScoeff*2) ' : ' num2str(N*NBITScoeff*2-(index-1)*NBITScoeff*2-NBITScoeff*2) '] = ' num2str(NBITScoeff*2) '''b' num2str(coeff4(index,:)) ';','\n']); 
end
fprintf(fid,['end ' , '\n']);
fprintf(fid,['endmodule ' , '\n']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

