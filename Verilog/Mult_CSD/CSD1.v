// Multiplicador CSD, 
// Coeficiente W3n8[0] = w3n8[1] = wn8[1] = -0.7071...
// Formato S(11,9)

module CSD1#(
   parameter NB_INPUT  = 23,
   parameter NB_OUTPUT = NB_INPUT + 11
   )
   (
      input  signed [NB_INPUT-1:0] in,
      output signed [NB_OUTPUT-1:0] out
   );

   reg signed [NB_INPUT-1:0] in_sum0;
   reg signed [(NB_INPUT+2)-1:0] in_sum1;
   reg signed [(NB_INPUT+5)-1:0] in_sum2;
   reg signed [(NB_INPUT+7)-1:0] in_sum3;
   reg signed [(NB_INPUT+9)-1:0] in_sum4;
   
   always @(*) begin
      in_sum0 =  ({{0{in[NB_INPUT-1]}},in}^{NB_INPUT{1'b1}})+1'b1;
      in_sum1 =  {{2{in[NB_INPUT-1]}},in};
      in_sum2 =  {{5{in[NB_INPUT-1]}},in};
      in_sum3 =  {{7{in[NB_INPUT-1]}},in};
      in_sum4 =  {{9{in[NB_INPUT-1]}},in};
   end
   
   assign out  = (in_sum0<<9) + (in_sum1<<7) + (in_sum2<<4) + (in_sum3<<2) + in_sum4;

endmodule