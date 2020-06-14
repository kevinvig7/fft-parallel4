import numpy as np
import matplotlib.pyplot as plt
from tool._fixedInt import *
import scipy

# Funcion para obtener numero float a partir de numero fixed
def fx_to_flt(num,nb,nbf,str1,str2,str3):
    num_fx = DeFixedInt(nb, nbf, str1, str2, str3)
    num_fx.value=num
    return num_fx.fValue

def fx_to_flt_v(vector,nb,nbf,str1,str2,str3):
    fixed_vector = []
    for ptr in range(len(vector)):
        fixed_vector.append(fx_to_flt(vector[ptr],nb,nbf,str1,str2,str3))
    return fixed_vector

def to_CSD(fx_num,NB):
    fx_num = fx_num<<1
    fx_num = fx_num | (fx_num & (1<<(NB)))<<1
    delta = 0
    num_csd = [0]*(NB+1)
    for i in range(NB):
        tita = ((fx_num & (0x1 << (i+1)))>>(i+1)) ^  ((fx_num & (0x1 << i))>>i)
        delta=((delta)^1)*tita
        num_csd[i] = (1 - 2*((fx_num & (0x1 << (i+2)))>>(i+2)))*delta
    num_csd = num_csd[::-1]
    return num_csd[1:NB+1]

# Twiddle factors
NBI_twfactor = 2
NBF_twfactor = 9
NB_twfactor = NBI_twfactor + NBF_twfactor
W_1 = [np.cos((1*2*np.pi)/8),-np.sin((1*2*np.pi)/8)]
W_2 = [np.cos((2*2*np.pi)/8),-np.sin((2*2*np.pi)/8)]
W_3 = [np.cos((3*2*np.pi)/8),-np.sin((3*2*np.pi)/8)]
W_5 = [np.cos((5*2*np.pi)/8),-np.sin((5*2*np.pi)/8)]
W_6 = [np.cos((6*2*np.pi)/8),-np.sin((6*2*np.pi)/8)]
W_7 = [np.cos((7*2*np.pi)/8),-np.sin((7*2*np.pi)/8)]

# Calculo respresentacion en CSD
fx_num = DeFixedInt(NB_twfactor,NBF_twfactor,'S','trunc','saturate')

print("----- Coeficiente W3n8[0] = w3n8[1] = wn8[1] = 0.7071... -----")
fx_num.value = W_3[0]
coef = W_3[0]
print "Coef: ",coef
print to_CSD(fx_num.intvalue,NB_twfactor)


print("---- Coeficiente Wn8[0] = -0.7071... -----")
coef = W_1[0]
print "Coef: ",coef
fx_num.value = W_1[0]
print to_CSD(fx_num.intvalue,NB_twfactor)
