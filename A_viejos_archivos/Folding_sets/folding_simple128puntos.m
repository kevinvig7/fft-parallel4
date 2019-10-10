
%%%%%
A =[];
 for i=0:127
    A(i+1)=i+1; 
 end    
 
%%%%% 
B=[];
 for i=32:63
   B(abs(32-i-1))=i; 
 end    

 for i=96:128
   B(abs(96-32-1-i))=i; 
 end    

  for i=0:31
   B(abs(0-64-1-i))=i; 
  end    

   for i=64:95
   B(abs(64-96-1-i))=i; 
  end    

  %%%%% 
C=[];
 for i=64:95
   C(abs(64-i-1))=i; 
    end    

 for i=32:63
   C(abs(96-96-1-i))=i;
   
 end    
% 
  for i=96:127
   C(abs(64-32-1-i))=i;
   
  end    
% 
   for i=0:31
   C(abs(0-96-1-i))=i;
    end    

  
   %%%%% 
D=[];
 for i=0:31
   D(abs(i+1))=i; 
    end    

 for i=64:95
   D(abs(32-1-i))=i;
   
 end    
% 
  for i=32:63
   D(abs(0-32-1-i))=i;
   
  end    
% 
   for i=96:127
   D(abs(i+1))=i;
   end    

%%%%%%    
   E=[];
 for i=96:127
   E(abs(96-1-i))=i; 
    end    

 for i=0:31
   E(abs(32+1+i))=i;
   
 end    
% 
  for i=64:95
   E(abs(1+i))=i;
   
  end    
% 
   for i=32:63
   E(abs(i+1+64))=i;
   end    
  
    
   
   %%%%% 
F=[];
 for i=32:63
   F(abs(32-i-1))=i; 
 end    

 for i=96:128
   F(abs(96-32-1-i))=i; 
 end    

  for i=0:31
   F(abs(0-64-1-i))=i; 
  end    

   for i=64:95
   F(abs(64-96-1-i))=i; 
  end    
   
      
   
%%%%%%    
   G=[];
 for i=96:127
   E(abs(96-1-i))=i; 
    end    

 for i=0:31
   G(abs(32+1+i))=i;
   
 end    
% 
  for i=64:95
   G(abs(1+i))=i;
   
  end    
% 
   for i=32:63
   G(abs(i+1+64))=i;
   end    
  
   