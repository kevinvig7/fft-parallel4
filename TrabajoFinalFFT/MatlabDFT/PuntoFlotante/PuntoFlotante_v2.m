%% Punto Flotante Paralelo4 - Radix8 - 16puntos
clc; close all; clear;
addpath('MisFunciones')

%% Muestras
xn = ones(4,4);
xn = [0,0,0,0; 0,0,0,0; 1,1,1,0; 1,1,1,0];

Line1 =  xn(1:2, 1:4);
Line2 =  xn(3:4, 1:4);

%% Completo muestras
% datos en paralelo por cada LINE    
paralelo = 2;  
N = 16;
% numero total de delays que existen en un LINE
delay_line = 3;

% Salida DFT Paralelo 4
Xsalida = zeros(2*paralelo, 2*paralelo);
Xsalida = [Xsalida, zeros(2*paralelo,delay_line)];

% LINE 1
datos = Line1;
% datos = [0, 2, 4, 6;...
%          8,10,12,14];
% completo con ceros las muestras de datos, para asegurar la propagacion.
datos = [datos, zeros(paralelo,delay_line)];

% LINE 2
datos_line2 = Line2;
% datos_line2 = [0, 2, 4, 6;...
%                8,10,12,14];
% completo con ceros las muestras de datos
datos_line2 = [datos_line2, zeros(paralelo,delay_line)];

%% Twiddles
wn8  = exp(-1i*pi/4);     %  0.7071 - 0.7071i
w3n8 = exp(-1i*pi/4)*-1i; % -0.7071 - 0.7071i

w1 = (exp(-2i*pi/N))^1;   %  0.9239 - 0.3827i
w2 = (exp(-2i*pi/N))^2;   %  0.7071 - 0.7071i
w3 = (exp(-2i*pi/N))^3;   %  0.3827 - 0.9239i
w4 = (exp(-2i*pi/N))^4;   % -0.0000 - 1.0000i
w5 = (exp(-2i*pi/N))^5;   % -0.3827 - 0.9239i
w6 = (exp(-2i*pi/N))^6;   % -0.7071 - 0.7071i
w7 = (exp(-2i*pi/N))^7;   % -0.9239 - 0.3827i

%% Multiplicadores Line1
% Stage1
twiddle1_l1 = [1,1,1,1; 1,1,-1i,-1i];
% Stage2
twiddle2_l1 = [1,1,1,wn8; 1,-1i,1,w3n8];
% Stage3
twiddle3_l1 = [1,1,1,1; 1,1,1,1];

%% Multiplicadores Line2
% Stage1
twiddle1_l2 = [1,1,1,1; 1,1,-1i,-1i];
% Stage2
twiddle2_l2 = [1,1,1,wn8; 1,-1i,1,w3n8];
% Stage3
twiddle3_l2 = [1,w2,w1,w3; w4,w6,w5,w7];

%% Delays Line1
% Esta delcaracion es empleada para generar los parametros necesarios para las
% funciones 'RegIn & RegUp' las cuales trabajan en conjunto para la simulacion
% de registros:

% Numero de Latencia Stage 1
numreg2D = 2;
InReg = zeros(1,numreg2D);  
% Estructuras de Latencia
D.ff = struct('d',0, 'q',0);
% replico FlipFlops
Lat = repmat(D, 1,numreg2D);

% Numero de Latencia Stage 2
numregD1 = 1;
InRegD1 = zeros(1,numregD1);  
% Estructuras de Latencia
D1.ff = struct('d',0, 'q',0);
% replico FlipFlops
LatD1 = repmat(D1, 1,numregD1);

% 2D1 Stage1
InReg2D1 = InReg;
Lat2D1   = Lat;
% 2D2 Stage1
InReg2D2 = InReg;
Lat2D2   = Lat;

% 1D1 Stage2
InReg1D1 = InRegD1;
Lat1D1   = LatD1;
% 1D2 Stage2
InReg1D2 = InRegD1;
Lat1D2   = LatD1;

%% Delays Line2
% 2D1 Stage1
InReg2D1_l2 = InReg;
Lat2D1_l2   = Lat;
% 2D2 Stage1
InReg2D2_l2 = InReg;
Lat2D2_l2   = Lat;

% 1D1 Stage2
InReg1D1_l2 = InRegD1;
Lat1D1_l2   = LatD1;
% 1D2 Stage2
InReg1D2_l2 = InRegD1;
Lat1D2_l2   = LatD1;

%% Definiciones auxiliares
% LINE1 
% stage 1
cnt1 = 0;
DivFrec1 = 2;
% stage 2
cnt2 = 0;
DivFrec2 = 1;

%% Reloj
for clk = (0:length(datos)-1)
    %% LINE 1
    % STAGE_1
    in = datos(:,clk+1);
    [out1, out2] = BF(in(1), in(2));
    out_bf = [out1; out2];
    
    % Multiplicador M1
    % Instante en el cual el multiplicador esta activo
    activo_max = length(twiddle1_l1);
    if(clk<activo_max) % if(clk<4) clk: 0,1,2,3
        % Line1 A
        [out_bf(1)] = Mult(out_bf(1), twiddle1_l1(1,clk+1), "true");
        % Line1 B
        [out_bf(2)] = Mult(out_bf(2), twiddle1_l1(2,clk+1), "true");   
    end
    
    out_mult = [out_bf(1); out_bf(2)];
    
    % Delay 2D1
    InReg2D1(1) = out_mult(2);
    % Asignacion de Datos al Registro
    [OutLat2D1, OutReg2D1] = RegIn(Lat2D1, InReg2D1);   
    % Dato de salida
    out_reg = [ out_mult(1); OutReg2D1];
    
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
    control = o_frec1;
    [out1, out2] = llave(out_reg(1), out_reg(2), control);
    out_switch = [out1; out2];
    
    % Delay 2D2
    InReg2D2(1) = out_switch(1);
    % Asignacion de Datos al Registro
    [OutLat2D2, OutReg2D2] = RegIn(Lat2D2, InReg2D2);   
    % Dato de salida
    out_reg = [ OutReg2D2; out_switch(2)];
    
    % STAGE_2
    [out1, out2] = BF(out_reg(1), out_reg(2));
    out_bf = [out1; out2];
    
    % Multiplicador M2
    % Instante en el cual el multiplicador esta activo
    activo_min = numreg2D-1;
    activo_max = numreg2D+length(twiddle2_l1);
    if(activo_min<clk && clk<activo_max) % clk: 2,3,4,5
        % Line1 A
        [out_bf(1)] = Mult(out_bf(1), twiddle2_l1(1,clk-numreg2D+1), "true");
        % Line1 B
        [out_bf(2)] = Mult(out_bf(2), twiddle2_l1(2,clk-numreg2D+1), "true");   
    end
    out_mult = [out_bf(1); out_bf(2)];
    
    % Delay 1D1
    InReg1D1(1) = out_mult(2);
    % Asignacion de Datos al Registro
    [OutLat1D1, OutReg1D1] = RegIn(Lat1D1, InReg1D1);   
    % Dato de salida
    out_reg = [ out_mult(1); OutReg1D1];
    
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
    [out1, out2] = llave(out_reg(1), out_reg(2), control2);
    out_switch = [out1; out2];

    % Delay 1D2
    InReg1D2(1) = out_switch(1);
    % Asignacion de Datos al Registro
    [OutLat1D2, OutReg1D2] = RegIn(Lat1D2, InReg1D2);   
    % Dato de salida
    out_reg = [ OutReg1D2; out_switch(2)];
    
    % STAGE_3
    [out1, out2] = BF(out_reg(1), out_reg(2));
    out_bf = [out1; out2];
    
    %% LINE 2   
    % STAGE_1
    in_l2 = datos_line2(:,clk+1);
    [out1_l2, out2_l2] = BF(in_l2(1), in_l2(2));
    out_bf_l2 = [out1_l2; out2_l2];
 
    % Multiplicador M1
    activo_max = length(twiddle1_l2);
    if(clk<activo_max) 
        % Line2 A
        [out_bf_l2(1)] = Mult(out_bf_l2(1), twiddle1_l2(1,clk+1), "true");
        % Line2 B
        [out_bf_l2(2)] = Mult(out_bf_l2(2), twiddle1_l2(2,clk+1), "true");   
    end   
    out_mult_l2 = [out_bf_l2(1); out_bf_l2(2)]; 
    
    % Delay 2D1
    InReg2D1_l2(1) = out_mult_l2(2);
    % Asignacion de Datos al Registro
    [OutLat2D1_l2, OutReg2D1_l2] = RegIn(Lat2D1_l2, InReg2D1_l2);   
    % Dato de salida
    out_reg_l2 = [ out_mult_l2(1); OutReg2D1_l2];    

    % Divisor de Frecuencia
    % El Stage 1/LINE 2 recibe la misma señal de control que Stage1/LINE1
    
    % Llave
    [out1_l2, out2_l2] = llave(out_reg_l2(1), out_reg_l2(2), control);
    out_switch_l2 = [out1_l2; out2_l2];
    
    % Delay 2D2
    InReg2D2_l2(1) = out_switch_l2(1);
    % Asignacion de Datos al Registro
    [OutLat2D2_l2, OutReg2D2_l2] = RegIn(Lat2D2_l2, InReg2D2_l2);   
    % Dato de salida
    out_reg_l2 = [ OutReg2D2_l2; out_switch_l2(2)];
    
    % STAGE_2
    [out1_l2, out2_l2] = BF(out_reg_l2(1), out_reg_l2(2));
    out_bf_l2 = [out1_l2; out2_l2];    
    
    % Multiplicador M2
    activo_min = numreg2D-1;
    activo_max = numreg2D+length(twiddle2_l2);
    if(activo_min<clk && clk<activo_max) 
        % Line2 A
        [out_bf_l2(1)] = Mult(out_bf_l2(1), twiddle2_l2(1,clk-numreg2D+1), "true");
        % Line2 B
        [out_bf_l2(2)] = Mult(out_bf_l2(2), twiddle2_l2(2,clk-numreg2D+1), "true");   
    end
    out_mult_l2 = [out_bf_l2(1); out_bf_l2(2)];   
    
    % Delay 1D1
    InReg1D1_l2(1) = out_mult_l2(2);
    % Asignacion de Datos al Registro
    [OutLat1D1_l2, OutReg1D1_l2] = RegIn(Lat1D1_l2, InReg1D1_l2);   
    % Dato de salida
    out_reg_l2 = [ out_mult_l2(1); OutReg1D1_l2];

    % Divisor de Frecuencia
    % El Stage 2/LINE 2 recibe la misma señal de control que Stage2/LINE1
    
    % Llave
    [out1_l2, out2_l2] = llave(out_reg_l2(1), out_reg_l2(2), control2);
    out_switch_l2 = [out1_l2; out2_l2];
    
    % Delay 1D2
    InReg1D2_l2(1) = out_switch_l2(1);
    % Asignacion de Datos al Registro
    [OutLat1D2_l2, OutReg1D2_l2] = RegIn(Lat1D2_l2, InReg1D2_l2);   
    % Dato de salida
    out_reg_l2 = [ OutReg1D2_l2; out_switch_l2(2)];  
    
    % STAGE_3
    [out1_l2, out2_l2] = BF(out_reg_l2(1), out_reg_l2(2));
    out_bf_l2 = [out1_l2; out2_l2];
       
    % Multiplicador M3
    activo_min = numreg2D+numregD1-1;
    activo_max = numreg2D+numregD1+length(twiddle3_l1);
    if(activo_min<clk && clk<activo_max) % clk: 3,4,5,6
        idx = clk-numreg2D-numregD1+1;
        % Line2 A
        [out_bf_l2(1)] = Mult(out_bf_l2(1), twiddle3_l2(1,idx), "true");
        % Line2 B
        [out_bf_l2(2)] = Mult(out_bf_l2(2), twiddle3_l2(2,idx), "true");  
    end
    out_mult_l2 = [out_bf_l2(1); out_bf_l2(2)];    
    
    %% Combinacion LINE1/LINE2
    % STAGE 4/LINE1
    [out1, out2] = BF(out_bf(1), out_mult_l2(1));
    out_bf = [out1; out2];
    % STAGE4/LINE2
    [out1_l2, out2_l2] = BF(out_bf(2), out_mult_l2(2));
    out_bf_l2 = [out1_l2; out2_l2];
    
    % Salida DFT Paralelo 4
    Xk = [out_bf;out_bf_l2];
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

%% Orden de muestras
Xaux = Xsalida;
Xsalida = Xsalida( :,4:end);

Xvector = zeros(1,length(Xsalida)^2);
for index = (1:length(Xsalida)^2)
    index;
    Xvector(index) = Xsalida(index);
end

% 0 8 4 12 2 10 6 14 1 9  5 13  3 11  7 15
% 0 1 2 3  4  5 6  7 8 9 10 11 12 13 14 15
n = 1;
Xvector = [ Xvector(n+0),Xvector(n+8), Xvector(n+4),Xvector(n+12),...
            Xvector(n+2),Xvector(n+10),Xvector(n+6),Xvector(n+14),...
            Xvector(n+1),Xvector(n+9), Xvector(n+5),Xvector(n+13),...
            Xvector(n+3),Xvector(n+11),Xvector(n+7),Xvector(n+15) ];
% Plot
on = true;
if(on)
    figure();
    out_dft = real( fftshift(Xvector) );
    stem(out_dft, 'm')
    title('$Radix 2^3: X[k]=\sum_{n=0}^{N-1} x(n)W_N^{nk}$','Interpreter','latex','FontSize',13)
    xlabel('16 Points'); ylabel('DFT X[k]'); grid minor;
end

%% Test
% clc; close all; clear;
% %    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 
% x = [1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0];

%      0 8 4 12 2 10 6 14 1 9  5 13  3 11  7 15
% x = [1,1,1, 1,1, 1,0, 0,0,0, 0, 0, 0, 0, 0, 0];

% xn = [1,1,1,0; 
%       1,1,1,0; 
%       0,0,0,0; 
%       0,0,0,0];

%       0 8 4 12 2 10 6 14 1 9  5 13  3 11  7 15
% xn = [1,1,1, 1,1, 1,0, 0,0,0, 0, 0, 0, 0, 0, 0];

% xn = [1,0,1,0; 
%       1,0,1,0; 
%       1,0,0,0; 
%       1,0,0,0];

% %    0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
% x = [1,1,1,1,1,1,0,0,0,0, 0, 0, 0, 0, 0, 0];

% xn = [1,1,0,0; 
%       1,1,0,0; 
%       1,0,0,0; 
%       1,0,0,0];

% xn = [1,1,1,0; 
%       0,0,0,0; 
%       1,1,1,0; 
%       0,0,0,0];
