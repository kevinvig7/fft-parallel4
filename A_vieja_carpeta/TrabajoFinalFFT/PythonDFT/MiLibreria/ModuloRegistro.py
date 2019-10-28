#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import numpy             as np
import matplotlib.pyplot as plt
import scipy.signal      as signal
import scipy
import sys
import os
from   fibonachi import fib, fib2

# Funcion 1
def registros(DatoIn, En, NumReg):
    
    Delay = {'d':np.zeros(NumReg), 'clk':np.zeros(NumReg)}
    
    if(En==1):

        Delay['d'][0] = DatoIn
        print(Delay)
        for index in range(NumReg-1): 
            Delay['d'][index+1] = Delay['d'][index]
            print(Delay)

    else:
        Delay['d'] = Delay['d']

    DatoOut = Delay['d'][NumReg-1]
    return(DatoOut)

# Funcion 2
def Reg2(In, Clk, En, NumReg):

    delay = {'d':np.zeros(NumReg), 'clk':np.zeros(NumReg)}

    if(Clk==1):
        print 'Desplaza'
    else:
        delay['d'] = delay['d']
    
    # Salida del registro de desplazamiento
    Out = delay['d'][NumReg-1]
    return(Out)


# Test Registro 2
Clock = 10
Samples = np.arange(Clock)

# Array de Registros
NumReg = 2
Delay = []
Registro = {'d':0.0 , 'q': 0.0}
for index in range(NumReg):
    Delay.append(Registro)

# Instancias de clock
for clk in range(Clock):
    # print 'clk =',clk
    # print 'sample=',Samples[clk]
    Delay[0]['d'] = Samples[clk]
    Delay[1]['d'] = Delay[0]['d']

    print 'Out =',Delay['D'][NumReg-1]

    


# Reg2(In=5, Clk=1, En=1, NumReg=4)
# Test Registro 1
# registros(DatoIn=5, En=1, NumReg=3)