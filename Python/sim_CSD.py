import numpy as np
import matplotlib.pyplot as plt
from tool._fixedInt import *
import random


############################################
# Definicion de funciones
############################################


# Funcion para concatenar valores floats de vector fixed
def fixing_append(vector):
    fixed_vector = []
    for ptr in range(len(vector)):
        fixed_vector.append(vector[ptr].fValue)
    return fixed_vector


# Funcion para obetener valores floats de vector fixed
def fx_to_flt_v(vector, nb, nbf, str1, str2, str3):
    fixed_vector = []
    for ptr in range(len(vector)):
        fixed_vector.append(fx_to_flt(vector[ptr], nb, nbf, str1, str2, str3))
    return fixed_vector


# Funcion para concatenar hexadecimal de vector fixed
def hex_append_v(vector, nb, nbf, str1, str2, str3):
    vector_fx = arrayFixedInt(nb, nbf, vector, str1, str2, str3)
    vector_hex = []
    for ptr in range(len(vector)):
        vector_hex.append((hex(vector_fx[ptr].intvalue))[2:].zfill(int(math.ceil(nb / 4.))))
    return vector_hex


# Funcion para obtener valor hexadecimal de numero fixed
def hex_append(num, nb, nbf, str1, str2, str3):
    num_fx = DeFixedInt(nb, nbf, str1, str2, str3)
    num_fx.value = num
    return hex(num_fx.intvalue)[2:].zfill(int(math.ceil(nb / 4.)))


# Funcion para obtener numero float a partir de numero fixed
def fx_to_flt(num, nb, nbf, str1, str2, str3):
    num_fx = DeFixedInt(nb, nbf, str1, str2, str3)
    num_fx.value = num
    return num_fx.fValue


# Funcion para obtener numero float a partir de numero fixed en formato entero
def fx_to_flt_int(num, nb, nbf, str1, str2, str3):
    num_fx = DeFixedInt(nb, nbf, str1, str2, str3)

    # Convierte a valor entero sin signo, 0 a 2^n
    if num>2**(nb-1):
        num_fx.value = (num-2**nb)
    else:
        num_fx.value = num
    return num_fx.fValue

# Funcion para obetener valores floats de vector fixed en formato entero
def fx_to_flt_int_v(vector, nb, nbf, str1, str2, str3):
    fixed_vector = []
    for ptr in range(len(vector)):
        fixed_vector.append(fx_to_flt_int(vector[ptr], nb, nbf, str1, str2, str3))
    return fixed_vector

def ints_to_fx(num,nb,nbf,str1,str2,str3):
    num_fx = DeFixedInt(nb, nbf, str1, str2, str3)
    num_fx.value=num
    return num_fx.fValue

# Convierte  fraccional S(NBI,NBF) a numero entero signado
def fx_to_ints(num,nb,nbf,str1,str2,str3):
    num_fx = DeFixedInt(nb, nbf, str1, str2, str3)
    num_fx.value=num
    return num_fx.value

############################################
# Definicion de resoluciones
############################################

NBI_input = 5
NBF_input = 18
NB_input = NBI_input + NBF_input

NBI_coef = 2
NBF_coef = 9
NB_coef = NBI_coef + NBF_coef

NBI_output = NBI_input + NBI_coef
NBF_output = NBF_input + NBF_coef
NB_output = NBI_output + NBF_output

W_3 = [np.cos((3*2*np.pi)/8),-np.sin((3*2*np.pi)/8)]
W_1 = [np.cos((1*2*np.pi)/8),-np.sin((1*2*np.pi)/8)]

coef1 = W_3[0]
coef2 = W_1[0]

coef1_fx = fx_to_flt(coef1,NB_coef,NBF_coef,'S','trunc','saturate')
coef2_fx = fx_to_flt(coef2,NB_coef,NBF_coef,'S','trunc','saturate')


# Archivos en hexadecimal para realizar vector matching
f0 = open('./vectors/in_csd.out', 'w')
f1 = open('./vectors/out_csd1.out', 'w')
f2 = open('./vectors/out_csd2.out', 'w')

# Vectores salidas
out_csd1_fx_v = []
out1_fx_v = []
out2_fx_v = []

# Vectores en hexadecimal
in_csd_hex = []
out1_hex = []
out2_hex = []

N = 1000

############################################
# Programa
############################################

for ptr in range(N):

    # Genero entrada
    in_csd = random.uniform(-1.0, 1.0)
    in_csd_ints = fx_to_ints(in_csd,NB_input,NBF_input,'S','trunc','saturate')
    in_csd_fx = fx_to_flt(in_csd,NB_input,NBF_input,'S','trunc','saturate')

    # Realizo multiplicacion CSD1
    csd1_res = - in_csd_ints + (in_csd_ints >> 2) + (in_csd_ints >> 5) + (in_csd_ints >> 7) + (in_csd_ints >> 9)
    csd1_res = csd1_res << NBF_coef
    out_csd1_fx = ints_to_fx(csd1_res,NB_output,NBF_output,'S','trunc','saturate')

    print "\nProducto CSD1:",out_csd1_fx
    out_csd1_fx_v.append(out_csd1_fx)

    # Realizo multiplicacion para comparar resultados
    res1 = in_csd_fx * coef1_fx
    res1_fx = fx_to_flt(res1, NB_output, NBF_output, 'S', 'trunc', 'saturate')

    print "\nProducto normal 1:",res1_fx
    out1_fx_v.append(res1_fx)

    # Realizo multiplicacion CSD2
    csd2_res = in_csd_ints - (in_csd_ints >> 2) - (in_csd_ints >> 4) + (in_csd_ints >> 6) + (in_csd_ints >> 8)
    csd2_res = csd2_res << NBF_coef
    out_csd2_fx = ints_to_fx(csd2_res, NB_output, NBF_output, 'S', 'trunc', 'saturate')

    print "\nProducto CSD2:", out_csd2_fx
    out_csd1_fx_v.append(out_csd2_fx)

    # Realizo multiplicacion para comparar resultados
    res2 = in_csd_fx * coef2_fx
    res2_fx = fx_to_flt(res2, NB_output, NBF_output, 'S', 'trunc', 'saturate')


    print "\nProducto normal 2:", res2_fx
    out1_fx_v.append(res2_fx)

    ## Logueo senales

    # Entrada
    in_csd_hex.append(hex_append(in_csd_fx, NB_input, NBF_input, "S", "trunc", "saturate"))

    # Salida
    out1_hex.append(hex_append(res1_fx, NB_output, NBF_output, "S", "trunc", "saturate"))

    # Salida
    out2_hex.append(hex_append(res2_fx, NB_output, NBF_output, "S", "trunc", "saturate"))


print("\n")

#### Escribo archivos
for ptr in range(N):
    f0.write('%s ' %in_csd_hex[ptr])
    f0.write('\n')


#### Escribo archivos
for ptr in range(N):
    f1.write('%s ' %out1_hex[ptr])
    f1.write('\n')

for ptr in range(N):
    f2.write('%s ' %out2_hex[ptr])
    f2.write('\n')


f0.close()
f1.close()
f2.close()


print ("\nEnd\n")
exit()