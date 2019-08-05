clc
close
clear

% xn, Muestra de entrada para test
N = 128;
Radix = 8;
% x = [1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0];
% x = ones(1,N);
x = [ones(1,6), zeros(1,N-6)];
i = 1;

%% Stage 10

num_but = N/2;
% Existen N/2 butterfly, cada uno con 2 entradas, por lo cual el vector bf_stage1 posee N entradas.
bf_stage1 = zeros(1,N);

for index = 1:(num_but)
    % puntero, indica a que butterfly se accede
    puntero = [0,1]-1+index*2;
    % index, es el numero de butterfly
    bf_stage1(puntero) = Butterfly(x(index), x(index+num_but));
end
% Factores Complejos que multiplican la primer etapa
for index = (num_but/2)+1: num_but 
    % Solo lo mitad de los butterflys son afectados
    % Multiplica la segunda salida de los butterflys empleados por un complejo
    puntero = [0,1]-1+index*2;
    bf_stage1(puntero(2)) = bf_stage1(puntero(2))*-1i;
end

%% Stage 20
bf_stage2 = zeros(1,N);
wn8  = exp(-1i*pi/4);     %  0.7071 - 0.7071i
w3n8 = exp(-1i*pi/4)*-1i; % -0.7071 - 0.7071i

for index = 1:(num_but/2)
    puntero = [0,1]-1+index*2;
    
    % pnt1, accede a al primer butterfly hasta la mitad de los butterfly
    % pnt2, accede a la mitad+1 de los butterfly hasta el final
    % (1). primer linea de salida de los butterfly
    % (2), segunda linea de salida de los butterfly
    pnt1 = puntero;
    pnt2 = puntero+num_but;
    
    % bf_stage2, es la combinacion del primer butterfly y del butterfly que
    % se encuentra en la mitad+1 del Stage1
    bf_stage2(puntero) = Butterfly(bf_stage1(pnt1(1)), bf_stage1(pnt2(1)));
    index;
end
% Factores Complejos
for index = (num_but/4)+1: num_but/2
    puntero = [0,1]-1+index*2;
    bf_stage2(puntero(2)) = bf_stage2(puntero(2))*-1i;
end


for index = (num_but/2)+1:num_but
    puntero = [0,1]-1+index*2;
    
    pnt1 = puntero-num_but;
    pnt2 = puntero;
    
    bf_stage2(puntero) = Butterfly(bf_stage1(pnt1(2)), bf_stage1(pnt2(2)));
    
    index;
end
% Factores Complejos
for index = (3*num_but/4)+1: num_but
    puntero = [0,1]-1+index*2;
    bf_stage2(puntero(1)) = bf_stage2(puntero(1))*wn8;
    bf_stage2(puntero(2)) = bf_stage2(puntero(2))*w3n8;
end

%% Stage 30
bf_stage3 = zeros(1,N);
w1 = (exp(-1i*2*pi/N))^1; 
w2 = (exp(-1i*2*pi/N))^2; 
w3 = (exp(-1i*2*pi/N))^3; 
w4 = (exp(-1i*2*pi/N))^4; 
w5 = (exp(-1i*2*pi/N))^5; 
w6 = (exp(-1i*2*pi/N))^6; 
w7 = (exp(-1i*2*pi/N))^7; 

for index = 1:(num_but/4)
    puntero = [0,1]-1+index*2;
    
    pnt1 = puntero;
    pnt2 = puntero+num_but/2;

    bf_stage3(puntero) = Butterfly(bf_stage2(pnt1(1)), bf_stage2(pnt2(1)));
    
    % Factores Complejos
    n = index-1;
    bf_stage3(puntero(2)) = bf_stage3(puntero(2))*w4^n;
end

m = 0;
for index = (num_but/4)+1:num_but/2
    puntero = [0,1]-1+index*2;
    
    pnt1 = puntero-num_but/2;
    pnt2 = puntero;

    bf_stage3(puntero) = Butterfly(bf_stage2(pnt1(2)), bf_stage2(pnt2(2)));
    index;
    
    % Factores Complejos
    m = m+1;
    n = m-1;
    bf_stage3(puntero(1)) = bf_stage3(puntero(1))*w2^n;
    bf_stage3(puntero(2)) = bf_stage3(puntero(2))*w6^n;

end

m = 0;
for index = (num_but/2)+1:(3*num_but/4)
    puntero = [0,1]-1+index*2;% Esta seccion sólo es Valida para una Dft de 16puntos Radix8!
    
    pnt1 = puntero;
    pnt2 = puntero+num_but/2;

    bf_stage3(puntero) = Butterfly(bf_stage2(pnt1(1)), bf_stage2(pnt2(1)));
    
    % Factores Complejos
    m = m+1;
    n = m-1;
    bf_stage3(puntero(1)) = bf_stage3(puntero(1))*w1^n;
    bf_stage3(puntero(2)) = bf_stage3(puntero(2))*w5^n;
end

m = 0;
for index = (3*num_but/4)+1:num_but
    puntero = [0,1]-1+index*2;

    pnt1 = puntero-num_but/2;
    pnt2 = puntero;

    bf_stage3(puntero) = Butterfly(bf_stage2(pnt1(2)), bf_stage2(pnt2(2)));

    % Factores Complejos
    m = m+1;
    n = m-1;
    bf_stage3(puntero(1)) = bf_stage3(puntero(1))*w3^n;
    bf_stage3(puntero(2)) = bf_stage3(puntero(2))*w7^n;
end

%% Salida
% Esta seccion sólo es Valida para una Dft de 16puntos Radix8!!
% La salida para N=128p se dividira en 8 bloques de DFT de 16 puntos cada uno (8 butterfly).
% La salida de los 8 butterflys (Nnew=16p) se ordenaran de tal forma que
% sean adecuadas al asignarselas a la función "DFT16pR8( xn )"

if(N==128)
    data_in = bf_stage3;
    Nnew = N/Radix;
    
    data1 = zeros(1,Nnew);
    data2 = zeros(1,Nnew);
    data3 = zeros(1,Nnew);
    data4 = zeros(1,Nnew);
    data5 = zeros(1,Nnew);
    data6 = zeros(1,Nnew);
    data7 = zeros(1,Nnew);
    data8 = zeros(1,Nnew);
    
    % Reordeno las muestras para que sean validas para la funcion DFT16pR8
    for index = 1:num_but/4
        puntero = [0,1]-1+index*2;
        
        pnt = index;
        data1(pnt) = data_in(puntero(1));
        data2(pnt) = data_in(puntero(2));
    end
    for index = (num_but/4)+1:num_but/2
        puntero = [0,1]-1+index*2;
        
        pnt = index-num_but/4;
        data3(pnt) = data_in(puntero(1));
        data4(pnt) = data_in(puntero(2));  
    end   
    for index = (num_but/2)+1:(3*num_but/4)
        puntero = [0,1]-1+index*2;
               
        pnt = index-num_but/2;
        data5(pnt) = data_in(puntero(1));
        data6(pnt) = data_in(puntero(2));         
    end 
    for index = (3*num_but/4)+1:num_but
        puntero = [0,1]-1+index*2;
               
        pnt = index-3*num_but/4;
        data7(pnt) = data_in(puntero(1));
        data8(pnt) = data_in(puntero(2));         
    end 
    
    DFT16p_1 = DFT16pR8( data1 );
    DFT16p_2 = DFT16pR8( data2 );
    DFT16p_3 = DFT16pR8( data3 );
    DFT16p_4 = DFT16pR8( data4 );
    DFT16p_5 = DFT16pR8( data5 );
    DFT16p_6 = DFT16pR8( data6 );
    DFT16p_7 = DFT16pR8( data7 );
    DFT16p_8 = DFT16pR8( data8 );
    
    % DFT128 salida no ordenada
    DFT128 = [DFT16p_1, DFT16p_2, DFT16p_3, DFT16p_4, ...
              DFT16p_5, DFT16p_6, DFT16p_7, DFT16p_8];
    % DFT128 salida ordenada
    DFT128Align = UnalignAlign( DFT128 );   
end

%% Plot DFT
% El Plot solo tiene sentido si N=128p
on = true;
if(on)
    figure();
    out_dft = real( fftshift(DFT128Align) );
    stem(out_dft, 'm')
    title('$Radix 2^3: X[k]=\sum_{n=0}^{N-1} x(n)W_N^{nk}$','Interpreter','latex','FontSize',13)
    xlabel('128 Points'); ylabel('DFT X[k]'); grid minor;
end
