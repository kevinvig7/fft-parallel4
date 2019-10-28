import numpy as np
import matplotlib.pyplot as plt
from tool._fixedInt import *
import scipy


############################################
# Declaracion de funciones
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

# Funcion para concatenar hexadecimal de vector fixed
def hex_append_v(vector,nb,nbf,str1,str2,str3):
    vector_fx = arrayFixedInt(nb, nbf, vector, str1, str2, str3)
    vector_hex =[]
    for ptr in range(len(vector)):

        vector_hex.append((hex(vector_fx[ptr].intvalue))[2:].zfill(int(math.ceil(nb/4))))
    return vector_hex

# Funcion para obtener valor hexadecimal de numero fixed
def hex_append(num,nb,nbf,str1,str2,str3):
    num_fx = DeFixedInt(nb, nbf, str1, str2, str3)
    num_fx.value=num
    return hex(num_fx.intvalue)[2:].zfill(int(math.ceil(nb/4)))

# Funcion para obtener numero float a partir de numero fixed
def fx_to_flt(num,nb,nbf,str1,str2,str3):
    num_fx = DeFixedInt(nb, nbf, str1, str2, str3)
    num_fx.value=num
    return num_fx.fValue

# Simulacion en punto fijo
def sim_fx(ch_sel,step_sel):

    ############################################
    # Declaracion e inicializacion de variables
    ############################################
    # Definicion de resoluciones
    NBI_coef = 2
    NBF_coef = 6
    NB_coef = NBI_coef + NBF_coef

    NBI_out_ffe= 2
    NBF_out_ffe= 6
    NB_out_ffe = NBI_out_ffe + NBF_out_ffe

    NBI_ch_dsp=4
    NBF_ch_dsp = 7
    NB_ch_dsp= NBI_ch_dsp + NBF_ch_dsp

    NBI_error=1
    NBF_error=NBF_out_ffe
    NB_error = NBI_error + NBF_error

    NBI_steps = 1
    NBF_steps = 7
    NB_steps = NBI_steps + NBF_steps


    NBF_prod1_lms= NBF_ch_dsp + NBF_steps
    NBI_prod1_lms= NBI_ch_dsp + NBI_steps
    NB_prod1_lms = NBI_prod1_lms + NBF_prod1_lms

    NBF_prod2_lms= NBF_ch_dsp + NBF_error + NBF_steps
    NBI_prod2_lms= NBI_ch_dsp + NBI_error + NBI_steps
    NB_prod2_lms = NBI_prod2_lms + NBF_prod2_lms

    NBF_sum_lms=NBF_prod2_lms
    NBI_sum_lms=NBI_prod2_lms + 6
    NB_sum_lms = NBI_sum_lms + NBF_sum_lms


    NBF_prod_ffe= NBF_ch_dsp + NBF_coef
    NBI_prod_ffe= NBI_ch_dsp + NBI_coef
    NB_prod_ffe = NBI_prod_ffe + NBF_prod_ffe

    NBF_sum_ffe = NBF_prod_ffe
    NBI_sum_ffe = NBI_prod_ffe +3
    NB_sum_ffe =  NBI_sum_ffe + NBF_sum_ffe


    # Archivos en hexadecimal para realizar vector matching
    f0 = open('./vectors/out_ch_dsp_py.out', 'w')
    f1 = open('./vectors/out_ffe_py.out', 'w')
    f2 = open('./vectors/out_error_py.out', 'w')
    f3 = open('./vectors/out_coef_py.out', 'w')
    f4 = open('./vectors/prod_ffe_py.out', 'w')
    f5 = open('./vectors/prod_lms1_py.out', 'w')
    f6 = open('./vectors/prod_lms2_py.out', 'w')

    # Vectores para vectormatching y graficas
    ffe_out_fxv = []
    error_fxv = []
    ffe_coef_fxv = []
    ch_out_fxv = []


    ch_out_fxv_hex=[]
    ffe_out_fxv_hex =[]
    error_fxv_hex = []
    ffe_coef_fxv_hex=[]
    ffe_prod_fxv_hex = []
    lms1_prod_fxv_hex = []
    lms2_prod_fxv_hex = []

    label_fx = "channel = %d, step= %d" % (ch_sel, step_sel)
    label_fig = "ch_%dstp_%d" % (ch_sel, step_sel)

    # Varaibles generales

    Nsymb     = 3000 ## Numero de Simbolos
    step_sel  = 2   ## Paso
    ch_sel    = 1    ## Canal
    N_ret_fir = 5# Retardos salida de filtro FIR

    # Canales
    channel   = [[0,0,0,0.9921875,0,0,0],
                 [0,0,0.2421875,0.96875,0,0,0],
                 [0,0,0.2421875,0.96875,0.09375,0,0],
                 [0,0.171875,0.4375,0.875,0.0859375,0,0]]

    #Invierto orden de coeficientes
    channel[1][:] = channel[1][::-1]
    channel[2][:] = channel[2][::-1]
    channel[3][:] = channel[3][::-1]

    ## Pasos de adaptacion
    steps     = [0,2**-7,2**-5,2**-3]

    ## Inicializacion de los coeficientes del FFE
    ffe_coef = [0.0,0.0,0.0,1.0,0.0,0.0,0.0]  ## s(9,7)

    # Inicializacion de variables
    prod_ffe = np.zeros(len(ffe_coef))
    ffe_shiftR = np.zeros(len(ffe_coef)+1)
    lms_shiftR = np.zeros(len(ffe_coef))
    sum_lms = np.zeros(len(ffe_coef))
    prod2 = np.zeros(len(ffe_coef))

    # Inicializacion de Registros
    lms_coef_reg = {'d':np.zeros(len(ffe_coef)), 'q':ffe_coef}
    lms_to_ffe_reg =  {'d':np.zeros(len(ffe_coef)), 'q':ffe_coef}
    ffe_in_reg  = {'d':0.0 , 'q': 0.0}
    ffe_pipe1_sum_reg  = {'d':0.0 , 'q': 0.0}
    ffe_pipe2_prod_reg = {'d':np.zeros(len(ffe_coef)), 'q':np.zeros(len(ffe_coef))}
    ffe_pipe3_coef_reg = {'d':np.zeros(3), 'q':np.zeros(3)}
    ffe_out_reg = {'d':0.0 , 'q': 0.0}
    lms_in_reg1 =  {'d':0.0 , 'q': 0.0}
    lms_in_reg2 =  {'d':0.0 , 'q': 0.0}
    lms_in_reg3 =  {'d':0.0 , 'q': 0.0}
    lms_pipe1_prod = {'d':np.zeros(len(ffe_coef)), 'q':np.zeros(len(ffe_coef))}
    lms_pipe2_prod = {'d':np.zeros(len(ffe_coef)), 'q':np.zeros(len(ffe_coef))}

    ############################################
    # Programa
    ############################################

    # Genero nuevo simbolo PRBS
    a = int(0x1aa)
    symbols=[]
    for i in range(Nsymb):
        newbit = (a >> 9-1 & 1) ^ (a >> 5-1 & 1)
        a=int((a<<1 | newbit)& 0x1ff)
        if a>>9-1 & 1:
            out_prbs =  -1.0
        else:
            out_prbs =   1.0
        symbols.append(out_prbs)


    # Convolucion entre los simbolos y el canal
    ch_out    = np.convolve(channel[ch_sel],symbols,'same')
    ch_out = np.roll(ch_out, N_ret_fir)
    for i in range(N_ret_fir):
        ch_out[i] = -1.0*np.sum(channel[ch_sel]) # Estado inicial de salida FIR
    ch_out_fx = fx_to_flt_v(ch_out,NB_ch_dsp,NBF_ch_dsp,'S','trunc','saturate') # Salida de FIR considerando retardos

    for ptr in range(len(ch_out_fx)):

    #### Tomo nuevo valor de entrada de FIR
        ffe_in_reg['d'] = ch_out_fx[ptr]
        lms_in_reg1['d'] = ch_out_fx[ptr]

    #### Realizo filtrado (FFE)
        # Desplazamiento
        ffe_shiftR    = np.roll(ffe_shiftR,1)
        ffe_shiftR[0] = ffe_in_reg['q']
        # Productos
        for i in range(len(prod_ffe)+1):
            if i <=len(ffe_coef)-4:
                prod_ffe[i] = ffe_shiftR[i] * lms_to_ffe_reg['q'][i]
            if i >=len(ffe_coef)-2:
                prod_ffe[i-1] = ffe_shiftR[i] * ffe_pipe3_coef_reg['q'][i-(len(ffe_coef)-2)]
        ffe_pipe2_prod_reg['d'] = fx_to_flt_v(prod_ffe,NB_prod_ffe, NBF_prod_ffe, 'S', 'trunc', 'saturate')

        #Sumas
        sum_ffe1 = 0.0
        for j in range(len(prod_ffe)-3):
            sum_ffe1 = ffe_pipe2_prod_reg['q'][j] + sum_ffe1
        ffe_pipe1_sum_reg['d']=fx_to_flt(sum_ffe1,NB_sum_ffe,NBF_sum_ffe,'S','trunc','saturate')
        sum_ffe2 = ffe_pipe1_sum_reg['q']
        for j in range(len(prod_ffe) - 4):
            sum_ffe2 = ffe_pipe2_prod_reg['q'][j+4] + sum_ffe2
        sum_ffe_tys = fx_to_flt(sum_ffe2,NB_sum_ffe,NBF_sum_ffe,'S','trunc','saturate')
        ffe_out_reg['d'] = fx_to_flt(sum_ffe_tys,NB_out_ffe,NBF_out_ffe,'S','trunc','saturate')

    #### Calculo de error

        dec = 2*(ffe_out_reg['q']>0.0)-1
        error = dec - ffe_out_reg['q']
        error_tys = fx_to_flt(error,NB_error,NBF_error,'S','trunc','saturate')


    #### Adaptacion de los coeficientes (LMS)

        # Desplazo delay de entrada
        lms_in_reg2['d'] = lms_in_reg1['q']
        lms_in_reg3['d'] = lms_in_reg2['q']

        # Desplazamiento
        lms_shiftR = np.roll(lms_shiftR,1)
        lms_shiftR[0] = lms_in_reg3['q']

        # Realizo productos por step
        prod1 = steps[step_sel] * lms_shiftR
        lms_pipe1_prod['d']= fx_to_flt_v(prod1,NB_prod1_lms, NBF_prod1_lms, 'S', 'trunc', 'saturate')

        # Realizo productos por errores
        for i in range(len(ffe_coef)):
            prod2[i] = error_tys * lms_pipe1_prod['q'][i]
        lms_pipe2_prod['d'] = fx_to_flt_v(prod2, NB_prod2_lms, NBF_prod2_lms, 'S', 'trunc', 'saturate')

        # Realizo sumas
        for i in range(len(ffe_coef)):
            sum_lms[i]= lms_pipe2_prod['q'][i]+lms_coef_reg['q'][i]
        sum_lms_fx = fx_to_flt_v(sum_lms,NB_sum_lms, NBF_sum_lms, 'S', 'trunc', 'saturate')
        lms_coef_reg['d'] = fx_to_flt_v(sum_lms_fx,NB_prod2_lms, NBF_prod2_lms, 'S', 'trunc', 'saturate')
        lms_to_ffe_reg['d']= fx_to_flt_v(sum_lms_fx,NB_coef, NBF_coef, 'S', 'trunc', 'saturate')

        # Actualizo retardos de coeficientes 4, 5 y 6
        ffe_pipe3_coef_reg['d'][0]=lms_to_ffe_reg['q'][len(ffe_coef)-3]
        ffe_pipe3_coef_reg['d'][1]=lms_to_ffe_reg['q'][len(ffe_coef)-2]
        ffe_pipe3_coef_reg['d'][2] = lms_to_ffe_reg['q'][len(ffe_coef)-1]

        ## Logueo de senales para graficar

        # Salida de FFE
        ffe_out_fxv.append(ffe_out_reg['q'])

        # Salida de Error
        error_fxv.append(error_tys)

        #Coef
        ffe_coef_fxv.append(lms_to_ffe_reg['q'])


    #### Logueo de senales para vector matching

        # Canal de entrada
        ch_out_fxv_hex.append(hex_append(ch_out_fx[ptr],NB_ch_dsp,NBF_ch_dsp,"S","trunc","saturate"))

        # Salida de FFE
        ffe_out_fxv_hex.append(hex_append(ffe_out_reg['q'],NB_out_ffe,NBF_out_ffe,"S","trunc","saturate"))

        # Error
        error_fxv_hex.append(hex_append(error_tys, NB_error, NBF_error, "S", "trunc", "saturate"))

        # Coef
        ffe_coef_fxv_hex.append(hex_append_v(lms_to_ffe_reg['q'],NB_coef,NBF_coef,"S","trunc","saturate"))

        # Prodcuctos FFE
        ffe_prod_fxv_hex.append(hex_append_v(ffe_pipe2_prod_reg['q'],NB_prod_ffe,NBF_prod_ffe,"S","trunc","saturate"))

        # Productos 1 LMS
        lms1_prod_fxv_hex.append(hex_append_v(lms_pipe1_prod['q'], NB_prod1_lms, NBF_prod1_lms, "S", "trunc", "saturate"))

        # Productos 2 LMS
        lms2_prod_fxv_hex.append(hex_append_v(lms_pipe2_prod['q'], NB_prod2_lms, NBF_prod2_lms, "S", "trunc", "saturate"))


    #### Actualizo registros
        lms_coef_reg['q'] = lms_coef_reg['d']
        lms_to_ffe_reg['q'] = lms_to_ffe_reg['d']
        ffe_in_reg['q'] = ffe_in_reg['d']
        ffe_pipe1_sum_reg['q'] = ffe_pipe1_sum_reg['d']
        ffe_pipe2_prod_reg['q'] = ffe_pipe2_prod_reg['d']
        ffe_pipe3_coef_reg['q'] = ffe_pipe3_coef_reg['d']
        ffe_out_reg['q'] = ffe_out_reg['d']
        lms_in_reg1['q'] = lms_in_reg1['d']
        lms_in_reg2['q'] = lms_in_reg2['d']
        lms_in_reg3['q'] = lms_in_reg3['d']
        lms_pipe1_prod['q'] = lms_pipe1_prod['d']
        lms_pipe2_prod['q'] = lms_pipe2_prod['d']

    #### Escribo archivos
    for ptr in range(len(ch_out_fxv_hex)):
        f0.write('%s\n' % ch_out_fxv_hex[ptr])
    for ptr in range(len(ffe_out_fxv_hex)):
        f1.write('%s\n' % ffe_out_fxv_hex[ptr])
    for ptr in range(len(error_fxv_hex)):
        f2.write('%s\n' % error_fxv_hex[ptr])
    for ptr in range(len(ffe_coef_fxv_hex)):
        for ptr1 in range(len(ffe_coef)):
            f3.write('%s ' % ffe_coef_fxv_hex[ptr][ptr1])
        f3.write("\n")
    for ptr in range(len(ffe_prod_fxv_hex)):
        for ptr1 in range(len(ffe_coef)):
            f4.write('%s ' % ffe_prod_fxv_hex[ptr][ptr1])
        f4.write("\n")
    for ptr in range(len(lms1_prod_fxv_hex)):
        for ptr1 in range(len(ffe_coef)):
            f5.write('%s ' % lms1_prod_fxv_hex[ptr][ptr1])
        f5.write("\n")
    for ptr in range(len(lms2_prod_fxv_hex)):
        for ptr1 in range(len(ffe_coef)):
            f6.write('%s ' % lms2_prod_fxv_hex[ptr][ptr1])
        f6.write("\n")

    f0.close()
    f1.close()
    f2.close()
    f3.close()
    f4.close()
    f5.close()
    f6.close()

    #### Realizo graficos
    plt.figure()
    plt.stem(ch_out_fx [0:100])
    plt.grid()
    plt.ylim((np.min(ch_out_fx [0:100])-0.5,np.max(ch_out_fx [0:200])+0.5))
    plt.ylabel('Amplitude')
    plt.xlabel('Samples')
    plt.title('FFE Input, '+label_fx)
    plt.savefig('./graficos/Fixed/fig4_'+label_fig+'.png')

    plt.figure()
    plt.subplot(2,1,1)
    plt.stem(ffe_out_fxv[0:100])
    plt.grid()
    plt.ylim((np.min(ffe_out_fxv)-0.5,np.max(ffe_out_fxv)+0.5))
    plt.ylabel('Amplitude')
    plt.xlabel('Samples')
    plt.title('FFE Output and Error, '+label_fx)
    plt.subplot(2,1,2)
    plt.plot(error_fxv)
    plt.grid()
    plt.ylim((np.min(error_fxv)-0.5,np.max(error_fxv)+0.5))
    plt.ylabel('Amplitude')
    plt.xlabel('Samples')
    plt.savefig('./graficos/Fixed/fig2_'+label_fig+'.png')

    plt.figure()
    plt.subplot(3,1,1)
    plt.plot(ffe_coef_fxv[0:1000])
    plt.grid()
    plt.ylim((min(ffe_coef_fxv[len(ffe_coef_fxv)-1])-0.5,max(ffe_coef_fxv[len(ffe_coef_fxv)-1])+0.5))
    plt.ylabel('Amplitude')
    plt.title('Taps of FFE, '+label_fx)
    plt.subplot(3,1,2)
    plt.stem(ffe_coef_fxv[len(ffe_coef_fxv)-1])
    plt.grid()
    plt.ylim((min(ffe_coef_fxv[len(ffe_coef_fxv)-1])-0.5,max(ffe_coef_fxv[len(ffe_coef_fxv)-1])+0.5))
    plt.ylabel('Amplitude')
    plt.subplot(3,1,3)
    plt.stem(np.convolve(channel[ch_sel],ffe_coef_fxv[len(ffe_coef_fxv)-1]))
    plt.grid()
    plt.ylim((min(ffe_coef_fxv[len(ffe_coef_fxv)-1])-0.5,max(ffe_coef_fxv[len(ffe_coef_fxv)-1])+0.5))
    plt.ylabel('Conv.Ch.Taps')
    plt.xlabel('Samples')
    plt.savefig('./graficos/Fixed/fig3_'+label_fig+'.png')
    plt.close()
    #plt.show()

# Ejecuto simulaciones para todos los canales y steps
sim_fx(0,0)
sim_fx(0,1)
sim_fx(0,2)
sim_fx(0,3)
sim_fx(1,0)
sim_fx(1,1)
sim_fx(1,2)
sim_fx(1,3)
sim_fx(2,0)
sim_fx(2,1)
sim_fx(2,2)
sim_fx(2,3)
sim_fx(3,0)
sim_fx(3,1)
sim_fx(3,2)
sim_fx(3,3)


print ("End\n")
exit()