%% Punto Flotante Paralelo4 - Radix8 - 16puntos
clc; close all; clear;
addpath('MisFunciones')
onPlot = 1;
%% Muestras
%xn = ones(4,4);
xn = [1,1,1,0;... 
      0,0,0,0;...
      1,1,1,0;... 
      0,0,0,0];

Line1 =  xn(1:2, 1:4); 
Line2 =  xn(3:4, 1:4);

%% Completo muestras
% datos_line1 en paralelo por cada LINE    
paralelo = 2;  
N = 16;
% numero total de delays que existen en un LINE
delay_line = 3;

% Salida DFT Paralelo 4
Xsalida = zeros(2*paralelo, 2*paralelo);
Xsalida = [Xsalida, zeros(2*paralelo,delay_line)];

% LINE 1
datos_line1 = Line1;
% datos_line1 = [0, 2, 4, 6;...
%                8,10,12,14];
% completo con ceros las muestras de datos_line1, para asegurar la propagacion.
datos_line1 = [datos_line1, zeros(paralelo,delay_line)];

% LINE 2
datos_line2 = Line2;
% datos_line2 = [1, 3, 5, 7;...
%                9,11,13,15];
% completo con ceros las muestras de datos_line1
datos_line2 = [datos_line2, zeros(paralelo,delay_line)];

%% Twiddles
wn8  = exp(-1i*pi/4);     %  0.7071 - 0.7071i
w3n8 = exp(-1i*pi/4)*-1i; % -0.7071 - 0.7071i

w0 = (exp(-2i*pi/N))^0;
w1 = (exp(-2i*pi/N))^1;   %  0.9239 - 0.3827i
w2 = (exp(-2i*pi/N))^2;   %  0.7071 - 0.7071i
w3 = (exp(-2i*pi/N))^3;   %  0.3827 - 0.9239i
w4 = (exp(-2i*pi/N))^4;   % -0.0000 - 1.0000i
w5 = (exp(-2i*pi/N))^5;   % -0.3827 - 0.9239i
w6 = (exp(-2i*pi/N))^6;   % -0.7071 - 0.7071i
w7 = (exp(-2i*pi/N))^7;   % -0.9239 - 0.3827i

%% Multiplicadores Line1
% Stage1
twiddle1_l1 = [1,1,1,1;   1,1,-1i,-1i];
% Stage2
twiddle2_l1 = [1,1,1,wn8; 1,-1i,1,w3n8];
% Stage3
twiddle3_l1 = [1,1,1,1;   1,1,1,1];

%% Multiplicadores Line2
% Stage1
twiddle1_l2 = [1,1,1,1;   1,1,-1i,-1i];
% Stage2
twiddle2_l2 = [1,1,1,wn8; 1,-1i,1,w3n8];
% Stage3
twiddle3_l2 = [1,w2,w1,w3;w4,w6,w5,w7];

%% Delays Line1
% Esta delcaracion es empleada para generar los parametros necesarios para las
% funciones 'RegIn & RegUp' las cuales trabajan en conjunto para la simulacion
% de registros:

% Numero de Latencia Stage 1
numreg2D = 2;
InReg2D = zeros(1,numreg2D);  
% Estructuras de Latencia
D2.ff = struct('d',0, 'q',0);
% replico FlipFlops
Lat2D = repmat(D2, 1,numreg2D);

% Numero de Latencia Stage 2
numreg1D = 1;
InReg1D = zeros(1,numreg1D);  
% Estructuras de Latencia
D1.ff = struct('d',0, 'q',0);
% replico FlipFlops
Lat1D = repmat(D1, 1,numreg1D);

% 2D1 Stage1
InReg2D1 = InReg2D;
Lat2D1   = Lat2D;
% 2D2 Stage1
InReg2D2 = InReg2D;
Lat2D2   = Lat2D;

% 1D1 Stage2
InReg1D1 = InReg1D;
Lat1D1   = Lat1D;
% 1D2 Stage2
InReg1D2 = InReg1D;
Lat1D2   = Lat1D;

%% Delays Line2
% 2D1 Stage1
InReg2D1_l2 = InReg2D;
Lat2D1_l2   = Lat2D;
% 2D2 Stage1
InReg2D2_l2 = InReg2D;
Lat2D2_l2   = Lat2D;

% 1D1 Stage2
InReg1D1_l2 = InReg1D;
Lat1D1_l2   = Lat1D;
% 1D2 Stage2
InReg1D2_l2 = InReg1D;
Lat1D2_l2   = Lat1D;

%% Definiciones auxiliares
% LINE1 
% stage 1
cnt1 = 0;
DivFrec1 = 2;
% stage 2
cnt2 = 0;
DivFrec2 = 1;

%% Reloj
for clk = (0:length(datos_line1)-1)
    %% LINE 1
    % STAGE_1
    in = datos_line1(:,clk+1);
    [out1, out2] = BF(in(1), in(2));
    out_bf1 = [out1; out2];
    
    % Multiplicador M1
    % Instante en el cual el multiplicador esta activo
    activo_max = length(twiddle1_l1);
    if(clk<activo_max) % if(clk<4) clk: 0,1,2,3
        % Line1 A
        [out_bf1(1)] = Mult(out_bf1(1), twiddle1_l1(1,clk+1), "true");
        % Line1 B
        [out_bf1(2)] = Mult(out_bf1(2), twiddle1_l1(2,clk+1), "true");   
    end
    
    out_mult1 = [out_bf1(1); out_bf1(2)];
    
    % Delay 2D1
    InReg2D1(1) = out_mult1(2);
    % Asignacion de datos_line1 al Registro
    [OutLat2D1, OutReg2D1] = RegIn(Lat2D1, InReg2D1);   
    % Dato de salida
    out_reg1 = [ out_mult1(1); OutReg2D1];
    
    % Divisor de Frecuencia
    if(cnt1<=DivFrec1-1)
        o_frec1 = 0;
    elseif(cnt1>=DivFrec1)
        o_frec1 = 1;
    end
    
    if(cnt1==2*DivFrec1-1)
        cnt1 = 0;
    else
        cnt1 = cnt1+1;
    end  
    % Llave
    control1 = o_frec1;
    [out1, out2] = llave(out_reg1(1), out_reg1(2), control1);
    out_switch1 = [out1; out2];
    
    % Delay 2D2
    InReg2D2(1) = out_switch1(1);
    % Asignacion de datos_line1 al Registro
    [OutLat2D2, OutReg2D2] = RegIn(Lat2D2, InReg2D2);   
    % Dato de salida
    out_reg1 = [ OutReg2D2; out_switch1(2)];
    
    % STAGE_2
    [out1, out2] = BF(out_reg1(1), out_reg1(2));
    out_bf2 = [out1; out2];
    
    % Multiplicador M2
    % Instante en el cual el multiplicador esta activo
    activo_min = numreg2D-1;
    activo_max = numreg2D+length(twiddle2_l1);
    if(activo_min<clk && clk<activo_max) % clk: 2,3,4,5
        % Line1 A
        [out_bf2(1)] = Mult(out_bf2(1), twiddle2_l1(1,clk-numreg2D+1), "true");
        % Line1 B
        [out_bf2(2)] = Mult(out_bf2(2), twiddle2_l1(2,clk-numreg2D+1), "true");   
    end
    out_mult2 = [out_bf2(1); out_bf2(2)];
    
    % Delay 1D1
    InReg1D1(1) = out_mult2(2);
    % Asignacion de datos_line1 al Registro
    [OutLat1D1, OutReg1D1] = RegIn(Lat1D1, InReg1D1);   
    % Dato de salida
    out_reg2 = [ out_mult2(1); OutReg1D1];
    
    % Divisor de Frecuencia
    if(cnt2<=DivFrec2-1)
        o_frec2 = 0;
    elseif(cnt2>=DivFrec2)
        o_frec2 = 1;
    end
    
    if(cnt2==2*DivFrec2-1)
        cnt2 = 0;
    else
        cnt2 = cnt2+1;
    end  
    % Llave
    control2 = o_frec2;
    [out1, out2] = llave(out_reg2(1), out_reg2(2), control2);
    out_switch2 = [out1; out2];

    % Delay 1D2
    InReg1D2(1) = out_switch2(1);
    % Asignacion de datos_line1 al Registro
    [OutLat1D2, OutReg1D2] = RegIn(Lat1D2, InReg1D2);   
    % Dato de salida
    out_reg2 = [ OutReg1D2; out_switch2(2)];
    
    % STAGE_3
    [out1, out2] = BF(out_reg2(1), out_reg2(2));
    out_bf3 = [out1; out2];
    
    %% LINE 2   
    % STAGE_1
    in_l2 = datos_line2(:,clk+1);
    [out1_l2, out2_l2] = BF(in_l2(1), in_l2(2));
    out_bf1_l2 = [out1_l2; out2_l2];
 
    % Multiplicador M1
    activo_max = length(twiddle1_l2);
    if(clk<activo_max) 
        % Line2 A
        [out_bf1_l2(1)] = Mult(out_bf1_l2(1), twiddle1_l2(1,clk+1), "true");
        % Line2 B
        [out_bf1_l2(2)] = Mult(out_bf1_l2(2), twiddle1_l2(2,clk+1), "true");   
    end   
    out_mult1_l2 = [out_bf1_l2(1); out_bf1_l2(2)]; 
    
    % Delay 2D1
    InReg2D1_l2(1) = out_mult1_l2(2);
    % Asignacion de datos_line1 al Registro
    [OutLat2D1_l2, OutReg2D1_l2] = RegIn(Lat2D1_l2, InReg2D1_l2);   
    % Dato de salida
    out_reg1_l2 = [ out_mult1_l2(1); OutReg2D1_l2];    

    % Divisor de Frecuencia
    % El Stage 1/LINE 2 recibe la misma señal de control que Stage1/LINE1
    
    % Llave
    [out1_l2, out2_l2] = llave(out_reg1_l2(1), out_reg1_l2(2), control1);
    out_switch1_l2 = [out1_l2; out2_l2];
    
    % Delay 2D2
    InReg2D2_l2(1) = out_switch1_l2(1);
    % Asignacion de datos_line1 al Registro
    [OutLat2D2_l2, OutReg2D2_l2] = RegIn(Lat2D2_l2, InReg2D2_l2);   
    % Dato de salida
    out_reg1_l2 = [ OutReg2D2_l2; out_switch1_l2(2)];
    
    % STAGE_2
    [out1_l2, out2_l2] = BF(out_reg1_l2(1), out_reg1_l2(2));
    out_bf2_l2 = [out1_l2; out2_l2];    
    
    % Multiplicador M2
    activo_min = numreg2D-1;
    activo_max = numreg2D+length(twiddle2_l2);
    if(activo_min<clk && clk<activo_max) 
        % Line2 A
        [out_bf2_l2(1)] = Mult(out_bf2_l2(1), twiddle2_l2(1,clk-numreg2D+1), "true");
        % Line2 B
        [out_bf2_l2(2)] = Mult(out_bf2_l2(2), twiddle2_l2(2,clk-numreg2D+1), "true");   
    end
    out_mult2_l2 = [out_bf2_l2(1); out_bf2_l2(2)];   
    
    % Delay 1D1
    InReg1D1_l2(1) = out_mult2_l2(2);
    % Asignacion de datos_line1 al Registro
    [OutLat1D1_l2, OutReg1D1_l2] = RegIn(Lat1D1_l2, InReg1D1_l2);   
    % Dato de salida
    out_reg2_l2 = [ out_mult2_l2(1); OutReg1D1_l2];

    % Divisor de Frecuencia
    % El Stage 2/LINE 2 recibe la misma señal de control que Stage2/LINE1
    
    % Llave
    [out1_l2, out2_l2] = llave(out_reg2_l2(1), out_reg2_l2(2), control2);
    out_switch2_l2 = [out1_l2; out2_l2];
    
    % Delay 1D2
    InReg1D2_l2(1) = out_switch2_l2(1);
    % Asignacion de datos_line1 al Registro
    [OutLat1D2_l2, OutReg1D2_l2] = RegIn(Lat1D2_l2, InReg1D2_l2);   
    % Dato de salida
    out_reg2_l2 = [ OutReg1D2_l2; out_switch2_l2(2)];  
    
    % STAGE_3
    [out1_l2, out2_l2] = BF(out_reg2_l2(1), out_reg2_l2(2));
    out_bf3_l2 = [out1_l2; out2_l2];
       
    % Multiplicador M3
    activo_min = numreg2D+numreg1D-1;
    activo_max = numreg2D+numreg1D+length(twiddle3_l1);
    if(activo_min<clk && clk<activo_max) % clk: 3,4,5,6
        idx = clk-numreg2D-numreg1D+1;
        % Line2 A
        [out_bf3_l2(1)] = Mult(out_bf3_l2(1), twiddle3_l2(1,idx), "true");
        % Line2 B
        [out_bf3_l2(2)] = Mult(out_bf3_l2(2), twiddle3_l2(2,idx), "true");  
    end
    out_mult3_l2 = [out_bf3_l2(1); out_bf3_l2(2)];    
    
    %% Combinacion LINE1/LINE2
    % STAGE 4/LINE1
    [out1, out2] = BF(out_bf3(1), out_mult3_l2(1));
    out_bf4 = [out1; out2];
    % STAGE4/LINE2
    [out1_l2, out2_l2] = BF(out_bf3(2), out_mult3_l2(2));
    out_bf4_l2 = [out1_l2; out2_l2];
    
    % Salida DFT Paralelo 4
    Xk = [out_bf4;out_bf4_l2];
    Xsalida(:,clk+1) = Xk;
 
    %% Actualizo Todos los Registros del LINE 1 A/B
    [Lat2D1, InReg2D1] = RegUp(OutLat2D1, InReg2D1);
    [Lat2D2, InReg2D2] = RegUp(OutLat2D2, InReg2D2);
    [Lat1D1, InReg1D1] = RegUp(OutLat1D1, InReg1D1);
    [Lat1D2, InReg1D2] = RegUp(OutLat1D2, InReg1D2);
    % Actualizo Todos los Registros del LINE 2 A/B
    [Lat2D1_l2, InReg2D1_l2] = RegUp(OutLat2D1_l2, InReg2D1_l2);
    [Lat2D2_l2, InReg2D2_l2] = RegUp(OutLat2D2_l2, InReg2D2_l2);
    [Lat1D1_l2, InReg1D1_l2] = RegUp(OutLat1D1_l2, InReg1D1_l2);
    [Lat1D2_l2, InReg1D2_l2] = RegUp(OutLat1D2_l2, InReg1D2_l2);
    
end

%% Muestras de salida
Xsalida = Xsalida( :,4:end);
% Convierto las muestras de DFT de Matriz a Vector
Xvector = zeros(1,length(Xsalida)^2);
for index = (1:length(Xsalida)^2)
    Xvector(index) = Xsalida(index);
end

% Alineo muestras del vector.
Xvector = Alineacion(Xvector);

% Plot
if(onPlot)
    figure();
    out_dft = real( fftshift(Xvector) );
    stem(out_dft, 'm')
    title('$4Parallel-Radix 2^3: X[k]=\sum_{n=0}^{N-1} x(n)W_N^{nk}$','Interpreter','latex','FontSize',13)
    xlabel('16 Points'); ylabel('DFT X[k]'); grid minor;
end
