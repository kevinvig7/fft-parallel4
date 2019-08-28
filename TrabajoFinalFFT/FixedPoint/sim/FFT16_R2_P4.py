import numpy as np
import matplotlib.pyplot as plt
from tool._fixedInt import *
import scipy


############################################
#       Declaracion de funciones
############################################

# Funcion para concatenar valores floats de vector fixed
def fixing_append(vector):
    fixed_vector = []
    for ptr in range(len(vector)):
        fixed_vector.append(vector[ptr].fValue)
    return fixed_vector

# Funcion para obetener valores floats de vector fixed
def fx_to_flt_v(vector,nb,nbf,str1,str2,str3):
    fixed_vector = []
    for ptr in range(len(vector)):
        fixed_vector.append(fx_to_flt(vector[ptr],nb,nbf,str1,str2,str3))
    return fixed_vector

def fx_to_flt_m(mat,nb,nbf,str1,str2,str3):
    fixed_mat = []
    shape = np.shape(mat)
    for ptr in range(shape[0]):
        fixed_vect = []
        for ptr1 in range(shape[1]):
            fixed_vect.append(fx_to_flt(mat[ptr][ptr1],nb,nbf,str1,str2,str3))
        fixed_mat.append(fixed_vect)
    return fixed_mat


# Funcion para obtener numero float a partir de numero fixed
def fx_to_flt(num,nb,nbf,str1,str2,str3):
    num_fx = DeFixedInt(nb, nbf, str1, str2, str3)
    num_fx.value=num
    return num_fx.fValue

def switch(In1,In2,Ctr):
    if Ctr == 0:
        Out1 = In1
        Out2 = In2
    else:
        Out1 = In2
        Out2 = In1
    return Out1,Out2

def butterfly(In1,In2):
    Out1 = np.array(In1) + np.array(In2)
    Out2 = np.array(In1) - np.array(In2)
    return Out1,Out2

def mult(In1,In2):
    Out = np.zeros(2)
    Out[0]=In1[0]*In2[0]-In1[1]*In2[1]
    Out[1]=In1[0]*In2[1]+In1[1]*In2[0]
    return Out

############################################################
#                    SIMULACION
###########################################################
## Delcaracion de resoluciones

# Variables de entrada
NBI_input = 8
NBF_input = 14
NB_input = NBI_input + NBF_input

# Salidas de butterfly
NBI_bf = 8
NBF_bf = 14
NB_bf = NBI_bf + NBF_bf

# Salidas de multiplicadores
NBI_mul = 8
NBF_mul = 14
NB_mul = NBI_mul + NBF_mul

# Factores de twiddle
NBI_tw = 8
NBF_tw = 14
NB_tw = NBI_tw + NBF_tw
## Delaracion de variables

N = 16 # cantidad de muestras totales a procesar

in_vect = np.ones((N,2)) # Vector de entrada
#in_vect[:8,0] = 1.

out1=[]
out2=[]
out3=[]
out4=[]

out_vect = np.zeros((N,2)) # Vector de salida


# Twiddle factors
W_1 = [np.cos((1*2*np.pi)/16),-np.sin((1*2*np.pi)/16)]
W_2 = [np.cos((2*2*np.pi)/16),-np.sin((2*2*np.pi)/16)]
W_3 = [np.cos((3*2*np.pi)/16),-np.sin((3*2*np.pi)/16)]
W_5 = [np.cos((5*2*np.pi)/16),-np.sin((5*2*np.pi)/16)]
W_6 = [np.cos((6*2*np.pi)/16),-np.sin((6*2*np.pi)/16)]
W_7 = [np.cos((7*2*np.pi)/16),-np.sin((7*2*np.pi)/16)]
print W_3
print W_2
# Multiplicadores

# Rama superior
M_si_0 = [[1.,0.],[1.,0.],[0.,-1.],[0.,-1.]]
M_ss_0 = [[1.,0.],[1.,0.],[1.,0.],W_2]
M_si_1 = [[1.,0.],[0.,-1.],[1.,0.],W_6]

# Rama inferior
M_ii_0 = [[1.,0.],[1.,0.],[0.,-1.],[0.,-1.]]
M_is_0 = [[1.,0.],[1.,0.],[1.,0.],W_2]
M_ii_1 = [[1.,0.],[0.,-1.],[1.,0.],W_6]
M_is_1 = [[1.,0.],W_2,W_1,W_3]
M_ii_2 = [[0.,-1.],W_6,W_5,W_7]

M_si_0_fx = fx_to_flt_m(M_si_0, NB_tw, NBF_tw, 'S', 'trunc', 'saturate')
M_ss_0_fx = fx_to_flt_m(M_ss_0, NB_tw, NBF_tw, 'S', 'trunc', 'saturate')
M_si_1_fx = fx_to_flt_m(M_si_1, NB_tw, NBF_tw, 'S', 'trunc', 'saturate')
M_ii_0_fx = fx_to_flt_m(M_ii_0, NB_tw, NBF_tw, 'S', 'trunc', 'saturate')
M_is_0_fx = fx_to_flt_m(M_is_0, NB_tw, NBF_tw, 'S', 'trunc', 'saturate')
M_ii_1_fx = fx_to_flt_m(M_ii_1, NB_tw, NBF_tw, 'S', 'trunc', 'saturate')
M_is_1_fx = fx_to_flt_m(M_is_1, NB_tw, NBF_tw, 'S', 'trunc', 'saturate')
M_ii_2_fx = fx_to_flt_m(M_ii_2, NB_tw, NBF_tw, 'S', 'trunc', 'saturate')

## Delaracion de registros

## Stage 0

## Registros rama superior

# Reg supeiores
stage00_ss_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage01_ss_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage01_ss_reg1 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage10_ss_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage10_ss_reg1 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage20_ss_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage30_ss_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage30_ss_reg1 = {'d':np.zeros(2), 'q':np.zeros(2)}

# Reg inferiores
stage00_si_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage01_si_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage01_si_reg1 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage10_si_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage10_si_reg1 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage20_si_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage30_si_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage30_si_reg1 = {'d':np.zeros(2), 'q':np.zeros(2)}

# Registros rama inferior

# Reg supeiores
stage00_is_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage01_is_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage01_is_reg1 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage10_is_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage10_is_reg1 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage20_is_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage30_is_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage30_is_reg1 = {'d':np.zeros(2), 'q':np.zeros(2)}

# Reg inferiores
stage00_ii_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage01_ii_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage01_ii_reg1 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage10_ii_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage10_ii_reg1 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage20_ii_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage30_ii_reg0 = {'d':np.zeros(2), 'q':np.zeros(2)}
stage30_ii_reg1 = {'d':np.zeros(2), 'q':np.zeros(2)}


out_M_is_1_fx = 0

for i in range(N//4):

    ## Variables de control

    # Controles switches
    ctr_sw1 = i & 0b1
    ctr_sw2 = (i & 0b10)>>1

    # Control multiplicadores
    ctr_mul = i%4

    ## Entradas
    in1_fx = fx_to_flt_v(in_vect[i*4], NB_input, NBF_input, 'S', 'trunc', 'saturate')
    in2_fx = fx_to_flt_v(in_vect[i*4+2], NB_input, NBF_input, 'S', 'trunc', 'saturate')
    in3_fx = fx_to_flt_v(in_vect[i*4+1], NB_input, NBF_input, 'S', 'trunc', 'saturate')
    in4_fx = fx_to_flt_v(in_vect[i*4+3], NB_input, NBF_input, 'S', 'trunc', 'saturate')

    ## Rama superior

    # Stage 00
    stage00_si_reg0 ['d'] = in2_fx
    stage00_ss_reg0['d'], stage01_si_reg0['d'] = switch(in1_fx,stage00_si_reg0['q'],ctr_sw1)

    # Stage 01
    stage01_ss_reg1['q'], in2_bf1_s = switch(stage00_ss_reg0['q'],stage01_si_reg1['q'],ctr_sw2)
    out1_bf1_s, out2_bf1_s = butterfly(stage01_ss_reg1['q'],in2_bf1_s)
    out1_bf1_s_fx = fx_to_flt_v(out1_bf1_s, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')
    out2_bf1_s_fx = fx_to_flt_v(out2_bf1_s, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')

    stage01_si_reg1['d'] = stage01_si_reg0['q']
    stage01_ss_reg1['d'] = stage01_ss_reg0['q']

    # Stage 10
    out_M_si_0 =mult(out2_bf1_s_fx,M_si_0_fx[ctr_mul])
    out_M_si_0_fx = fx_to_flt_v(out_M_si_0, NB_mul, NBF_mul, 'S', 'trunc', 'saturate')
    stage10_si_reg0['d']=out_M_si_0_fx
    stage10_ss_reg0['d'], in2_bf2_s = switch(out1_bf1_s_fx,stage10_si_reg1['q'],ctr_sw2)
    out1_bf2_s,out2_bf2_s = butterfly(stage10_ss_reg1['q'],in2_bf2_s)
    out1_bf2_s_fx = fx_to_flt_v(out1_bf2_s, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')
    out2_bf2_s_fx = fx_to_flt_v(out2_bf2_s, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')

    stage10_ss_reg1['d']=stage10_ss_reg0['q']
    stage10_si_reg1['d']=stage10_si_reg0['q']

    # Stage 20
    out_M_ss_0 = mult(out1_bf2_s_fx,M_ss_0_fx[ctr_mul])
    out_M_si_1 = mult(out2_bf2_s_fx, M_si_1_fx[ctr_mul])
    out_M_ss_0_fx = fx_to_flt_v(out_M_ss_0, NB_mul, NBF_mul, 'S', 'trunc', 'saturate')
    out_M_si_1_fx = fx_to_flt_v(out_M_si_1, NB_mul, NBF_mul, 'S', 'trunc', 'saturate')

    stage20_si_reg0['d'] = out_M_si_1_fx
    stage20_ss_reg0['d'], in2_bf3_s= switch(out_M_ss_0_fx,stage20_si_reg0['q'],ctr_sw1)
    out1_bf3_s, out2_bf3_s = butterfly(stage20_ss_reg0['q'],in2_bf3_s)
    out1_bf3_s_fx = fx_to_flt_v(out1_bf3_s, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')
    out2_bf3_s_fx = fx_to_flt_v(out2_bf3_s, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')

    # Stage 30
    out1_bf4_s,out2_bf4_s = butterfly(out1_bf3_s_fx,out_M_is_1_fx)
    out1_bf4_s_fx = fx_to_flt_v(out1_bf4_s, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')
    out2_bf4_s_fx = fx_to_flt_v(out2_bf4_s, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')

    out1 = out1_bf4_s_fx
    out2 = out2_bf4_s_fx

    ## Rama inferior

    # Stage 00
    stage00_ii_reg0 ['d'] = in2_fx
    stage00_is_reg0['d'], stage01_ii_reg0['d'] = switch(in1_fx,stage00_ii_reg0['q'],ctr_sw1)

    # Stage 01
    stage01_is_reg1['q'], in2_bf1_s = switch(stage00_is_reg0['q'],stage01_ii_reg1['q'],ctr_sw2)
    out1_bf1_i, out2_bf1_i = butterfly(stage01_is_reg1['q'],in2_bf1_s)
    out1_bf1_i_fx = fx_to_flt_v(out1_bf1_i, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')
    out2_bf1_i_fx = fx_to_flt_v(out2_bf1_i, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')

    stage01_ii_reg1['d'] = stage01_ii_reg0['q']
    stage01_is_reg1['d'] = stage01_is_reg0['q']

    # Stage 10
    out_M_ii_0 =mult(out2_bf1_i_fx,M_ii_0_fx[ctr_mul])
    out_M_ii_0_fx = fx_to_flt_v(out_M_ii_0, NB_mul, NBF_mul, 'S', 'trunc', 'saturate')
    stage10_ii_reg0['d']=out_M_ii_0_fx
    stage10_is_reg0['d'], in_bf2_s = switch(out1_bf1_i_fx,stage10_ii_reg1['q'],ctr_sw2)
    out1_bf2_i,out2_bf2_i = butterfly(stage10_is_reg1['q'],in_bf2_s)
    out1_bf2_i_fx = fx_to_flt_v(out1_bf2_i, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')
    out2_bf2_i_fx = fx_to_flt_v(out2_bf2_i, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')

    stage10_is_reg1['d']=stage10_is_reg0['q']
    stage10_ii_reg1['d']=stage10_ii_reg0['q']

    # Stage 20
    out_M_is_0 = mult(out1_bf2_i_fx,M_is_0_fx[ctr_mul])
    out_M_ii_1 = mult(out2_bf2_i_fx, M_ii_1_fx[ctr_mul])
    out_M_is_0_fx = fx_to_flt_v(out_M_is_0, NB_mul, NBF_mul, 'S', 'trunc', 'saturate')
    out_M_ii_1_fx = fx_to_flt_v(out_M_ii_1, NB_mul, NBF_mul, 'S', 'trunc', 'saturate')

    stage20_ii_reg0['d'] = out_M_ii_1_fx
    stage20_is_reg0['d'], in2_bf3_s= switch(out_M_is_0_fx,stage20_ii_reg0['q'],ctr_sw1)
    out1_bf3_i, out2_bf3_i = butterfly(stage20_is_reg0['q'],in2_bf3_s)
    out1_bf3_i_fx = fx_to_flt_v(out1_bf3_i, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')
    out2_bf3_i_fx = fx_to_flt_v(out2_bf3_i, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')
    out_M_is_1 = mult(out1_bf3_i_fx,M_is_1_fx[ctr_mul])
    out_M_is_1_fx = fx_to_flt_v(out_M_is_1, NB_mul, NBF_mul, 'S', 'trunc', 'saturate')
    out_M_ii_2 = mult(out2_bf3_i_fx, M_ii_2_fx[ctr_mul])
    out_M_ii_2_fx = fx_to_flt_v(out_M_ii_2, NB_mul, NBF_mul, 'S', 'trunc', 'saturate')

    # Stage 30
    out1_bf4_i,out2_bf4_i = butterfly(out2_bf3_s_fx,out_M_ii_2_fx)
    out1_bf4_i_fx = fx_to_flt_v(out1_bf4_i, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')
    out2_bf4_i_fx = fx_to_flt_v(out2_bf4_i, NB_bf, NBF_bf, 'S', 'trunc', 'saturate')

    out3 = out1_bf4_i_fx
    out4 = out2_bf4_i_fx


    ## Actualizo registros

    stage00_ss_reg0['q'] = stage00_ss_reg0['d']
    stage01_ss_reg0['q'] = stage01_ss_reg0['d']
    stage01_ss_reg1['q'] = stage01_ss_reg1['d']
    stage10_ss_reg0['q'] = stage10_ss_reg0['d']
    stage10_ss_reg1['q'] = stage10_ss_reg1['d']
    stage20_ss_reg0['q'] = stage20_ss_reg0['d']
    stage30_ss_reg0['q'] = stage30_ss_reg0['d']
    stage30_ss_reg1['q'] = stage30_ss_reg1['d']
    stage00_si_reg0['q'] = stage00_si_reg0['d']
    stage01_si_reg0['q'] = stage01_si_reg0['d']
    stage01_si_reg1['q'] = stage01_si_reg1['d']
    stage10_si_reg0['q'] = stage10_si_reg0['d']
    stage10_si_reg1['q'] = stage10_si_reg1['d']
    stage20_si_reg0['q'] = stage20_si_reg0['d']
    stage30_si_reg0['q'] = stage30_si_reg0['d']
    stage30_si_reg1['q'] = stage30_si_reg1['d']
    stage00_is_reg0['q'] = stage00_is_reg0['d']
    stage01_is_reg0['q'] = stage01_is_reg0['d']
    stage01_is_reg1['q'] = stage01_is_reg1['d']
    stage10_is_reg0['q'] = stage10_is_reg0['d']
    stage10_is_reg1['q'] = stage10_is_reg1['d']
    stage20_is_reg0['q'] = stage20_is_reg0['d']
    stage30_is_reg0['q'] = stage30_is_reg0['d']
    stage30_is_reg1['q'] = stage30_is_reg1['d']
    stage00_ii_reg0['q'] = stage00_ii_reg0['d']
    stage01_ii_reg0['q'] = stage01_ii_reg0['d']
    stage01_ii_reg1['q'] = stage01_ii_reg1['d']
    stage10_ii_reg0['q'] = stage10_ii_reg0['d']
    stage10_ii_reg1['q'] = stage10_ii_reg1['d']
    stage20_ii_reg0['q'] = stage20_ii_reg0['d']
    stage30_ii_reg0['q'] = stage30_ii_reg0['d']
    stage30_ii_reg1['q'] = stage30_ii_reg1['d']

    print out1
    print out2
    print out3
    print out4

## Ordeno muestas
