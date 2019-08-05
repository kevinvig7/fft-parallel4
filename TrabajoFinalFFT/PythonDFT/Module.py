#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import numpy             as np
import matplotlib.pyplot as plt
import commpy.filters    as compyf
import scipy.signal      as signal
import scipy.special     as special
import scipy
import math
import sys
import os
from   sk_dsp_comm  import digitalcom   as dc
from   MiLibreria   import MisFunciones as Myfunc


##########################
# Main Code
##########################

def main():
    os.system("clear")
    
    print('Test_Funciones:\n')

    f1()
    f2()
    Myfunc.f3()
    return(0)

##########################
# Functions
##########################
def f1(x=2, y=2):
    print('Funcion_1')
    return(0)

##########################
def f2(x=2, y=2):
    print('Funcion_2')
    return(0)

##########################
if __name__ == '__main__':
    main()
##########################