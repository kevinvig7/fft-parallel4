#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import numpy as np
print("Test Problem 2: LPM")
print("===================\n")

# matriz LPM
LPM = []
# numero de registros
#NumReg = 4
#NumReg = 5
NumReg = 3
# matriz de Inspeccion 
#L1 = np.array ( [ [-1, 0, -1, -1], [4, -1, 0, -1], [5, -1, -1, 0], [5, -1, -1, -1] ] ) 
#L1 = np.array ( [ [-1, 0, -1, -1, -1], [18, -1, 0, -1, -1], [-1, -1, -1, 0, -1], [22, -1, -1, -1, 0], [22, -1, -1, -1, -1] ] ) 
L1 = np.array ( [ [28, 14, -1], [42, 28, 14], [42, 28, 14] ] ) 
print 'Matriz L1: \n', L1
LPM.append(L1)

maximo   = -1
ArgLista = [-1]
ceros    = (len(LPM[0]), len(LPM[0]))
L2       = np.zeros(ceros)
i        = 0
j        = 0

# genero matrices
for delay in xrange (NumReg-1):
    # Fila variable
    for i in xrange (len(LPM[0])):
        # Fila fija, columna variable
        for j in xrange (len(LPM[0])):
            # argumentos para diferentes k=NumReg
            for k in range (NumReg):
                l1  = LPM[0]    [i][k]
                l2  = LPM[delay][k][j]  
                if(l1==-1 or l2==-1):
                    ArgLista.append(-1)
                else:
                    ArgLista.append(l1+l2)
                   
            #print'Lista: \n', ArgLista, '\n'
            
            # obtengo el maximo de ArgLista
            for k in range (NumReg+1):
                if (ArgLista[k]>=maximo):
                    maximo = ArgLista[k]  
            
            #print'maximo: ', maximo, '\n'
            # Asigno el maximo, limpio Lista, fijo valor de comparacion (-1)
            L2[i][j] = maximo
            ArgLista = [-1]
            maximo   = -1
        
    print'Matriz L{}'.format(delay+2), '\n', L2 
    # Agrego 2da, 3era, 4ta matrix
    LPM.append(L2)
    # limpio matriz de almacenamiento auxiliar
    L2 = np.zeros(ceros)
