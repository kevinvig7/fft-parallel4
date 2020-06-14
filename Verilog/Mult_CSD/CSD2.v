// Multiplicador CSD, 
// Coeficiente Wn8[0] = 0.7071...
// Formato S(11,9)

module CSD2#(
   parameter NB_INPUT  = 23,
   parameter NB_OUTPUT = NB_INPUT + 11
   )
   (
      input  signed [NB_INPUT-1:0] in,
      output signed [NB_OUTPUT-1:0] out
   );

   reg signed [NB_INPUT-1:0] in_sum0;
   reg signed [(NB_INPUT+2)-1:0] in_sum1;
   reg signed [(NB_INPUT+4)-1:0] in_sum2;
   reg signed [(NB_INPUT+6)-1:0] in_sum3;
   reg signed [(NB_INPUT+8)-1:0] in_sum4;
   
   always @(*) begin
      in_sum0 =  {{0{in[NB_INPUT-1]}},in};
      in_sum1 =  ({{2{in[NB_INPUT-1]}},in}^{NB_INPUT+2{1'b1}})+1'b1;
      in_sum2 =  ({{4{in[NB_INPUT-1]}},in}^{NB_INPUT+4{1'b1}})+1'b1;
      in_sum3 =  {{6{in[NB_INPUT-1]}},in};
      in_sum4 =  {{8{in[NB_INPUT-1]}},in};
   end
   
   assign out  = ((in_sum0<<8) + (in_sum1<<6) + (in_sum2<<4) + (in_sum3<<2) + in_sum4)<<1;

endmodule