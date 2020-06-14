import numpy as np
import random
import matplotlib.pyplot as plt
from tool._fixedInt import *
import scipy




# Funcion para obtener numero float a partir de numero fixed
def fx_to_flt(num,nb,nbf,str1,str2,str3):
    num_fx = DeFixedInt(nb, nbf, str1, str2, str3)
    num_fx.value=num
    return num_fx.fValue

# Convierte  fraccional S(NBI,NBF) a numero binario
def fx_to_bin(num,nb,nbf,str1,str2,str3):
    num_fx = DeFixedInt(nb, nbf, str1, str2, str3)
    num_fx.value=num
    return bin(num_fx.intvalue)[2:].zfill(nb)

# Convierte  fraccional S(NBI,NBF) a numero entero signado
def fx_to_ints(num,nb,nbf,str1,str2,str3):
    num_fx = DeFixedInt(nb, nbf, str1, str2, str3)
    num_fx.value=num
    return num_fx.value


def ints_to_fx(num,nb,nbf,str1,str2,str3):
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



NBI_in = 5
NBF_in = 18
NB_in = NBI_in + NBF_in

NBI_coef = 2
NBF_coef = 9
NB_coef = NBI_coef + NBF_coef

NBI_out = NBI_in + NBI_coef
NBF_out = NBF_in + NBF_coef
NB_out = NBI_out + NBF_out


W_1 = [np.cos((1*2*np.pi)/8),-np.sin((1*2*np.pi)/8)]
W_2 = [np.cos((2*2*np.pi)/8),-np.sin((2*2*np.pi)/8)]
W_3 = [np.cos((3*2*np.pi)/8),-np.sin((3*2*np.pi)/8)]
W_5 = [np.cos((5*2*np.pi)/8),-np.sin((5*2*np.pi)/8)]
W_6 = [np.cos((6*2*np.pi)/8),-np.sin((6*2*np.pi)/8)]
W_7 = [np.cos((7*2*np.pi)/8),-np.sin((7*2*np.pi)/8)]


x_in =  random.uniform(-2**(NBI_in-1),2**(NBI_in-1))  # Genero muestra real
in_int = fx_to_ints(x_in,NB_in,NBF_in,'S','trunc','saturate')
in_fx = fx_to_flt(x_in,NB_in,NBF_in,'S','trunc','saturate')

print ("\n")
print("----- Coeficiente W3n8[0] = w3n8[1] = wn8[1] = -0.7071... -----")

coef = W_3[0]
coef_fx = fx_to_flt(coef,NB_coef,NBF_coef,'S','trunc','saturate')

# Realizo multiplicacion CSD
csd_res =   - in_int + (in_int >> 2) + (in_int >> 5) + (in_int >> 7) + (in_int >> 9)
print "Producto CSD:",ints_to_fx(csd_res,NB_out,NBF_out,'S','trunc','saturate')

# Realizo multiplicacion para comparar resultados
res_fx = in_fx * coef_fx
print "Producto normal:",fx_to_flt(res_fx,NB_out,NBF_out,'S','trunc','saturate')


print ("\n")
print("---- Coeficiente Wn8[0] = 0.7071... -----")

coef = W_1[0]
coef_fx = fx_to_flt(coef,NB_coef,NBF_coef,'S','trunc','saturate')

# Realizo multiplicacion CSD
csd_res =  in_int - (in_int >> 2) - (in_int >> 4) + (in_int >> 6) + (in_int >> 8)
print "Producto CSD:",ints_to_fx(csd_res,NB_out,NBF_out,'S','trunc','saturate')

# Realizo multiplicacion para comparar resultados
res_fx = in_fx * coef_fx
print "Producto normal:",fx_to_flt(res_fx,NB_out,NBF_out,'S','trunc','saturate')
