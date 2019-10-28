#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Wed Dec 19 23:14:19 2018

@author: dani6rg
"""

import numpy             as np
import matplotlib.pyplot as plt

print 'Convertir un numero signado:'
print 'señal S(16,13) Q(3,13)'
nbt = 16
nbf = 13
binarioNeg = 0b1110000000000000#0b1111010000000000
binarioPos = 0b0010000000000000#0b0111010000000000
binarioAux = 0b1111111111111111

decimalPos = 0
decimalNeg = 0

signo = binarioPos>>(nbt-1)
if (signo!=1):
    print 'Positivo'
    decimalPos = binarioPos/2.**nbf
    print decimalPos
else:
    print 'negativo'
    
    
signo = binarioNeg>>(nbt-1)
if (signo!=1):
    print 'Positivo'
else:
    print 'negativo'
    decimalNeg = -1*((binarioNeg ^ binarioAux)+1)/2.**nbf
    print decimalNeg
    
    
    
    
    
    
    