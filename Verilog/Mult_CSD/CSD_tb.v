`timescale 1ns/100ps

module CSD_tb#(
   parameter NB_INPUT  = 23,
   parameter NB_OUTPUT = NB_INPUT + 11
   );

   reg [NB_INPUT-1:0] in;
   reg [NB_INPUT-1:0] py_in;
   reg [NB_OUTPUT-1:0] py_out_csd1, py_out_csd2;
   reg clk;
   wire [NB_OUTPUT-1:0] out_csd1, out_csd2;
   wire assert_out_csd1;
   wire assert_out_csd2;
   
   integer fid_in;
   integer error_in;

   integer fid_out_csd1;
   integer error_out_csd1;

   integer fid_out_csd2;
   integer error_out_csd2;


   initial begin 
      clk = 1'b0;
      fid_in  = $fopen("/media/kevinvig7/Elements/Documentos/CursoVLSI/TP_Final/Python/vectors/in_csd.out","r");
      if(fid_in==0) $stop;
      fid_out_csd1  = $fopen("/media/kevinvig7/Elements/Documentos/CursoVLSI/TP_Final/Python/vectors/out_csd1.out","r");
      if(fid_out_csd1==0) $stop;
      fid_out_csd2  = $fopen("/media/kevinvig7/Elements/Documentos/CursoVLSI/TP_Final/Python/vectors/out_csd2.out","r");
      if(fid_out_csd2==0) $stop;
   end


   // Leo nueva muestra desde archivo cada clk
   always@(posedge clk) begin            
    
      error_in <= $fscanf(fid_in,"%h",py_in);
      if(error_in!=1) 
        $stop;       
    
      error_out_csd1 <= $fscanf(fid_out_csd1,"%h",py_out_csd1);
      if(error_out_csd1!=1) 
        $stop;       
    
      error_out_csd2 <= $fscanf(fid_out_csd2,"%h",py_out_csd2);
      if(error_out_csd2!=1) 
        $stop;       
    

    in <= py_in;

    end


   always #1 clk = ~clk;

  CSD1 #(.NB_INPUT(NB_INPUT), .NB_OUTPUT(NB_OUTPUT))
   inst_CSD1 (.in(in), .out(out_csd1));

  CSD2 #(.NB_INPUT(NB_INPUT), .NB_OUTPUT(NB_OUTPUT))
   inst_CSD2 (.in(in), .out(out_csd2));

   assign assert_out_csd1 = (out_csd1==py_out_csd1)?1:0;
   assign assert_out_csd2 = (out_csd2==py_out_csd2)?1:0;

endmodule