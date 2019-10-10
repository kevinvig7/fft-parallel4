
%%%%%
%A = {0,0,0,0,A0,A1,A2,A3}
A0=4;
A1=5;
A2=6;
A3=7;

%B = {B2,B3,0,0,0,0,B0,B1}
B0=6;
B1=7;
B2=0;
B3=1;

%C = {C1,C2,C3,0,0,0,0,C0}
C0=7;
C1=0;
C2=1;
C3=2;

nDF=8*2; % cantidad de DFs
k=8; %folding
PA=0;
PB=0;
PC=0;
%for i=1:nDF

    DF_A0_B0=k*0-PA+B0-A0;
    DF_A0_B2=k*0-PA+B2-A0;
    
    DF_A1_B1=k*0-PA+B1-A1;
    DF_A1_B3=k*0-PA+B3-A1;
    
    DF_A2_B0=k*0-PA+B0-A2;
    DF_A2_B2=k*0-PA+B0-A2;
    
    DF_A3_B1=k*0-PA+B1-A3;
    DF_A3_B3=k*0-PA+B3-A3;
   
    
        
    
    DF_B0_C0=k*0-PB+C0-B0;
    DF_B0_C1=k*0-PB+C1-B0;
    
    DF_B1_C0=k*0-PB+C0-B1;
    DF_B1_C1=k*0-PB+C1-B1;
    
    
    DF_B2_C2=k*0-PB+C2-B2;
    DF_B2_C3=k*0-PB+C3-B2;
    
    DF_B3_C2=k*0-PB+C2-B3;
    DF_B3_C3=k*0-PB+C3-B3;
    
   
    
    
%end



