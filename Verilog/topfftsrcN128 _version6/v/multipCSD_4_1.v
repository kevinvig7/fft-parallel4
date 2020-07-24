module multipCSD_4_1
#(parameter NBITS=12,
parameter NBITScoeff=11,
parameter NBITS_out=NBITS+NBITScoeff+1)
 (output [NBITS_out*2-1:0] result,
  input  [NBITS*2-1:0] muestra,
  input clk,
  input rst);//,
  //input  [NBITScoeff*2-1:0] coeff);


 wire [1:0] num_ciclo;
 
  wire signed [NBITS-1:0] mr;
 
  
  wire signed [NBITS-1:0] mi;
    
  wire signed [NBITScoeff-1:0] cr;
  wire signed [NBITScoeff-1:0] ci;
    
  reg signed [NBITS_out-1:0] resultR; //Real
  reg signed [NBITS_out-1:0] resultI; //Img
    
assign mr = muestra[NBITS*2-1:NBITS]; //Real
assign mi = muestra[NBITS-1:0];        //Img
    
    
contador_int
 #(8) 
   control_CSD_4_1
        (.num_ciclo(num_ciclo),
         .clk(clk),
         .rst(rst)); 
        
// CSD //////
reg signed [NBITS*2-1:0] pp_mr_cr [0:4];
reg signed [NBITS*2-1:0] pp_mr_cr_t;


reg signed [NBITS*2-1:0] pp_mi_ci [0:4];
reg signed [NBITS*2-1:0] pp_mi_ci_t; 


reg signed [NBITS*2-1:0] pp_mr_ci [0:4];
reg signed [NBITS*2-1:0] pp_mr_ci_t;


reg signed [NBITS*2-1:0] pp_mi_cr [0:4];
reg signed [NBITS*2-1:0] pp_mi_cr_t;

always @ (*) begin

if (num_ciclo==2'b00 || num_ciclo==2'b10) begin

resultR = $signed({mr,{NBITScoeff-2{1'b0}}});          //Real
resultI = $signed({mi,{NBITScoeff-2{1'b0}}});         //Img

//resultR = {mr,{NBITScoeff-2{1'b0}}};          //Real
//resultI = {mi,{NBITScoeff-2{1'b0}}};         //Img

end
else if (num_ciclo==2'b01) begin

//  (a+bi)*-1i=(b-ai)
resultR = $signed({mi,{NBITScoeff-2{1'b0}}});         //Real
resultI = $signed({mr,{NBITScoeff-2{1'b0}}});        //Img

/*if (mr[NBITS-1]==1'b1) begin //Chekea el signo para cambiarlo
resultI = $signed({1'b0,mr[NBITS-2:0],{NBITScoeff-2{1'b0}}});        //Img
end
else begin
resultI = $signed({1'b1,mr[NBITS-2:0],{NBITScoeff-2{1'b0}}});        //Img 
end 
 */
 
 

end
else begin  
//Coeff real
pp_mr_cr[0]=-mr<<<9;
pp_mr_cr[1]= mr<<<7;       
pp_mr_cr[2]= mr<<<4;
pp_mr_cr[3]= mr<<<2;
pp_mr_cr[4]= mr<<<0;
pp_mr_cr_t= pp_mr_cr[0]+pp_mr_cr[1]+pp_mr_cr[2]+pp_mr_cr[3]+pp_mr_cr[4];   

pp_mi_cr[0]=-mi<<<9;
pp_mi_cr[1]= mi<<<7;       
pp_mi_cr[2]= mi<<<4;
pp_mi_cr[3]= mi<<<2;
pp_mi_cr[4]= mi<<<0;
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

resultR = pp_mr_cr_t-pp_mi_ci_t;          //Real
resultI = pp_mr_ci_t+pp_mi_cr_t;         //Img

    end    
 end      
  



    
assign result[NBITS_out*2-1:NBITS_out] =resultR ;   //Real
assign result[NBITS_out-1:0] = resultI ;         //Img


   
    
endmodule


