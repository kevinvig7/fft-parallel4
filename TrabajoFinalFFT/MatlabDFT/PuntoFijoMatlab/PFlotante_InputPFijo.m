%% Punto Flotante Paralelo4 - Radix8 - N:128puntos - Version Parhi
clc; close all; clear;
% Directorio a las funciones en PFijo, PFlotante
addpath('PFijoFunciones');
R = Rutas();
addpath(R.R2);

% Preferencia de visualizacion de la funcion 'fi()'
fipref('NumericTypeDisplay','short',  'FimathDisplay','none');
Fmath = fimath('RoundingMethod','Floor',  'OverflowAction','Saturate');
onPlot = 1;

%% Muestras
N = 128;
%xnIn = [ones(1,6), zeros(1,122)];
%xnIn = ones(1,N);
% Signo:
S = 1;
% Cantidad entera
I = 0;
% Cantidad Fraccional
F = 9;
% Cantidad Total de bits
W = S+I+F;

[xFi,xFlot,t,xEq,fs] = InputSignal(S,W,F);
% Ordena el vector de entrada y lo convierte a una matriz adecuada para la dft.
xn = VecOrdMat(xFlot);

Line1 =  xn(1:2, 1:end); 
Line2 =  xn(3:4, 1:end);

%% Completo muestras
% numero total de delays que existen en un LINE
delay_line = 47;
% datos_line1 en paralelo por cada LINE    
paralelo = 4;  

% Salida DFT Paralelo 4
Xsalida = zeros(paralelo, length(xn));
Xsalida = [Xsalida, zeros(paralelo,delay_line)];

% LINE 1
datos_line1 = Line1;
% completo con ceros las muestras de datos_line1, para asegurar la propagacion.
datos_line1 = [datos_line1, zeros(paralelo/2,delay_line)];

% LINE 2
datos_line2 = Line2;
% completo con ceros las muestras de datos_line1
datos_line2 = [datos_line2, zeros(paralelo/2,delay_line)];

%% Twiddles
T = Twiddles();
%% Multiplicadores Line1
% Stage1
twiddle1_l1 = T(1:2, 1:end);
% Stage2
twiddle2_l1 = T(5:6, 1:end);
% Stage3
twiddle3_l1 = T(9:10, 1:end);
% Stage4
twiddle4_l1 = T(13:14, 1:end);
% Stage5
twiddle5_l1 = T(17:18, 1:end);
% Stage6
twiddle6_l1 = T(21:22, 1:end);

%% Multiplicadores Line2
% Stage1
twiddle1_l2 = T(3:4, 1:end);
% Stage2
twiddle2_l2 = T(7:8, 1:end);
% Stage3
twiddle3_l2 = T(11:12, 1:end);
% Stage4
twiddle4_l2 = T(15:16, 1:end);
% Stage5
twiddle5_l2 = T(19:20, 1:end);
% Stage6
twiddle6_l2 = T(23:24, 1:end);

%% Latencias
% Esta delcaracion es empleada para generar los parametros necesarios para las
% funciones 'RegIn & RegUp' las cuales trabajan en conjunto para la simulacion
% de registros:

% Numero de Latencia Stage 1
numreg16D = 16;
InReg16D = zeros(1,numreg16D);  
% Estructuras de Latencia
D16.ff = struct('d',0, 'q',0);
% replico FlipFlops
Lat16D = repmat(D16, 1,numreg16D);

% Numero de Latencia Stage 2
numreg8D = 8;
InReg8D = zeros(1,numreg8D);  
D8.ff = struct('d',0, 'q',0);
Lat8D = repmat(D8, 1,numreg8D);

% Numero de Latencia Stage 3
numreg4D = 4;
InReg4D = zeros(1,numreg4D);  
D4.ff = struct('d',0, 'q',0);
Lat4D = repmat(D4, 1,numreg4D);

% Numero de Latencia Stage 4
numreg2D = 2;
InReg2D = zeros(1,numreg2D);  
D2.ff = struct('d',0, 'q',0);
Lat2D = repmat(D2, 1,numreg2D);

% Numero de Latencia Stage 5
numreg1D = 1;
InReg1D = zeros(1,numreg1D);  
D1.ff = struct('d',0, 'q',0);
Lat1D = repmat(D1, 1,numreg1D);

% Numero de Latencia Stage 6: Igual al Stage 1

%% Delays Line1
% 16D1 Stage1
InReg16D1 = InReg16D;
Lat16D1   = Lat16D;
% 16D2 
InReg16D2 = InReg16D;
Lat16D2   = Lat16D;

% 8D1 Stage2
InReg8D1 = InReg8D;
Lat8D1   = Lat8D;
% 8D2 
InReg8D2 = InReg8D;
Lat8D2   = Lat8D;

% 4D1 Stage3
InReg4D1 = InReg4D;
Lat4D1   = Lat4D;
% 4D2 
InReg4D2 = InReg4D;
Lat4D2   = Lat4D;

% 2D1 Stage4
InReg2D1 = InReg2D;
Lat2D1   = Lat2D;
% 2D2 
InReg2D2 = InReg2D;
Lat2D2   = Lat2D;

% 1D1 Stage5
InReg1D1 = InReg1D;
Lat1D1   = Lat1D;
% 1D2 
InReg1D2 = InReg1D;
Lat1D2   = Lat1D;

% 16D1 Stage6
InReg16D1p = InReg16D;
Lat16D1p   = Lat16D;
% 16D2 
InReg16D2p = InReg16D;
Lat16D2p   = Lat16D;

%% Delays Line2
% 16D1 Stage1
InReg16D1_l2 = InReg16D;
Lat16D1_l2   = Lat16D;
% 16D2 
InReg16D2_l2 = InReg16D;
Lat16D2_l2   = Lat16D;

% 8D1 Stage2
InReg8D1_l2 = InReg8D;
Lat8D1_l2   = Lat8D;
% 8D2 
InReg8D2_l2 = InReg8D;
Lat8D2_l2   = Lat8D;

% 4D1 Stage3
InReg4D1_l2 = InReg4D;
Lat4D1_l2   = Lat4D;
% 4D2 
InReg4D2_l2 = InReg4D;
Lat4D2_l2   = Lat4D;

% 2D1 Stage4
InReg2D1_l2 = InReg2D;
Lat2D1_l2   = Lat2D;
% 2D2 
InReg2D2_l2 = InReg2D;
Lat2D2_l2   = Lat2D;

% 1D1 Stage5
InReg1D1_l2 = InReg1D;
Lat1D1_l2   = Lat1D;
% 1D2 
InReg1D2_l2 = InReg1D;
Lat1D2_l2   = Lat1D;

% 16D1 Stage6
InReg16D1p_l2 = InReg16D;
Lat16D1p_l2   = Lat16D;
% 16D2 
InReg16D2p_l2 = InReg16D;
Lat16D2p_l2   = Lat16D;

%% Definiciones auxiliares
% Line1/Line2
% stage 1
cnt1 = 0;
DivFrec1 = 16;
% stage 2
cnt2 = 0;
DivFrec2 = 8;
% stage 3
cnt3 = 0;
DivFrec3 = 4;
% stage 4
cnt4 = 0;
DivFrec4 = 2;
% stage 5
cnt5 = 0;
DivFrec5 = 1;
% stage 6
cnt6 = 1;
DivFrec6 = 16;

%% Reloj
for clk = (0:length(datos_line1)-1)
    %% Combinacion LINE1/LINE2 
    % LINE 1/STAGE 1
    in = datos_line1(:,clk+1);
    [out1, out2] = BF(in(1), in(2));
    out_bf1 = [out1; out2];
    
    % Multiplicador M1
    % Instante en el cual el multiplicador esta activo
    activo_max = length(twiddle1_l1);
    if(clk<activo_max) % if(clk<4) clk: 0,1,2,3,...,31
        % Line1 A
        [out_bf1(1)] = Mult(out_bf1(1), twiddle1_l1(1,clk+1), "true");
        % Line1 B
        [out_bf1(2)] = Mult(out_bf1(2), twiddle1_l1(2,clk+1), "true");   
    end    
    out_mult1 = [out_bf1(1); out_bf1(2)];

    % LINE 2/STAGE 1
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
       
    %% LINE 1
    %%% STAGE 1 %%%
    % Delay 16D1
    InReg16D1(1) = out_mult1_l2(1);
    % Asignacion de datos_line1 al Registro
    [OutLat16D1, OutReg16D1] = RegIn(Lat16D1, InReg16D1);   
    % Dato de salida
    out_reg1 = [ out_mult1(1); OutReg16D1];
    
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
    % Llave 1
    control1 = o_frec1;
    [out1, out2] = llave(out_reg1(1), out_reg1(2), control1);
    out_switch1 = [out1; out2];
    
    % Delay 16D2
    InReg16D2(1) = out_switch1(1);
    % Asignacion de datos_line1 al Registro
    [OutLat16D2, OutReg16D2] = RegIn(Lat16D2, InReg16D2); 
    % Dato de salida
    out_reg1 = [ OutReg16D2; out_switch1(2)];
    
    %%% STAGE_2 %%%
    [out1, out2] = BF(out_reg1(1), out_reg1(2));
    out_bf2 = [out1; out2];
    
    % Multiplicador M2
    % Instante en el cual el multiplicador esta activo
    activo_min = numreg16D-1;
    activo_max = numreg16D+length(twiddle2_l1);
    if(activo_min<clk && clk<activo_max) % clk: 16,...,47
        idx2 = clk-numreg16D+1;
        % Line1 A
        [out_bf2(1)] = Mult(out_bf2(1), twiddle2_l1(1,idx2), "true");
        % Line1 B
        [out_bf2(2)] = Mult(out_bf2(2), twiddle2_l1(2,idx2), "true");   
    end
    out_mult2 = [out_bf2(1); out_bf2(2)];
    
    % Delay 8D1
    InReg8D1(1) = out_mult2(2);
    % Asignacion de datos_line1 al Registro
    [OutLat8D1, OutReg8D1] = RegIn(Lat8D1, InReg8D1);   
    % Dato de salida
    out_reg2 = [ out_mult2(1); OutReg8D1];
    
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
    % Llave 2
    control2 = o_frec2;
    [out1, out2] = llave(out_reg2(1), out_reg2(2), control2);
    out_switch2 = [out1; out2];

    % Delay 8D2
    InReg8D2(1) = out_switch2(1);
    % Asignacion de datos_line1 al Registro
    [OutLat8D2, OutReg8D2] = RegIn(Lat8D2, InReg8D2); 
    % Dato de salida
    out_reg2 = [ OutReg8D2; out_switch2(2)];
    
    %%% STAGE_3 %%%
    [out1, out2] = BF(out_reg2(1), out_reg2(2));
    out_bf3 = [out1; out2];
    
    % Multiplicador M3
    activo_min = numreg16D+numreg8D-1;
    activo_max = numreg16D+numreg8D+length(twiddle3_l1);
    if(activo_min<clk && clk<activo_max) % clk: 24,...,55
        idx3 = clk-numreg16D-numreg8D+1;
        % Line1 A
        [out_bf3(1)] = Mult(out_bf3(1), twiddle3_l1(1,idx3), "true");
        % Line1 B
        [out_bf3(2)] = Mult(out_bf3(2), twiddle3_l1(2,idx3), "true");  
    end
    out_mult3 = [out_bf3(1); out_bf3(2)];

    % Delay 4D1
    InReg4D1(1) = out_mult3(2);
    % Asignacion de datos_line1 al Registro
    [OutLat4D1, OutReg4D1] = RegIn(Lat4D1, InReg4D1);   
    % Dato de salida
    out_reg3 = [ out_mult3(1); OutReg4D1];
    
    % Divisor de Frecuencia
    if(cnt3<=DivFrec3-1)
        o_frec3 = 0;
    elseif(cnt3>=DivFrec3)
        o_frec3 = 1;
    end
    
    if(cnt3==2*DivFrec3-1)
        cnt3 = 0;
    else
        cnt3 = cnt3+1;
    end  
    % Llave 3
    control3 = o_frec3;
    [out1, out2] = llave(out_reg3(1), out_reg3(2), control3);
    out_switch3 = [out1; out2];

    % Delay 4D2
    InReg4D2(1) = out_switch3(1);
    % Asignacion de datos_line1 al Registro
    [OutLat4D2, OutReg4D2] = RegIn(Lat4D2, InReg4D2);  
    % Dato de salida
    out_reg3 = [ OutReg4D2; out_switch3(2)];

    %%% STAGE_4 %%%    
    [out1, out2] = BF(out_reg3(1), out_reg3(2));
    out_bf4 = [out1; out2];
    
    % Multiplicador M4
    activo_min = numreg16D+numreg8D+numreg4D-1;
    activo_max = numreg16D+numreg8D+numreg4D+length(twiddle4_l1);
    if(activo_min<clk && clk<activo_max) % clk: 28,...,59
        idx4 = clk-numreg16D-numreg8D-numreg4D+1;
        % Line1 A
        [out_bf4(1)] = Mult(out_bf4(1), twiddle4_l1(1,idx4), "true");
        % Line1 B
        [out_bf4(2)] = Mult(out_bf4(2), twiddle4_l1(2,idx4), "true");  
    end
    out_mult4 = [out_bf4(1); out_bf4(2)];  
    
    % Delay 2D1
    InReg2D1(1) = out_mult4(2);
    % Asignacion de datos_line1 al Registro
    [OutLat2D1, OutReg2D1] = RegIn(Lat2D1, InReg2D1);   
    % Dato de salida
    out_reg4 = [ out_mult4(1); OutReg2D1];
    
    % Divisor de Frecuencia
    if(cnt4<=DivFrec4-1)
        o_frec4 = 0;
    elseif(cnt4>=DivFrec4)
        o_frec4 = 1;
    end
    
    if(cnt4==2*DivFrec4-1)
        cnt4 = 0;
    else
        cnt4 = cnt4+1;
    end  
    % Llave 4
    control4 = o_frec4;
    [out1, out2] = llave(out_reg4(1), out_reg4(2), control4);
    out_switch4 = [out1; out2];

    % Delay 2D2
    InReg2D2(1) = out_switch4(1);
    % Asignacion de datos_line1 al Registro
    [OutLat2D2, OutReg2D2] = RegIn(Lat2D2, InReg2D2);   
    % Dato de salida
    out_reg4 = [ OutReg2D2; out_switch4(2)];
    
    %%% STAGE_5 %%%    
    [out1, out2] = BF(out_reg4(1), out_reg4(2));
    out_bf5 = [out1; out2];
    
    % Multiplicador M5
    activo_min = numreg16D+numreg8D+numreg4D+numreg2D-1;
    activo_max = numreg16D+numreg8D+numreg4D+numreg2D+length(twiddle5_l1);
    if(activo_min<clk && clk<activo_max) % clk: 30,...,61
        idx5 = clk-numreg16D-numreg8D-numreg4D-numreg2D+1;
        % Line1 A
        [out_bf5(1)] = Mult(out_bf5(1), twiddle5_l1(1,idx5), "true");
        % Line1 B
        [out_bf5(2)] = Mult(out_bf5(2), twiddle5_l1(2,idx5), "true");  
    end
    out_mult5 = [out_bf5(1); out_bf5(2)];      

    % Delay 1D1
    InReg1D1(1) = out_mult5(2);
    % Asignacion de datos_line1 al Registro
    [OutLat1D1, OutReg1D1] = RegIn(Lat1D1, InReg1D1);   
    % Dato de salida
    out_reg5 = [ out_mult5(1); OutReg1D1];
    
    % Divisor de Frecuencia
    if(cnt5<=DivFrec5-1)
        o_frec5 = 0;
    elseif(cnt5>=DivFrec5)
        o_frec5 = 1;
    end
    
    if(cnt5==2*DivFrec5-1)
        cnt5 = 0;
    else
        cnt5 = cnt5+1;
    end  
    % Llave 5
    control5 = o_frec5;
    [out1, out2] = llave(out_reg5(1), out_reg5(2), control5);
    out_switch5 = [out1; out2];

    % Delay 1D2
    InReg1D2(1) = out_switch5(1);
    % Asignacion de datos_line1 al Registro
    [OutLat1D2, OutReg1D2] = RegIn(Lat1D2, InReg1D2);  
    % Dato de salida
    out_reg5 = [ OutReg1D2; out_switch5(2)];
    
    %%% STAGE_6 %%%     
    [out1, out2] = BF(out_reg5(1), out_reg5(2));
    out_bf6 = [out1; out2];
    
    % Multiplicador M6
    activo_min = numreg16D+numreg8D+numreg4D+numreg2D+numreg1D-1;
    activo_max = numreg16D+numreg8D+numreg4D+numreg2D+numreg1D+length(twiddle6_l1);
    if(activo_min<clk && clk<activo_max) % clk: 31,...,62
        idx6 = clk-numreg16D-numreg8D-numreg4D-numreg2D-numreg1D+1;
        % Line1 A
        [out_bf6(1)] = Mult(out_bf6(1), twiddle6_l1(1,idx6), "true");
        % Line1 B
        [out_bf6(2)] = Mult(out_bf6(2), twiddle6_l1(2,idx6), "true");  
    end
    out_mult6 = [out_bf6(1); out_bf6(2)]; 
    
    % Delay 16D1
    InReg16D1p(1) = out_mult6(2);
    % Asignacion de datos_line1 al Registro
    [OutLat16D1p, OutReg16D1p] = RegIn(Lat16D1p, InReg16D1p);   
    % Dato de salida
    out_reg6 = [ out_mult6(1); OutReg16D1p];
    
    % Divisor de Frecuencia
    if(cnt6<=DivFrec6-1)
        o_frec6 = 0;
    elseif(cnt6>=DivFrec6)
        o_frec6 = 1;
    end
    
    if(cnt6==2*DivFrec6-1)
        cnt6 = 0;
    else
        cnt6 = cnt6+1;
    end  
    % Llave 6
    control6 = o_frec6;
    [out1, out2] = llave(out_reg6(1), out_reg6(2), control6);
    out_switch6 = [out1; out2];

    % Delay 16D2
    InReg16D2p(1) = out_switch6(1);
    % Asignacion de datos_line1 al Registro
    [OutLat16D2p, OutReg16D2p] = RegIn(Lat16D2p, InReg16D2p);  
    % Dato de salida
    out_reg6 = [ OutReg16D2p; out_switch6(2)]; 

    %%% STAGE_7 %%%     
    [out1, out2] = BF(out_reg6(1), out_reg6(2));
    out_bf7 = [out1; out2];
    out1;
    
    %% LINE2
    %%% STAGE 1 %%%
    % Delay 16D1
    InReg16D1_l2(1) = out_mult1_l2(2);
    % Asignacion de datos_line1 al Registro
    [OutLat16D1_l2, OutReg16D1_l2] = RegIn(Lat16D1_l2, InReg16D1_l2);   
    % Dato de salida
    out_reg1_l2 = [out_mult1(2); OutReg16D1_l2];
   
    % Llave
    [out1_l2, out2_l2] = llave(out_reg1_l2(1), out_reg1_l2(2), control1);
    out_switch1_l2 = [out1_l2; out2_l2];
    
    % Delay 16D2
    InReg16D2_l2(1) = out_switch1_l2(1);
    % Asignacion de datos_line1 al Registro
    [OutLat16D2_l2, OutReg16D2_l2] = RegIn(Lat16D2_l2, InReg16D2_l2);   
    % Dato de salida
    out_reg1_l2 = [ OutReg16D2_l2; out_switch1_l2(2)];
    
    %%% STAGE_2 %%%    
    [out1_l2, out2_l2] = BF(out_reg1_l2(1), out_reg1_l2(2));
    out_bf2_l2 = [out1_l2; out2_l2];
    
    % Multiplicador M2
    % Instante en el cual el multiplicador esta activo
    activo_min = numreg16D-1;
    activo_max = numreg16D+length(twiddle2_l2);
    if(activo_min<clk && clk<activo_max) % clk: 16,...,47
        idx2 = clk-numreg16D+1;
        % Line1 A
        [out_bf2_l2(1)] = Mult(out_bf2_l2(1), twiddle2_l2(1,idx2), "true");
        % Line1 B
        [out_bf2_l2(2)] = Mult(out_bf2_l2(2), twiddle2_l2(2,idx2), "true");   
    end
    out_mult2_l2 = [out_bf2_l2(1); out_bf2_l2(2)];
    
    % Delay 8D1
    InReg8D1_l2(1) = out_mult2_l2(2);
    % Asignacion de datos_line1 al Registro
    [OutLat8D1_l2, OutReg8D1_l2] = RegIn(Lat8D1_l2, InReg8D1_l2);   
    % Dato de salida
    out_reg2_l2 = [ out_mult2_l2(1); OutReg8D1_l2];
     
    % Llave 2
    [out1_l2, out2_l2] = llave(out_reg2_l2(1), out_reg2_l2(2), control2);
    out_switch2_l2 = [out1_l2; out2_l2];

    % Delay 8D2
    InReg8D2_l2(1) = out_switch2_l2(1);
    % Asignacion de datos_line1 al Registro
    [OutLat8D2_l2, OutReg8D2_l2] = RegIn(Lat8D2_l2, InReg8D2_l2); 
    % Dato de salida
    out_reg2_l2 = [ OutReg8D2_l2; out_switch2_l2(2)];  
    
    %%% STAGE_3 %%%
    [out1_l2, out2_l2] = BF(out_reg2_l2(1), out_reg2_l2(2));
    out_bf3_l2 = [out1_l2; out2_l2];
    
    % Multiplicador M3
    activo_min = numreg16D+numreg8D-1;
    activo_max = numreg16D+numreg8D+length(twiddle3_l2);
    if(activo_min<clk && clk<activo_max) % clk: 24,...,55
        idx3 = clk-numreg16D-numreg8D+1;
        % Line1 A
        [out_bf3_l2(1)] = Mult(out_bf3_l2(1), twiddle3_l2(1,idx3), "true");
        % Line1 B
        [out_bf3_l2(2)] = Mult(out_bf3_l2(2), twiddle3_l2(2,idx3), "true");  
    end
    out_mult3_l2 = [out_bf3_l2(1); out_bf3_l2(2)];

    % Delay 4D1
    InReg4D1_l2(1) = out_mult3_l2(2);
    % Asignacion de datos_line1 al Registro
    [OutLat4D1_l2, OutReg4D1_l2] = RegIn(Lat4D1_l2, InReg4D1_l2);   
    % Dato de salida
    out_reg3_l2 = [ out_mult3_l2(1); OutReg4D1_l2];
 
    % Llave 3
    [out1_l2, out2_l2] = llave(out_reg3_l2(1), out_reg3_l2(2), control3);
    out_switch3_l2 = [out1_l2; out2_l2];

    % Delay 4D2
    InReg4D2_l2(1) = out_switch3_l2(1);
    % Asignacion de datos_line1 al Registro
    [OutLat4D2_l2, OutReg4D2_l2] = RegIn(Lat4D2_l2, InReg4D2_l2);  
    % Dato de salida
    out_reg3_l2 = [ OutReg4D2_l2; out_switch3_l2(2)];    
    
    %%% STAGE_4 %%%    
    [out1_l2, out2_l2] = BF(out_reg3_l2(1), out_reg3_l2(2));
    out_bf4_l2 = [out1_l2; out2_l2];
    
    % Multiplicador M4
    activo_min = numreg16D+numreg8D+numreg4D-1;
    activo_max = numreg16D+numreg8D+numreg4D+length(twiddle4_l2);
    if(activo_min<clk && clk<activo_max) % clk: 28,...,59
        idx4 = clk-numreg16D-numreg8D-numreg4D+1;
        % Line1 A
        [out_bf4_l2(1)] = Mult(out_bf4_l2(1), twiddle4_l2(1,idx4), "true");
        % Line1 B
        [out_bf4_l2(2)] = Mult(out_bf4_l2(2), twiddle4_l2(2,idx4), "true");  
    end
    out_mult4_l2 = [out_bf4_l2(1); out_bf4_l2(2)];  
    
    % Delay 2D1
    InReg2D1_l2(1) = out_mult4_l2(2);
    % Asignacion de datos_line1 al Registro
    [OutLat2D1_l2, OutReg2D1_l2] = RegIn(Lat2D1_l2, InReg2D1_l2);   
    % Dato de salida
    out_reg4_l2 = [ out_mult4_l2(1); OutReg2D1_l2];
 
    % Llave 4
    [out1_l2, out2_l2] = llave(out_reg4_l2(1), out_reg4_l2(2), control4);
    out_switch4_l2 = [out1_l2; out2_l2];

    % Delay 2D2
    InReg2D2_l2(1) = out_switch4_l2(1);
    % Asignacion de datos_line1 al Registro
    [OutLat2D2_l2, OutReg2D2_l2] = RegIn(Lat2D2_l2, InReg2D2_l2);   
    % Dato de salida
    out_reg4_l2 = [ OutReg2D2_l2; out_switch4_l2(2)];    
    
    %%% STAGE_5 %%%    
    [out1_l2, out2_l2] = BF(out_reg4_l2(1), out_reg4_l2(2));
    out_bf5_l2 = [out1_l2; out2_l2];
    
    % Multiplicador M5
    activo_min = numreg16D+numreg8D+numreg4D+numreg2D-1;
    activo_max = numreg16D+numreg8D+numreg4D+numreg2D+length(twiddle5_l2);
    if(activo_min<clk && clk<activo_max) % clk: 30,...,61
        idx5 = clk-numreg16D-numreg8D-numreg4D-numreg2D+1;
        % Line1 A
        [out_bf5_l2(1)] = Mult(out_bf5_l2(1), twiddle5_l2(1,idx5), "true");
        % Line1 B
        [out_bf5_l2(2)] = Mult(out_bf5_l2(2), twiddle5_l2(2,idx5), "true");  
    end
    out_mult5_l2 = [out_bf5_l2(1); out_bf5_l2(2)];      

    % Delay 1D1
    InReg1D1_l2(1) = out_mult5_l2(2);
    % Asignacion de datos_line1 al Registro
    [OutLat1D1_l2, OutReg1D1_l2] = RegIn(Lat1D1_l2, InReg1D1_l2);   
    % Dato de salida
    out_reg5_l2 = [ out_mult5_l2(1); OutReg1D1_l2];

    % Llave 5
    [out1_l2, out2_l2] = llave(out_reg5_l2(1), out_reg5_l2(2), control5);
    out_switch5_l2 = [out1_l2; out2_l2];

    % Delay 1D2
    InReg1D2_l2(1) = out_switch5_l2(1);
    % Asignacion de datos_line1 al Registro
    [OutLat1D2_l2, OutReg1D2_l2] = RegIn(Lat1D2_l2, InReg1D2_l2);  
    % Dato de salida
    out_reg5_l2 = [ OutReg1D2_l2; out_switch5_l2(2)];    
    
     %%% STAGE_6 %%%     
    [out1_l2, out2_l2] = BF(out_reg5_l2(1), out_reg5_l2(2));
    out_bf6_l2 = [out1_l2; out2_l2];
    
    % Multiplicador M6
    activo_min = numreg16D+numreg8D+numreg4D+numreg2D+numreg1D-1;
    activo_max = numreg16D+numreg8D+numreg4D+numreg2D+numreg1D+length(twiddle6_l2);
    if(activo_min<clk && clk<activo_max) % clk: 31,...,62
        idx6 = clk-numreg16D-numreg8D-numreg4D-numreg2D-numreg1D+1;
        % Line1 A
        [out_bf6_l2(1)] = Mult(out_bf6_l2(1), twiddle6_l2(1,idx6), "true");
        % Line1 B
        [out_bf6_l2(2)] = Mult(out_bf6_l2(2), twiddle6_l2(2,idx6), "true");  
    end
    out_mult6_l2 = [out_bf6_l2(1); out_bf6_l2(2)]; 
    
    % Delay 16D1
    InReg16D1p_l2(1) = out_mult6_l2(2);
    % Asignacion de datos_line1 al Registro
    [OutLat16D1p_l2, OutReg16D1p_l2] = RegIn(Lat16D1p_l2, InReg16D1p_l2);   
    % Dato de salida
    out_reg6_l2 = [ out_mult6_l2(1); OutReg16D1p_l2];
  
    % Llave 6
    [out1_l2, out2_l2] = llave(out_reg6_l2(1), out_reg6_l2(2), control6);
    out_switch6_l2 = [out1_l2; out2_l2];

    % Delay 16D2
    InReg16D2p_l2(1) = out_switch6_l2(1);
    % Asignacion de datos_line1 al Registro
    [OutLat16D2p_l2, OutReg16D2p_l2] = RegIn(Lat16D2p_l2, InReg16D2p_l2);  
    % Dato de salida
    out_reg6_l2 = [ OutReg16D2p_l2; out_switch6_l2(2)];   
    
    %%% STAGE_7 %%%     
    [out1_l2, out2_l2] = BF(out_reg6_l2(1), out_reg6_l2(2));
    out_bf7_l2 = [out1_l2; out2_l2];
    
    %% Salida DFT Paralelo 4
    Xk = [out_bf7;out_bf7_l2];
    Xsalida(:,clk+1) = Xk;
 
    %% Actualizo Todos los Registros del LINE 1 A/B
    [Lat16D1,  InReg16D1]  = RegUp(OutLat16D1,  InReg16D1);
    [Lat16D2,  InReg16D2]  = RegUp(OutLat16D2,  InReg16D2);
    [Lat8D1,   InReg8D1]   = RegUp(OutLat8D1,   InReg8D1);
    [Lat8D2,   InReg8D2]   = RegUp(OutLat8D2,   InReg8D2);
    [Lat4D1,   InReg4D1]   = RegUp(OutLat4D1,   InReg4D1);
    [Lat4D2,   InReg4D2]   = RegUp(OutLat4D2,   InReg4D2);
    [Lat2D1,   InReg2D1]   = RegUp(OutLat2D1,   InReg2D1);
    [Lat2D2,   InReg2D2]   = RegUp(OutLat2D2,   InReg2D2);    
    [Lat1D1,   InReg1D1]   = RegUp(OutLat1D1,   InReg1D1);
    [Lat1D2,   InReg1D2]   = RegUp(OutLat1D2,   InReg1D2);
    [Lat16D1p, InReg16D1p] = RegUp(OutLat16D1p, InReg16D1p);
    [Lat16D2p, InReg16D2p] = RegUp(OutLat16D2p, InReg16D2p);
    
    % Actualizo Todos los Registros del LINE 2 A/B
    [Lat16D1_l2,  InReg16D1_l2]  = RegUp(OutLat16D1_l2,  InReg16D1_l2);
    [Lat16D2_l2,  InReg16D2_l2]  = RegUp(OutLat16D2_l2,  InReg16D2_l2);
    [Lat8D1_l2,   InReg8D1_l2]   = RegUp(OutLat8D1_l2,   InReg8D1_l2);
    [Lat8D2_l2,   InReg8D2_l2]   = RegUp(OutLat8D2_l2,   InReg8D2_l2);    
    [Lat4D1_l2,   InReg4D1_l2]   = RegUp(OutLat4D1_l2,   InReg4D1_l2);
    [Lat4D2_l2,   InReg4D2_l2]   = RegUp(OutLat4D2_l2,   InReg4D2_l2);
    [Lat2D1_l2,   InReg2D1_l2]   = RegUp(OutLat2D1_l2,   InReg2D1_l2);
    [Lat2D2_l2,   InReg2D2_l2]   = RegUp(OutLat2D2_l2,   InReg2D2_l2);    
    [Lat1D1_l2,   InReg1D1_l2]   = RegUp(OutLat1D1_l2,   InReg1D1_l2);
    [Lat1D2_l2,   InReg1D2_l2]   = RegUp(OutLat1D2_l2,   InReg1D2_l2);
    [Lat16D1p_l2, InReg16D1p_l2] = RegUp(OutLat16D1p_l2, InReg16D1p_l2);
    [Lat16D2p_l2, InReg16D2p_l2] = RegUp(OutLat16D2p_l2, InReg16D2p_l2);    
end

%% Muestras de salida
Xsalida = Xsalida( :,delay_line+1:end);
% Convierto las muestras de DFT de Matriz a Vector
upTo = paralelo*length(Xsalida);
Xvector = zeros(1,upTo);

for index = (1:upTo)
    Xvector(index) = Xsalida(index);
end

% Ordenamiento de las muestras del vector.
Xvector = OrdSalidaParhi(Xvector);

% Plot
if(onPlot)
    figure();
    NFFT = N;
    out_dft = abs( fftshift(Xvector) );
    frec = fs*(-NFFT/2:NFFT/2-1)/NFFT;  
    stem(frec,out_dft, 'm')
    title('Double Sided FFT');       
    xlabel('Normalized Frequency')       
    ylabel('DFT Values');
    grid minor;
end

