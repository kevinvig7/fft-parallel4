%% Punto Fijo
clc; close all; clear;

%% Resolver
% En los instantes en los cuales se realizan las multiplicaciones los factores
% de twiddle tienen un determinado s(w,f). SIn embargo en este simulador el cual
% solo acepta la secuencia de entrada y lego las completa con ceros, no existe
% inconvenientes en los instantes de 'cero' porque el resultado de multiplicar
% por cero en PFijo es cero, sin embargo, si el simulador hubiera considerado
% una señal periodica el factor de multiplicacion se deberia volver de volver a
% repetir. En el caso de que el multiplicador se encuentre inactivo, lo cual
% corresponde a multiplicar por uno, pero manteniendo el registro de
% multiplicacion del tamaño adecuado en los instantes en los cuales si se
% multiplica, la multiplicacion por '1' en punto fijo al estar cuantizado no es
% preciso y en este simulador generario un valor diferente en el resultado de la
% multiplicacion, mirandolo desde el hardware esto no deberia de suceder porque
% solo seria un cable. LO mismo ocurriria para las multiplicacione por '-j'. Por
% eso que es bueno considerar si se emplean multiplicadores 'full' o 'trivial'.

%% General Config
% Directorio a las funciones en PFijo, PFlotante
addpath('PFijoFunciones');
R = Rutas();
addpath(R.R1);

% Preferencia de visualizacion de la funcion 'fi()'
fipref('NumericTypeDisplay','short',  'FimathDisplay','none');
Fmath = fimath('RoundingMethod','Floor',  'OverflowAction','Saturate');

onPlot = 1;
onEscritura = 1;

%% Muestras de entrada en Punto Fijo:
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
xn = VecOrdMat(xFi);
xn = fi(xn, S,W,F, Fmath);

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

%% Cuantizaciones Line 1/2
% Stage 1
S = 1;
% A
en1 = 'false';
Sm1A = S;
Im1A = 0;
Fm1A = 9;
Wm1A = Sm1A+Im1A+Fm1A;
% B
Sm1B = S;
Im1B = 0;
Fm1B = 9;
Wm1B = Sm1B+Im1B+Fm1B;

% Stage 2
% A
en2 = 'true';
Sm2A = S;
Im2A = 2;
Fm2A = 12;
Wm2A = Sm2A+Im2A+Fm2A;
% B
Sm2B = S;
Im2B = 2;
Fm2B = 12;
Wm2B = Sm2B+Im2B+Fm2B;

% Stage 3
% A
en3 = 'false';
Sm3A = S;
Im3A = 0;
Fm3A = 9;
Wm3A = Sm3A+Im3A+Fm3A;
% B
Sm3B = S;
Im3B = 0;
Fm3B = 9;
Wm3B = Sm3B+Im3B+Fm3B;

% Stage 4
% A
en4 = 'true';
Sm4A = S;
Im4A = 4;
Fm4A = 14;
Wm4A = Sm4A+Im4A+Fm4A;
% B
Sm4B = S;
Im4B = 4;
Fm4B = 14;
Wm4B = Sm4B+Im4B+Fm4B;

% Stage 5
% A
en5 = 'false';
Sm5A = S;
Im5A = 0;
Fm5A = 9;
Wm5A = Sm5A+Im5A+Fm5A;
% B
Sm5B = S;
Im5B = 0;
Fm5B = 9;
Wm5B = Sm5B+Im5B+Fm5B;

% Stage 6
% A
en6 = 'true';
Sm6A = S;
Im6A = 5;
Fm6A = 15;
Wm6A = Sm6A+Im6A+Fm6A;
% B
Sm6B = S;
Im6B = 5;
Fm6B = 15;
Wm6B = Sm6B+Im6B+Fm6B;

% Stage 7
% A
en7 = 'false';
Sm7A = S;
Im7A = 5;
Fm7A = 6;
Wm7A = Sm7A+Im7A+Fm7A;
% B
Sm7B = S;
Im7B = 5;
Fm7B = 6;
Wm7B = Sm7B+Im7B+Fm7B;

%% Twiddles
% Signo:
St = 1;
% Cantidad entera
It = 1;
% Cantidad Fraccional
Ft = 9;
% Cantidad Total de bits
Wt = St+It+Ft;

[twiddleFi,twiddleFlot,twiddleEq] = TwiddlesPfijo(St,Wt,Ft);
T = twiddleFi;
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
    [bf1(1).line1, bf1(2).line1] = BF(in(1), in(2));
    
    % Multiplicador M1
    activo_max = length(twiddle1_l1);
    if(clk<activo_max) % if(clk<4) clk: 0,1,2,3,...,31
        % Line1 
        mult1(1).line1 = bf1(1).line1; 
        mult1(2).line1 = bf1(2).line1 * twiddle1_l1(2,clk+1); 
    else
        mult1(1).line1 = bf1(1).line1;
        mult1(2).line1 = bf1(2).line1 * fi(1, St,Wt,Ft,Fmath);  
    end 
    % Bloque de Cuantizacion A/B 
    [c1A, c1B] = Cuantificacion(mult1(1).line1,S,Wm1A,Fm1A,  mult1(2).line1,S,Wm1B,Fm1B, en1);
    
    % LINE 2/STAGE 1
    in_l2 = datos_line2(:,clk+1);
    [bf1(1).line2, bf1(2).line2] = BF(in_l2(1), in_l2(2));
 
    % Multiplicador M1
    activo_max = length(twiddle1_l2);
    if(clk<activo_max) 
        % Line2 
        mult1(1).line2 = bf1(1).line2;
        mult1(2).line2 = bf1(2).line2 * twiddle1_l2(2,clk+1);   
    else
        mult1(1).line2 = bf1(1).line2;
        mult1(2).line2 = bf1(2).line2 * fi(1, St,Wt,Ft,Fmath);
    end
    % Bloque de Cuantizacion A/B  
    [c1Al2, c1Bl2] = Cuantificacion(mult1(1).line2,S,Wm1A,Fm1A,  mult1(2).line2,S,Wm1B,Fm1B, en1);
    
    %% LINE 1
    %## STAGE 1
    % Delay 16D1
    InReg16D1(1) = c1Al2;
    % Asignacion de datos_line1 al Registro
    [OutLat16D1, OutReg16D1] = RegIn(Lat16D1, InReg16D1);   
    % Dato de salida    
    out_reg1(1).line1 = c1A;
    out_reg1(2).line1 = fi(OutReg16D1,S,get(c1Al2,'WordLength'),get(c1Al2,'FractionLength'),Fmath); 
           
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
    [out_switch1(1).line1, out_switch1(2).line1] = llave(out_reg1(1).line1, out_reg1(2).line1, control1);
   
    % Delay 16D2
    InReg16D2(1) = out_switch1(1).line1;
    % Asignacion de datos_line1 al Registro
    [OutLat16D2, OutReg16D2] = RegIn(Lat16D2, InReg16D2); 
    % Dato de salida    
    out_reg1(1).line1 = fi(OutReg16D2,S,get(out_switch1(1).line1,'WordLength'),get(out_switch1(1).line1,'FractionLength'),Fmath); 
    out_reg1(2).line1 = out_switch1(2).line1;

    %## STAGE_2
    [bf2(1).line1, bf2(2).line1] = BF(out_reg1(1).line1, out_reg1(2).line1);
  
    % Multiplicador M2
    activo_min = numreg16D-1;
    activo_max = numreg16D+length(twiddle2_l1);
    if(activo_min<clk && clk<activo_max) % clk: 16,...,47
        idx2 = clk-numreg16D+1;
        % Line1 
        mult2(1).line1 = bf2(1).line1;
        mult2(2).line1 = bf2(2).line1 * twiddle2_l1(2,idx2);  
    else
        mult2(1).line1 = bf2(1).line1;
        mult2(2).line1 = bf2(2).line1 * fi(1, St,Wt,Ft,Fmath);        
    end
    % Bloque de Cuantizacion A/B 
    [c2A, c2B] = Cuantificacion(mult2(1).line1,S,Wm2A,Fm2A,  mult2(2).line1,S,Wm2B,Fm2B, en2);
   
    % Delay 8D1
    InReg8D1(1) = c2B;
    % Asignacion de datos_line1 al Registro
    [OutLat8D1, OutReg8D1] = RegIn(Lat8D1, InReg8D1);   
    % Dato de salida
    out_reg2(1).line1 = c2A;
    out_reg2(2).line1 = fi(OutReg8D1,S,get(c2B,'WordLength'),get(c2B,'FractionLength'),Fmath); 
    
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
    [out_switch2(1).line1, out_switch2(2).line1] = llave(out_reg2(1).line1, out_reg2(2).line1, control2);

    % Delay 8D2
    InReg8D2(1) = out_switch2(1).line1;
    % Asignacion de datos_line1 al Registro
    [OutLat8D2, OutReg8D2] = RegIn(Lat8D2, InReg8D2); 
    % Dato de salida    
    out_reg2(1).line1 = fi(OutReg8D2,S,get(out_switch2(1).line1,'WordLength'),get(out_switch2(1).line1,'FractionLength'),Fmath); 
    out_reg2(2).line1 = out_switch2(2).line1;
    
    %## STAGE_3
    [bf3(1).line1, bf3(2).line1] = BF(out_reg2(1).line1, out_reg2(2).line1);
    
    % Multiplicador M3
    activo_min = numreg16D+numreg8D-1;
    activo_max = numreg16D+numreg8D+length(twiddle3_l1);
    if(activo_min<clk && clk<activo_max) % clk: 24,...,55
        idx3 = clk-numreg16D-numreg8D+1;
        % Line1 
        mult3(1).line1 = bf3(1).line1 * twiddle3_l1(1,idx3);
        mult3(2).line1 = bf3(2).line1 * twiddle3_l1(2,idx3);
    else
        mult3(1).line1 = bf3(1).line1 * fi(1, St,Wt,Ft,Fmath);
        mult3(2).line1 = bf3(2).line1 * fi(1, St,Wt,Ft,Fmath);           
    end    
    % Bloque de Cuantizacion A/B 
    [c3A, c3B] = Cuantificacion(mult3(1).line1,S,Wm3A,Fm3A,  mult3(2).line1,S,Wm3B,Fm3B, en3);

    % Delay 4D1
    InReg4D1(1) = c3B;
    % Asignacion de datos_line1 al Registro
    [OutLat4D1, OutReg4D1] = RegIn(Lat4D1, InReg4D1);   
    % Dato de salida   
    out_reg3(1).line1 = c3A;
    out_reg3(2).line1 = fi(OutReg4D1,S,get(c3B,'WordLength'),get(c3B,'FractionLength'),Fmath); 
     
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
    [out_switch3(1).line1, out_switch3(2).line1] = llave(out_reg3(1).line1, out_reg3(2).line1, control3);

    % Delay 4D2
    InReg4D2(1) = out_switch3(1).line1;
    % Asignacion de datos_line1 al Registro
    [OutLat4D2, OutReg4D2] = RegIn(Lat4D2, InReg4D2);  
    % Dato de salida
    out_reg3(1).line1 = fi(OutReg4D2,S,get(out_switch3(1).line1,'WordLength'),get(out_switch3(1).line1,'FractionLength'),Fmath); 
    out_reg3(2).line1 = out_switch3(2).line1;
    
    %## STAGE_4    
    [bf4(1).line1, bf4(2).line1] = BF(out_reg3(1).line1, out_reg3(2).line1);
    
    % Multiplicador M4
    activo_min = numreg16D+numreg8D+numreg4D-1;
    activo_max = numreg16D+numreg8D+numreg4D+length(twiddle4_l1);
    if(activo_min<clk && clk<activo_max) % clk: 28,...,59
        idx4 = clk-numreg16D-numreg8D-numreg4D+1;
        mult4(1).line1 = bf4(1).line1; 
        mult4(2).line1 = bf4(2).line1 * twiddle4_l1(2,idx4); 
    else
        mult4(1).line1 = bf4(1).line1; 
        mult4(2).line1 = bf4(2).line1 * fi(1, St,Wt,Ft,Fmath);         
    end
    % Bloque de Cuantizacion A/B 
    [c4A, c4B] = Cuantificacion(mult4(1).line1,S,Wm4A,Fm4A,  mult4(2).line1,S,Wm4B,Fm4B, en4);
     
    % Delay 2D1
    InReg2D1(1) = c4B;
    % Asignacion de datos_line1 al Registro
    [OutLat2D1, OutReg2D1] = RegIn(Lat2D1, InReg2D1);   
    % Dato de salida
    out_reg4(1).line1 = c4A;
    out_reg4(2).line1 = fi(OutReg2D1,S,get(c4B,'WordLength'),get(c4B,'FractionLength'),Fmath); 
    
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
    [out_switch4(1).line1, out_switch4(2).line1] = llave(out_reg4(1).line1, out_reg4(2).line1, control4);
    
    % Delay 2D2
    InReg2D2(1) = out_switch4(1).line1;
    % Asignacion de datos_line1 al Registro
    [OutLat2D2, OutReg2D2] = RegIn(Lat2D2, InReg2D2);   
    % Dato de salida
    out_reg4(1).line1 = fi(OutReg2D2,S,get(out_switch4(1).line1,'WordLength'),get(out_switch4(1).line1,'FractionLength'),Fmath); 
    out_reg4(2).line1 = out_switch4(2).line1;    
       
    %## STAGE_5  
    [bf5(1).line1, bf5(2).line1] = BF(out_reg4(1).line1, out_reg4(2).line1);
    
    % Multiplicador M5
    activo_min = numreg16D+numreg8D+numreg4D+numreg2D-1;
    activo_max = numreg16D+numreg8D+numreg4D+numreg2D+length(twiddle5_l1);
    if(activo_min<clk && clk<activo_max) % clk: 30,...,61
        idx5 = clk-numreg16D-numreg8D-numreg4D-numreg2D+1;
        mult5(1).line1 = bf5(1).line1 * twiddle5_l1(1,idx5);
        mult5(2).line1 = bf5(2).line1 * twiddle5_l1(2,idx5);
    else
        mult5(1).line1 = bf5(1).line1 * fi(1, St,Wt,Ft,Fmath);
        mult5(2).line1 = bf5(2).line1 * fi(1, St,Wt,Ft,Fmath);      
    end
    % Bloque de Cuantizacion A/B 
    [c5A, c5B] = Cuantificacion(mult5(1).line1,S,Wm5A,Fm5A,  mult5(2).line1,S,Wm5B,Fm5B, en5);   

    % Delay 1D1
    InReg1D1(1) = c5B;
    % Asignacion de datos_line1 al Registro
    [OutLat1D1, OutReg1D1] = RegIn(Lat1D1, InReg1D1);   
    % Dato de salida
    out_reg5(1).line1 = c5A;
    out_reg5(2).line1 = fi(OutReg1D1,S,get(c5B,'WordLength'),get(c5B,'FractionLength'),Fmath);     
        
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
    [out_switch5(1).line1, out_switch5(2).line1] = llave(out_reg5(1).line1, out_reg5(2).line1, control5);

    % Delay 1D2
    InReg1D2(1) = out_switch5(1).line1;
    % Asignacion de datos_line1 al Registro
    [OutLat1D2, OutReg1D2] = RegIn(Lat1D2, InReg1D2);  
    % Dato de salida
    out_reg5(1).line1 = fi(OutReg1D2,S,get(out_switch5(1).line1,'WordLength'),get(out_switch5(1).line1,'FractionLength'),Fmath); 
    out_reg5(2).line1 = out_switch5(2).line1;      
    
    %## STAGE_6     
    [bf6(1).line1, bf6(2).line1] = BF(out_reg5(1).line1, out_reg5(2).line1);
    
    % Multiplicador M6
    activo_min = numreg16D+numreg8D+numreg4D+numreg2D+numreg1D-1;
    activo_max = numreg16D+numreg8D+numreg4D+numreg2D+numreg1D+length(twiddle6_l1);
    if(activo_min<clk && clk<activo_max) % clk: 31,...,62
        idx6 = clk-numreg16D-numreg8D-numreg4D-numreg2D-numreg1D+1;
        mult6(1).line1 = bf6(1).line1 * twiddle6_l1(1,idx6);
        mult6(2).line1 = bf6(2).line1 * twiddle6_l1(2,idx6); 
    else
        mult6(1).line1 = bf6(1).line1 * fi(1, St,Wt,Ft,Fmath);
        mult6(2).line1 = bf6(2).line1 * fi(1, St,Wt,Ft,Fmath);
    end
    % Bloque de Cuantizacion A/B 
    [c6A, c6B] = Cuantificacion(mult6(1).line1,S,Wm6A,Fm6A,  mult6(2).line1,S,Wm6B,Fm6B, en6);
    
    % Delay 16D1
    InReg16D1p(1) = c6B;
    % Asignacion de datos_line1 al Registro
    [OutLat16D1p, OutReg16D1p] = RegIn(Lat16D1p, InReg16D1p);   
    % Dato de salida
    out_reg6(1).line1 = c6A;
    out_reg6(2).line1 = fi(OutReg16D1p,S,get(c6B,'WordLength'),get(c6B,'FractionLength'),Fmath);     

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
    [out_switch6(1).line1, out_switch6(2).line1] = llave(out_reg6(1).line1, out_reg6(2).line1, control6);

    % Delay 16D2
    InReg16D2p(1) = out_switch6(1).line1;
    % Asignacion de datos_line1 al Registro
    [OutLat16D2p, OutReg16D2p] = RegIn(Lat16D2p, InReg16D2p);  
    % Dato de salida
    out_reg6(1).line1 = fi(OutReg16D2p,S,get(out_switch6(1).line1,'WordLength'),get(out_switch6(1).line1,'FractionLength'),Fmath); 
    out_reg6(2).line1 = out_switch6(2).line1; 

    %## STAGE_7  
    [bf7(1).line1, bf7(2).line1] = BF(out_reg6(1).line1, out_reg6(2).line1);
    % Bloque de Cuantizacion 7A/B 
    [c7A, c7B] = Cuantificacion(bf7(1).line1,S,Wm7A,Fm7A,  bf7(2).line1,S,Wm7B,Fm7B, en7);  
    
    %% LINE2    
    %## STAGE 1
    % Delay 16D1
    InReg16D1_l2(1) = c1Bl2;
    % Asignacion de datos_line1 al Registro
    [OutLat16D1_l2, OutReg16D1_l2] = RegIn(Lat16D1_l2, InReg16D1_l2);   
    % Dato de salida    
    out_reg1(1).line2 = c1B;
    out_reg1(2).line2 = fi(OutReg16D1_l2,S,get(c1Bl2,'WordLength'),get(c1Bl2,'FractionLength'),Fmath); 

    % Llave
    [out_switch1(1).line2, out_switch1(2).line2] = llave(out_reg1(1).line2, out_reg1(2).line2, control1);
   
    % Delay 16D2
    InReg16D2_l2(1) = out_switch1(1).line2;
    % Asignacion de datos_line1 al Registro
    [OutLat16D2_l2, OutReg16D2_l2] = RegIn(Lat16D2_l2, InReg16D2_l2); 
    % Dato de salida    
    out_reg1(1).line2 = fi(OutReg16D2_l2,S,get(out_switch1(1).line2,'WordLength'),get(out_switch1(1).line2,'FractionLength'),Fmath); 
    out_reg1(2).line2 = out_switch1(2).line2;

    %## STAGE_2      
    [bf2(1).line2, bf2(2).line2] = BF(out_reg1(1).line2, out_reg1(2).line2);
  
    % Multiplicador M2
    activo_min = numreg16D-1;
    activo_max = numreg16D+length(twiddle2_l2);
    if(activo_min<clk && clk<activo_max) % clk: 16,...,47
        idx2 = clk-numreg16D+1;
        % Line1 
        mult2(1).line2 = bf2(1).line2 * twiddle2_l2(1,idx2);
        mult2(2).line2 = bf2(2).line2 * twiddle2_l2(2,idx2);  
    else
        mult2(1).line2 = bf2(1).line2 * fi(1, St,Wt,Ft,Fmath);
        mult2(2).line2 = bf2(2).line2 * fi(1, St,Wt,Ft,Fmath);        
    end
    % Bloque de Cuantizacion A/B 
    [c2Al2, c2Bl2] = Cuantificacion(mult2(1).line2,S,Wm2A,Fm2A,  mult2(2).line2,S,Wm2B,Fm2B, en2);
   
    % Delay 8D1
    InReg8D1_l2(1) = c2Bl2;
    % Asignacion de datos_line1 al Registro
    [OutLat8D1_l2, OutReg8D1_l2] = RegIn(Lat8D1_l2, InReg8D1_l2);   
    % Dato de salida
    out_reg2(1).line2 = c2Al2;
    out_reg2(2).line2 = fi(OutReg8D1_l2,S,get(c2Bl2,'WordLength'),get(c2Bl2,'FractionLength'),Fmath); 
     
    % Llave 2
    [out_switch2(1).line2, out_switch2(2).line2] = llave(out_reg2(1).line2, out_reg2(2).line2, control2);

    % Delay 8D2
    InReg8D2_l2(1) = out_switch2(1).line2;
    % Asignacion de datos_line1 al Registro
    [OutLat8D2_l2, OutReg8D2_l2] = RegIn(Lat8D2_l2, InReg8D2_l2); 
    % Dato de salida    
    out_reg2(1).line2 = fi(OutReg8D2_l2,S,get(out_switch2(1).line2,'WordLength'),get(out_switch2(1).line2,'FractionLength'),Fmath); 
    out_reg2(2).line2 = out_switch2(2).line2;
    
    %## STAGE_3
    [bf3(1).line2, bf3(2).line2] = BF(out_reg2(1).line2, out_reg2(2).line2);
    
    % Multiplicador M3
    activo_min = numreg16D+numreg8D-1;
    activo_max = numreg16D+numreg8D+length(twiddle3_l2);
    if(activo_min<clk && clk<activo_max) % clk: 24,...,55
        idx3 = clk-numreg16D-numreg8D+1;
        % Line1 
        mult3(1).line2 = bf3(1).line2 * twiddle3_l2(1,idx3);
        mult3(2).line2 = bf3(2).line2 * twiddle3_l2(2,idx3);
    else
        mult3(1).line2 = bf3(1).line2 * fi(1, St,Wt,Ft,Fmath);
        mult3(2).line2 = bf3(2).line2 * fi(1, St,Wt,Ft,Fmath);           
    end    
    % Bloque de Cuantizacion A/B 
    [c3Al2, c3Bl2] = Cuantificacion(mult3(1).line2,S,Wm3A,Fm3A,  mult3(2).line2,S,Wm3B,Fm3B, en3);

    % Delay 4D1
    InReg4D1_l2(1) = c3Bl2;
    % Asignacion de datos_line1 al Registro
    [OutLat4D1_l2, OutReg4D1_l2] = RegIn(Lat4D1_l2, InReg4D1_l2);   
    % Dato de salida   
    out_reg3(1).line2 = c3Al2;
    out_reg3(2).line2 = fi(OutReg4D1_l2,S,get(c3Bl2,'WordLength'),get(c3Bl2,'FractionLength'),Fmath); 

    % Llave 3
    [out_switch3(1).line2, out_switch3(2).line2] = llave(out_reg3(1).line2, out_reg3(2).line2, control3);

    % Delay 4D2
    InReg4D2_l2(1) = out_switch3(1).line2;
    % Asignacion de datos_line1 al Registro
    [OutLat4D2_l2, OutReg4D2_l2] = RegIn(Lat4D2_l2, InReg4D2_l2);  
    % Dato de salida
    out_reg3(1).line2 = fi(OutReg4D2_l2,S,get(out_switch3(1).line2,'WordLength'),get(out_switch3(1).line2,'FractionLength'),Fmath); 
    out_reg3(2).line2 = out_switch3(2).line2;
    
    %## STAGE_4    
    [bf4(1).line2, bf4(2).line2] = BF(out_reg3(1).line2, out_reg3(2).line2);
    
    % Multiplicador M4
    activo_min = numreg16D+numreg8D+numreg4D-1;
    activo_max = numreg16D+numreg8D+numreg4D+length(twiddle4_l2);
    if(activo_min<clk && clk<activo_max) % clk: 28,...,59
        idx4 = clk-numreg16D-numreg8D-numreg4D+1;
        mult4(1).line2 = bf4(1).line2; 
        mult4(2).line2 = bf4(2).line2 * twiddle4_l2(2,idx4); 
    else
        mult4(1).line2 = bf4(1).line2; 
        mult4(2).line2 = bf4(2).line2 * fi(1, St,Wt,Ft,Fmath);         
    end
    % Bloque de Cuantizacion A/B 
    [c4Al2, c4Bl2] = Cuantificacion(mult4(1).line2,S,Wm4A,Fm4A,  mult4(2).line2,S,Wm4B,Fm4B, en4);
     
    % Delay 2D1
    InReg2D1_l2(1) = c4Bl2;
    % Asignacion de datos_line1 al Registro
    [OutLat2D1_l2, OutReg2D1_l2] = RegIn(Lat2D1_l2, InReg2D1_l2);   
    % Dato de salida
    out_reg4(1).line2 = c4Al2;
    out_reg4(2).line2 = fi(OutReg2D1_l2,S,get(c4Bl2,'WordLength'),get(c4Bl2,'FractionLength'),Fmath); 

    % Llave 4
    [out_switch4(1).line2, out_switch4(2).line2] = llave(out_reg4(1).line2, out_reg4(2).line2, control4);
    
    % Delay 2D2
    InReg2D2_l2(1) = out_switch4(1).line2;
    % Asignacion de datos_line1 al Registro
    [OutLat2D2_l2, OutReg2D2_l2] = RegIn(Lat2D2_l2, InReg2D2_l2);   
    % Dato de salida
    out_reg4(1).line2 = fi(OutReg2D2_l2,S,get(out_switch4(1).line2,'WordLength'),get(out_switch4(1).line2,'FractionLength'),Fmath); 
    out_reg4(2).line2 = out_switch4(2).line2;    
       
    %## STAGE_5  
    [bf5(1).line2, bf5(2).line2] = BF(out_reg4(1).line2, out_reg4(2).line2);
    
    % Multiplicador M5
    activo_min = numreg16D+numreg8D+numreg4D+numreg2D-1;
    activo_max = numreg16D+numreg8D+numreg4D+numreg2D+length(twiddle5_l2);
    if(activo_min<clk && clk<activo_max) % clk: 30,...,61
        idx5 = clk-numreg16D-numreg8D-numreg4D-numreg2D+1;
        mult5(1).line2 = bf5(1).line2 * twiddle5_l2(1,idx5);
        mult5(2).line2 = bf5(2).line2 * twiddle5_l2(2,idx5);
    else
        mult5(1).line2 = bf5(1).line2 * fi(1, St,Wt,Ft,Fmath);
        mult5(2).line2 = bf5(2).line2 * fi(1, St,Wt,Ft,Fmath);      
    end
    % Bloque de Cuantizacion A/B 
    [c5Al2, c5Bl2] = Cuantificacion(mult5(1).line2,S,Wm5A,Fm5A,  mult5(2).line2,S,Wm5B,Fm5B, en5);   

    % Delay 1D1
    InReg1D1_l2(1) = c5Bl2;
    % Asignacion de datos_line1 al Registro
    [OutLat1D1_l2, OutReg1D1_l2] = RegIn(Lat1D1_l2, InReg1D1_l2);   
    % Dato de salida
    out_reg5(1).line2 = c5Al2;
    out_reg5(2).line2 = fi(OutReg1D1_l2,S,get(c5Bl2,'WordLength'),get(c5Bl2,'FractionLength'),Fmath);     

    % Llave 5
    [out_switch5(1).line2, out_switch5(2).line2] = llave(out_reg5(1).line2, out_reg5(2).line2, control5);

    % Delay 1D2
    InReg1D2_l2(1) = out_switch5(1).line2;
    % Asignacion de datos_line1 al Registro
    [OutLat1D2_l2, OutReg1D2_l2] = RegIn(Lat1D2_l2, InReg1D2_l2);  
    % Dato de salida
    out_reg5(1).line2 = fi(OutReg1D2_l2,S,get(out_switch5(1).line2,'WordLength'),get(out_switch5(1).line2,'FractionLength'),Fmath); 
    out_reg5(2).line2 = out_switch5(2).line2;      
    
    %## STAGE_6     
    [bf6(1).line2, bf6(2).line2] = BF(out_reg5(1).line2, out_reg5(2).line2);
    
    % Multiplicador M6
    activo_min = numreg16D+numreg8D+numreg4D+numreg2D+numreg1D-1;
    activo_max = numreg16D+numreg8D+numreg4D+numreg2D+numreg1D+length(twiddle6_l2);
    if(activo_min<clk && clk<activo_max) % clk: 31,...,62
        idx6 = clk-numreg16D-numreg8D-numreg4D-numreg2D-numreg1D+1;
        mult6(1).line2 = bf6(1).line2 * twiddle6_l2(1,idx6);
        mult6(2).line2 = bf6(2).line2 * twiddle6_l2(2,idx6); 
    else
        mult6(1).line2 = bf6(1).line2 * fi(1, St,Wt,Ft,Fmath);
        mult6(2).line2 = bf6(2).line2 * fi(1, St,Wt,Ft,Fmath);
    end
    % Bloque de Cuantizacion A/B 
    [c6Al2, c6Bl2] = Cuantificacion(mult6(1).line2,S,Wm6A,Fm6A,  mult6(2).line2,S,Wm6B,Fm6B, en6);
    
    % Delay 16D1
    InReg16D1p_l2(1) = c6Bl2;
    % Asignacion de datos_line1 al Registro
    [OutLat16D1p_l2, OutReg16D1p_l2] = RegIn(Lat16D1p_l2, InReg16D1p_l2);   
    % Dato de salida
    out_reg6(1).line2 = c6Al2;
    out_reg6(2).line2 = fi(OutReg16D1p_l2,S,get(c6Bl2,'WordLength'),get(c6Bl2,'FractionLength'),Fmath);     
 
    % Llave 6
    [out_switch6(1).line2, out_switch6(2).line2] = llave(out_reg6(1).line2, out_reg6(2).line2, control6);

    % Delay 16D2
    InReg16D2p_l2(1) = out_switch6(1).line2;
    % Asignacion de datos_line1 al Registro
    [OutLat16D2p_l2, OutReg16D2p_l2] = RegIn(Lat16D2p_l2, InReg16D2p_l2);  
    % Dato de salida
    out_reg6(1).line2 = fi(OutReg16D2p_l2,S,get(out_switch6(1).line2,'WordLength'),get(out_switch6(1).line2,'FractionLength'),Fmath); 
    out_reg6(2).line2 = out_switch6(2).line2; 

    %## STAGE_7  
    [bf7(1).line2, bf7(2).line2] = BF(out_reg6(1).line2, out_reg6(2).line2);
    % Bloque de Cuantizacion 7A/B
    [c7Al2, c7Bl2] = Cuantificacion(bf7(1).line2,S,Wm7A,Fm7A,  bf7(2).line2,S,Wm7B,Fm7B, en7);
        
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
    
    %% Salida DFT Paralelo 4  
    % Salida representada en su forma Flotante del ultimo Stage 7
    Xsalida(:,clk+1) = [c7A.double;c7B.double;  c7Al2.double;c7Bl2.double];
    
    % Estructuras que van almacenando las salidas de los cuantizadores por cada 
    % etapa a medida que avanza el reloj.
    Xs1(1).ck(clk+1) = c1A;
    Xs1(2).ck(clk+1) = c1B; 
    Xs1(3).ck(clk+1) = c1Al2;
    Xs1(4).ck(clk+1) = c1Bl2;  
    
    Xs2(1).ck(clk+1) = c2A;
    Xs2(2).ck(clk+1) = c2B;
    Xs2(3).ck(clk+1) = c2Al2;
    Xs2(4).ck(clk+1) = c2Bl2; 
    
    Xs3(1).ck(clk+1) = c3A;
    Xs3(2).ck(clk+1) = c3B;
    Xs3(3).ck(clk+1) = c3Al2;
    Xs3(4).ck(clk+1) = c3Bl2; 
    
    Xs4(1).ck(clk+1) = c4A;
    Xs4(2).ck(clk+1) = c4B;
    Xs4(3).ck(clk+1) = c4Al2;
    Xs4(4).ck(clk+1) = c4Bl2;   

    Xs5(1).ck(clk+1) = c5A;
    Xs5(2).ck(clk+1) = c5B;
    Xs5(3).ck(clk+1) = c5Al2;
    Xs5(4).ck(clk+1) = c5Bl2;  
    
    Xs6(1).ck(clk+1) = c6A;
    Xs6(2).ck(clk+1) = c6B;
    Xs6(3).ck(clk+1) = c6Al2;
    Xs6(4).ck(clk+1) = c6Bl2; 

    Xs7(1).ck(clk+1) = c7A;
    Xs7(2).ck(clk+1) = c7B;
    Xs7(3).ck(clk+1) = c7Al2;
    Xs7(4).ck(clk+1) = c7Bl2; 
        
end

%% Analisis a la Salida de los Cuantizadores
[Vm2,~] = max(real(Xs7(1).ck));
[Vm2,~] = max(imag(Xs7(1).ck));
[Vm2,~] = max(real(Xs7(2).ck));
[Vm2,~] = max(imag(Xs7(2).ck));
[Vm2,~] = max(real(Xs7(3).ck));
[Vm2,~] = max(imag(Xs7(3).ck));
[Vm2,~] = max(real(Xs7(4).ck));
[Vm2,~] = max(imag(Xs7(4).ck));

%return;
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

%% Error de la salida
% Lectura de Archivos Salida flotante
XfltReal = fopen('XflotReal.txt', 'r');
XfltImag = fopen('XflotImag.txt', 'r');

XflotReal = fscanf(XfltReal,'%f')';
XflotImag = fscanf(XfltImag,'%f')';

fclose(XfltReal);
fclose(XfltImag);

% Calculo Potencia
XfixedReal = real(Xvector);
XfixedImag = imag(Xvector);
% Parte Real
PsignalR = var(XflotReal);
PerrorR  = var(XflotReal-XfixedReal);
SNRreal  = 10*log10(PsignalR/PerrorR);
% Parte Imaginaria
PsignalI = var(XflotImag);
PerrorI  = var(XflotImag-XfixedImag);
SNRimag  = 10*log10(PsignalI/PerrorI);

%% Plot
if(onPlot)
    figure();
    NFFT = N;
    out_dft = real( fftshift(Xvector) );
    frec = fs*(-NFFT/2:NFFT/2-1)/NFFT;  
    stem(frec,out_dft, 'm')
    title('DFT 128 points Parallel 4 Radix2^3');       
    xlabel('Frequency')       
    ylabel('DFT Values');
    grid minor;
end

%% Escritura de Muestras
if (onEscritura)
    % Muestras de Entrada
    % 79(clk)*4(etapas) = 316 valores almacenados
    Input128 = fopen ('ArchivosDatos/Input128.dat','wt');

    in128 = [datos_line1;datos_line2];
    [row, column] = size(in128);

    for columna = (1:column)
        for fila = (1:row)
            Re = real(in128(fila,columna));
            Im = imag(in128(fila,columna));
            % Escribe en Archivo
            fprintf(Input128,[Re.bin Im.bin '\n']);
        end
    end
    fclose(Input128);

    % Muestras de Rotadores.
    % 32(factores)*4(etapas) = 128 valores almacenados
    RotadorStage1 = fopen ('ArchivosDatos/RotadorStage1.dat','wt');
    RotadorStage2 = fopen ('ArchivosDatos/RotadorStage2.dat','wt');
    RotadorStage3 = fopen ('ArchivosDatos/RotadorStage3.dat','wt');
    RotadorStage4 = fopen ('ArchivosDatos/RotadorStage4.dat','wt');
    RotadorStage5 = fopen ('ArchivosDatos/RotadorStage5.dat','wt');
    RotadorStage6 = fopen ('ArchivosDatos/RotadorStage6.dat','wt');

    [row, column] = size(twiddleFi);
    % Factor seis: seis stages de rotadores
    rotforstage = 6;
    n = row/rotforstage;

    for columna = (1:column)
        for fila = (1:row)
            Re = real(twiddleFi(fila,columna));
            Im = imag(twiddleFi(fila,columna));
            % Escribe en Archivo
            if(fila<=n)
                fprintf(RotadorStage1,[Re.bin Im.bin '\n']);
            elseif(n<fila && fila<=n*2)
                fprintf(RotadorStage2,[Re.bin Im.bin '\n']);         
            elseif(n*2<fila && fila<=n*3)
                fprintf(RotadorStage3,[Re.bin Im.bin '\n']);
            elseif(n*3<fila && fila<=n*4)
                fprintf(RotadorStage4,[Re.bin Im.bin '\n']);            
            elseif(n*4<fila && fila<=n*5)
                fprintf(RotadorStage5,[Re.bin Im.bin '\n']);
            elseif(n*5<fila && fila<=n*6)
                fprintf(RotadorStage6,[Re.bin Im.bin '\n']);            
            end
        end
    end
    fclose(RotadorStage1);
    fclose(RotadorStage2);
    fclose(RotadorStage3);
    fclose(RotadorStage4);
    fclose(RotadorStage5);
    fclose(RotadorStage6);

    % Muestras de las Etapas
    % 79(clk)*4(etapas) = 316 valores almacenados
    % Especificar que "Etapa" se desea almacenar.
    Etapa = Xs7;
    % Este almacenamiento contendra los "Instantes" de la señal
    Output128 = fopen ('ArchivosDatos/Output128.dat','wt');

    [row, column] = size(Etapa(1).ck);

    for columna = (1:column)
        for fila = (1:row*paralelo)
            Re = real(Etapa(fila).ck(columna)); 
            Im = imag(Etapa(fila).ck(columna));
            % Escribe en Archivo
            fprintf(Output128,[Re.bin Im.bin '\n']);
        end
    end
    fclose(Output128);
end
