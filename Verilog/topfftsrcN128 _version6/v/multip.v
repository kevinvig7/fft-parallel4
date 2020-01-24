module multip
#(parameter NBITS=10,
parameter NBITScoeff=11,
parameter NBITS_out=NBITS+NBITScoeff+1)
 (output [NBITS_out*2-1:0] result,
  input  [NBITS*2-1:0] muestra,
  input  [NBITScoeff*2-1:0] coeff);



  wire signed [NBITS-1:0] m_r;
  wire signed [NBITS-1:0] m_i;
    
  wire signed [NBITScoeff-1:0] c_r;
  wire signed [NBITScoeff-1:0] c_i;
    
  wire signed [NBITS_out-1:0] resultR; //Real
  wire signed [NBITS_out-1:0] resultI; //Img
    
assign m_r = muestra[NBITS*2-1:NBITS]; //Real
assign m_i = muestra[NBITS-1:0];        //Img
    
assign c_r = coeff[NBITScoeff*2-1:NBITScoeff]; //Real
assign c_i = coeff[NBITScoeff-1:0];        //Img
        
assign resultR = m_r*c_r-m_i*c_i;          //Real
assign resultI = m_r*c_i+m_i*c_r;         //Img

    
    
  assign result[NBITS_out*2-1:NBITS_out] =resultR ;   //Real
  assign result[NBITS_out-1:0] = resultI ;         //Img


   
    
endmodule


