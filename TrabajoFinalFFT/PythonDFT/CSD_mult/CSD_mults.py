import numpy as np
import matplotlib.pyplot as plt
from tool._fixedInt import *
import scipy

NBI_in = 2
NBF_in = 9
NB_in = NBI_in + NBF_in

NBI_coef = 2
NBF_coef = 9
NB_coef = NBI_coef + NBF_coef


# Funcion para obtener numero float a partir de numero fixed
def fx_to_flt(num,nb,nbf,str1,str2,str3):
    num_fx = DeFixedInt(nb, nbf, str1, str2, str3)
    num_fx.value=num
    return num_fx.fValue

def bin_to_fx(bin_value,nbi,nbf): # Convierte numero binario a fraccional S(NBI,NBF)
    value_fx = 0
    value_fx += ((bin_value & (2**(nbf+nbi-1)))>>(nbf+nbi-1)) * (-2 ** (nbi - 1))
    for i in range(nbi-1):
        value_fx += ((bin_value & (2**(nbf+nbi-2-i)))>>(nbf+nbi-2-i)) * (2**(nbi-i-2))
    for i in range(nbf):
        value_fx += ((bin_value & (2**(nbf-i-1)))>>(nbf-i-1)) * (2**(-i-1))
    return value_fx


W_1 = [np.cos((1*2*np.pi)/16),-np.sin((1*2*np.pi)/16)]
W_2 = [np.cos((2*2*np.pi)/16),-np.sin((2*2*np.pi)/16)]
W_3 = [np.cos((3*2*np.pi)/16),-np.sin((3*2*np.pi)/16)]
W_5 = [np.cos((5*2*np.pi)/16),-np.sin((5*2*np.pi)/16)]
W_6 = [np.cos((6*2*np.pi)/16),-np.sin((6*2*np.pi)/16)]
W_7 = [np.cos((7*2*np.pi)/16),-np.sin((7*2*np.pi)/16)]

x_in = -0.1235183
fx_in = DeFixedInt(NB_in,NBF_in,'S','trunc','saturate')
fx_in.value = x_in


coef_fx = DeFixedInt(NB_coef,NBF_coef,'S','trunc','saturate')
coef_fx.value = W_2[0]


# Realizo multiplicacion CSD
csd_res = ((((fx_in >>4) + ((fx_in >>2) - fx_in))>>4) + ((fx_in>>2) + fx_in))>>1
print bin(csd_res.intvalue)

# Realizo multiplicacion para comparar resultados
res_fx = fx_in * coef_fx
res_fx_trunc = DeFixedInt(NB_coef,NBF_coef,'S','trunc','saturate')
res_fx_trunc.value = res_fx.fValue
print bin(res_fx_trunc.intvalue)

