`timescale 1ns / 100ps

module ChannelTruncado
(
    CLK100MHZ   ,
    ck_rst      ,
    i_enable    ,

    i_r1i       ,    
    i_r1q       ,    
    i_r2i       ,
    i_r2qc      ,

    i_noise1i   ,  
    i_noise1q   ,  
    i_noise2i   ,  
    i_noise2q   ,

    o_r1i_noise ,
    o_r1q_noise ,
    o_r2i_noise ,
    o_r2qc_noise   
);

// Localparam
localparam nbt_efec  = 16; // S(16,12) Q(4,16)
localparam nbt_noise = 26; // S(26,19) Q(7,19)

localparam nbt_sum   = 27; // S(27,19) Q(8,19)
localparam nbf_sum   = 19;

localparam nbt_sat   = 16; // S(16,13) Q(3,13)
localparam nbf_sat   = 13;

localparam nbt_trunc = nbt_sum - (nbf_sum-nbf_sat); // S(21,13) Q(8,13) 


// Puertos
input  CLK100MHZ;
input  ck_rst;
input  i_enable;

input  signed [nbt_efec-1:0]  i_r1i;    
input  signed [nbt_efec-1:0]  i_r1q;    
input  signed [nbt_efec-1:0]  i_r2i;    
input  signed [nbt_efec-1:0]  i_r2qc;

input  signed [nbt_noise-1:0] i_noise1i;  
input  signed [nbt_noise-1:0] i_noise1q;  
input  signed [nbt_noise-1:0] i_noise2i;  
input  signed [nbt_noise-1:0] i_noise2q;

output signed [nbt_sat-1:0]   o_r1i_noise;     
output signed [nbt_sat-1:0]   o_r1q_noise;     
output signed [nbt_sat-1:0]   o_r2i_noise;
output signed [nbt_sat-1:0]   o_r2qc_noise;

 
// Señales Internas
wire                         reset;
reg  signed [nbt_sum-1:0]    sum1i;
reg  signed [nbt_sum-1:0]    sum1q;
reg  signed [nbt_sum-1:0]    sum2i;
reg  signed [nbt_sum-1:0]    sum2qc; 

reg  signed [nbt_sat-1:0]    r1i_noise;
reg  signed [nbt_sat-1:0]    r1q_noise;
reg  signed [nbt_sat-1:0]    r2i_noise;
reg  signed [nbt_sat-1:0]    r2qc_noise;

// Truncado Saturacion
reg  signed [nbt_sum-1:0]    rounding1i;
reg  signed [nbt_trunc-1:0]  truncate1i;           
reg                          saturation_pos1i;
reg                          saturation_neg1i;

reg  signed [nbt_sum-1:0]    rounding1q;
reg  signed [nbt_trunc-1:0]  truncate1q;           
reg                          saturation_pos1q;
reg                          saturation_neg1q;

reg  signed [nbt_sum-1:0]    rounding2i;
reg  signed [nbt_trunc-1:0]  truncate2i;           
reg                          saturation_pos2i;
reg                          saturation_neg2i;

reg  signed [nbt_sum-1:0]    rounding2q;
reg  signed [nbt_trunc-1:0]  truncate2q;           
reg                          saturation_pos2q;
reg                          saturation_neg2q; 

// Arquitectura
assign reset = ~ck_rst;                                                 
always @ (posedge CLK100MHZ or posedge reset)  
begin : Signal_Noise
    if(reset) begin 
        sum1i  <= 27'd0;
        sum1q  <= 27'd0;
        sum2i  <= 27'd0;
        sum2qc <= 27'd0;
    end  

    else begin
        if (i_enable==1)begin
            sum1i  <= $signed({{3{i_r1i[nbt_efec-1]}}, i_r1i, 7'd0}) +i_noise1i; //nbf(i_r1i)=12  nbf(i_noise1i)=19  nbf(sum1i)=19-12= 7   
            sum1q  <= $signed({{3{i_r1q[nbt_efec-1]}}, i_r1q, 7'd0}) +i_noise1q;
            sum2i  <= $signed({{3{i_r2i[nbt_efec-1]}}, i_r2i, 7'd0}) +i_noise2i;
            sum2qc <= $signed({{3{i_r2qc[nbt_efec-1]}}, i_r2qc,7'd0}) +i_noise2q;
        end    
        else begin
            sum1i  <= sum1i;
            sum1q  <= sum1q;
            sum2i  <= sum2i;
            sum2qc <= sum2qc;
        end      
    end          
end



// Arquitectura                                                
always @ (*)  
begin : Saturacion_Truncado_1i
                                                      
    rounding1i = sum1i;//+27'b00000000_0000000000000100000;  // S(27,19) Q(8,19) 
    truncate1i = rounding1i[nbt_sum-1 : nbf_sum-nbf_sat]; // S(21,13) Q(8,13) 

    saturation_pos1i = ( ~truncate1i[nbt_trunc-1] ) & (  |truncate1i[nbt_trunc-2 : nbt_sat-1] ); // 21'b00000 011_1111111111111+1
                                                                                                 // 21'b00000 100_0000000000000
    saturation_neg1i = (  truncate1i[nbt_trunc-1] ) & ( ~&truncate1i[nbt_trunc-2 : nbt_sat-1] ); // 21'b11111 100_0000000000000-1
                                                                                                 // 21'b11111 011_1111111111111
    if (saturation_pos1i)
        r1i_noise = 16'b011_1111111111111;
    else if (saturation_neg1i)
        r1i_noise = 16'b100_0000000000000;
    else
        r1i_noise = truncate1i[nbt_sat-1:0]; // S(16,13) Q(3,13)           
end

// Arquitectura
always @ (*)  
begin : Saturacion_Truncado_1q
                                                      
    rounding1q = sum1q;//+27'b00000000_0000000000000100000; 
    truncate1q = rounding1q[nbt_sum-1 : nbf_sum-nbf_sat];   

    saturation_pos1q = ( ~truncate1q[nbt_trunc-1] ) & (  |truncate1q[nbt_trunc-2 : nbt_sat-1] );                                                                                         
    saturation_neg1q = (  truncate1q[nbt_trunc-1] ) & ( ~&truncate1q[nbt_trunc-2 : nbt_sat-1] ); 
                                                                                           
    if (saturation_pos1q)
        r1q_noise = 16'b011_1111111111111;
    else if (saturation_neg1q)
        r1q_noise = 16'b100_0000000000000;
    else
        r1q_noise = truncate1q[nbt_sat-1:0];           
end

// Arquitectura                                                
always @ (*)  
begin : Saturacion_Truncado_2i
                                                      
    rounding2i = sum2i;//+27'b00000000_0000000000000100000;  
    truncate2i = rounding2i[nbt_sum-1 : nbf_sum-nbf_sat];  

    saturation_pos2i = ( ~truncate2i[nbt_trunc-1] ) & (  |truncate2i[nbt_trunc-2 : nbt_sat-1] );                                                                                          
    saturation_neg2i = (  truncate2i[nbt_trunc-1] ) & ( ~&truncate2i[nbt_trunc-2 : nbt_sat-1] ); 
                                                                                           
    if (saturation_pos2i)
        r2i_noise = 16'b011_1111111111111;
    else if (saturation_neg2i)
        r2i_noise = 16'b100_0000000000000;
    else
        r2i_noise = truncate2i[nbt_sat-1:0];           
end

// Arquitectura
always @ (*)  
begin : Saturacion_Truncado_2q
                                                      
    rounding2q = sum2qc;//+27'b00000000_0000000000000100000; 
    truncate2q = rounding2q[nbt_sum-1 : nbf_sum-nbf_sat];   

    saturation_pos2q = ( ~truncate2q[nbt_trunc-1] ) & (  |truncate2q[nbt_trunc-2 : nbt_sat-1] );                                                                                         
    saturation_neg2q = (  truncate2q[nbt_trunc-1] ) & ( ~&truncate2q[nbt_trunc-2 : nbt_sat-1] ); 
                                                                                        
    if (saturation_pos2q)
        r2qc_noise = 16'b011_1111111111111;
    else if (saturation_neg2q)
        r2qc_noise = 16'b100_0000000000000;
    else
        r2qc_noise = truncate2q[nbt_sat-1:0];            
end



// Asignaciones
assign o_r1i_noise  = r1i_noise;     
assign o_r1q_noise  = r1q_noise;     
assign o_r2i_noise  = r2i_noise;
assign o_r2qc_noise = r2qc_noise;

// Fin Arquitectura                                                                                                              
endmodule
