module multipCSD
#(parameter NBITS=12,
parameter NBITScoeff=11,
parameter NBITS_out=NBITS+NBITScoeff+1)
 (output [NBITS_out*2-1:0] result,
  input  [NBITS*2-1:0] muestra,
  input  [NBITScoeff*2-1:0] coeff);



  wire signed [NBITS-1:0] mr;
  wire signed [NBITS-1:0] mi;
    
  wire signed [NBITScoeff-1:0] cr;
  wire signed [NBITScoeff-1:0] ci;
    
  wire signed [NBITS_out-1:0] resultR; //Real
  wire signed [NBITS_out-1:0] resultI; //Img
    
assign mr = muestra[NBITS*2-1:NBITS]; //Real
assign mi = muestra[NBITS-1:0];        //Img
    
assign cr = coeff[NBITScoeff*2-1:NBITScoeff]; //Real
assign ci = coeff[NBITScoeff-1:0];        //Img
        
        
        //NOrmal        
//assign resultR = mr*cr-mi*ci;          //Real
//assign resultI = mr*ci+mi*cr;         //Img

        
// CSD //////
reg signed [NBITS*2-1:0] pp_mr_cr [0:4];
reg signed [NBITS*2-1:0] pp_mr_cr_t;


reg signed [NBITS*2-1:0] pp_mi_ci [0:4];
reg signed [NBITS*2-1:0] pp_mi_ci_t; 


reg signed [NBITS*2-1:0] pp_mr_ci [0:4];
reg signed [NBITS*2-1:0] pp_mr_ci_t;


reg signed [NBITS*2-1:0] pp_mi_cr [0:4];
reg signed [NBITS*2-1:0] pp_mi_cr_t;




always @ (*)
     begin
//Coeff real
pp_mr_cr[0]= mr<<<9;
pp_mr_cr[1]=-mr<<<7;       
pp_mr_cr[2]=-mr<<<5;
pp_mr_cr[3]= mr<<<3;
pp_mr_cr[4]= mr<<<1;
pp_mr_cr_t= pp_mr_cr[0]+pp_mr_cr[1]+pp_mr_cr[2]+pp_mr_cr[3]+pp_mr_cr[4];   

pp_mi_cr[0]= mi<<<9;
pp_mi_cr[1]=-mi<<<7;       
pp_mi_cr[2]=-mi<<<5;
pp_mi_cr[3]= mi<<<3;
pp_mi_cr[4]= mi<<<1;
pp_mi_cr_t= pp_mi_cr[0]+pp_mi_cr[1]+pp_mi_cr[2]+pp_mi_cr[3]+pp_mi_cr[4];   

//Coeff Imagiario
pp_mr_ci[0]=-mr<<<9;       
pp_mr_ci[1]= mr<<<7;
pp_mr_ci[2]= mr<<<4;
pp_mr_ci[3]= mr<<<2;
pp_mr_ci[4]= mr<<<0;
pp_mr_ci_t= pp_mr_ci[0]+pp_mr_ci[1]+pp_mr_ci[2]+pp_mr_ci[3]+pp_mr_ci[4];


pp_mi_ci[0]=-mi<<<9;       
pp_mi_ci[1]= mi<<<7;
pp_mi_ci[2]= mi<<<4;
pp_mi_ci[3]= mi<<<2;
pp_mi_ci[4]= mi<<<0;
pp_mi_ci_t= pp_mi_ci[0]+pp_mi_ci[1]+pp_mi_ci[2]+pp_mi_ci[3]+pp_mi_ci[4];

    end    
        
  

assign resultR = pp_mr_cr_t-pp_mi_ci_t;          //Real
assign resultI = pp_mr_ci_t+pp_mi_cr_t;         //Img

    
assign result[NBITS_out*2-1:NBITS_out] =resultR ;   //Real
assign result[NBITS_out-1:0] = resultI ;         //Img


   
    
endmodule


