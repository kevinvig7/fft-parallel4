#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""Ejemplos de Ayuda"""
import numpy             as np
import matplotlib.pyplot as plt
import time
import scipy.special     as special 
from   scipy         import signal
from   scipy         import stats
from   sk_dsp_comm   import digitalcom as dc



x = np.arange(20)
stats.tvar(x)
stats.tvar(x, (3,17))

np.arange(3)
np.arange(3.0)
np.arange(3,7)
np.arange(3,7,2)

np.array([1, 2, 3])
print np.array([[1, 2], [3, 4]])

np.array([1, 2, 3], dtype=complex)
np.array(np.mat('1 2; 3 4'))

for ptr in range(5): print ptr
lista = [5,6,8,7,9]
for ptr in lista: print ptr

#A un arreglo no se puede asignar un numero complejo
ak_hat = np.arange(len(lista))*0

#---
x1 = np.random.randint(10, size=6)  # One-dimensional array
x2 = np.random.randint(10, size=(3, 4))  # Two-dimensional array
x3 = np.random.randint(10, size=(3, 4, 5))  # Three-dimensional array

print("x3 ndim: ", x3.ndim)
print("x3 shape:", x3.shape)
print("x3 size: ", x3.size)
print("itemsize:", x3.itemsize, "bytes")
print("nbytes:", x3.nbytes, "bytes")

x1[0] = 3.14159  # this will be truncated!
print 'se trunco en la asignacion',x1

#Arreglos
x = np.arange(10)
x[:5]  # first five elements
x[5:]  # elements after index 5
x[4:7]  # middle sub-array
x[::2]  # every other element
x[1::2]  # every other element, starting at index 1
x[::-1]  # all elements, reversed

#Multi-dimensional subarrays
x2[:2, :3]  # two rows, three columns
x2[:3, ::2]  # all rows, every other column
x2[::-1, ::-1]

#Reshaping of Arrays
grid = np.arange(1, 10).reshape((3, 3))
print(grid)

#Concatenation of arrays
x = np.array([1, 2, 3])
y = np.array([3, 2, 1])
np.concatenate([x, y])

# concatenate along the first axis
print np.concatenate([grid, grid])
# concatenate along the second axis (zero-indexed)
np.concatenate([grid, grid], axis=1)

#For working with arrays of mixed dimensions, 
#it can be clearer to use the np.vstack (vertical stack) and np.hstack (horizontal stack) functions:
x = np.array([1, 2, 3])
grid = np.array([[9, 8, 7],
                 [6, 5, 4]])

# vertically stack the arrays
np.vstack([x, grid])

# horizontally stack the arrays
y = np.array([[99],
              [99]])
np.hstack([grid, y])

#---
a = [-1, 1, 66.25, 333, 333, 1234.5]
del a[0]
#Tuple
v = ([1, 2, 3], [3, 2, 1])

#Diccionarios
tel = {'jack': 4098, 'sape': 4139}
tel['guido'] = 4127
'guido' in tel
'jack' not in tel

#Enumeracion
for i, v in enumerate(['ta', 'te', 'ti']):
    print(i, v)
    
preguntas = ['nombre', 'objetivo', 'color favorito']
respuestas = ['lancelot', 'el santo grial', 'azul']
for p, r in zip(preguntas, respuestas):
    print('Cual es tu {0}?  {1}.'.format(p, r))

#Igual al Append.
lista=[1,2,3,4,5,6]
lista[len(lista):] = [8]

for x in [1,'hello',3]: 
    print x

#---
arreglo = np.arange(-5,5+1,1)
np.flipud(arreglo)

#---Aderir/agregar elementos a un Array
arreglo=np.arange(10)
arreglo=np.append(arreglo,18)

#---
arreglo=np.arange(5)
rms = np.sqrt(np.mean(arreglo**2))
#---
special.factorial(5)
#---
#Return the sum along diagonals of the array.
np.trace(np.eye(3))
#NORMA
symbols_comparison  = np.array([ [-1.0000 + 1j*1.0000], 
                                 [-1.0000 - 1j*1.0000], 
                                 [1.0000 + 1j*1.0000 ], 
                                 [1.0000 - 1j*1.0000 ]  ]);
    
1/np.linalg.norm(symbols_comparison[0,0]);#0.707

#varianza
np.var(symbols_comparison)#2

#the sign of a number.
np.sign([-5., 4.5])
np.sign(0)

#Test Array
testarray = np.array([])
testarray = (2,2)

#Ejemplo Ofdm
x1,b1,IQ_data1 = dc.QAM_bb(50000,1,'16qam')
x_out = dc.OFDM_tx(IQ_data1,32,64)
plt.psd(x_out,2**10,1);
plt.xlabel(r'Normalized Frequency ($\omega/(2\pi)=f/f_s$)')
plt.ylim([-40,0])
plt.xlim([-.5,.5])

#Round elements of the array to the nearest integer.
a = np.array([-1.7, -1.5, -0.2, 0.2, 1.5, 1.7, 2.0])
np.rint(a)

#Draw samples from a binomial distribution.
np.random.binomial(size=3, n=1, p= 0.5)
#size: number of experiments; n: number of trails; p: probability of success

# Agregar elementos Array
R2p = np.array([],dtype=float)
R2p = np.append(R2p, 2+6j)

# Numeros Aleatorios
# vector de 0 y 1 de tamaño 10
np.random.randint(2, size=10)
# Matriz aleatoria 
np.random.randint(5, size=(2, 4))

constellation = np.array([1+1j, 1-1j, -1+1j, -1-1j])
np.random.choice(constellation, size=5)
np.random.choice(constellation, size=(2,3))

aleatorio= (2*np.random.randint(2, size=(2, 15)))-1
#---
# La Distribución Normal, o también llamada Distribución de Gauss
# Graficando Normal
# https://relopezbriega.github.io/blog/2016/06/29/distribuciones-de-probabilidad-con-python/
mu, sigma = 0, 1 # media y desvio estandar
normal = stats.norm(mu, sigma)
x = np.linspace(normal.ppf(0.01), normal.ppf(0.99), 100)
fp = normal.pdf(x) # Función de Probabilidad
plt.figure();
plt.plot(x, fp)
plt.title('Distribucion Normal')
plt.ylabel('probabilidad')
plt.xlabel('valores')

# the histogram of the data
mu, sigma = 0, 0.3984375
x = mu + sigma * np.random.randn(10000)
plt.figure();
plt.hist(x, 50, density=True, facecolor='g', alpha=0.75)
plt.xlabel('Smarts')
plt.ylabel('Probability')
plt.title('Histogram of IQ')
plt.text(60, .025, r'$\mu=100,\ \sigma=15$')
plt.grid(True)

# Test Metodo Tiempo
print "Start : %s" % time.ctime()
time.sleep( 5 )
print "End : %s" % time.ctime()

localtime = time.asctime( time.localtime(time.time()) )
print "Local current time :", localtime

num = raw_input('How long to wait: ')
# El resultado es '12.566' string
# Transforma el String to Float
float(num)

#Diccionario
diccionario = {
     "clave1":234,
     "clave2":True,
     "clave3":"Valor 1",
     "clave4":[1,2,3,4]
}
type(diccionario['clave1'])

#Iteracion
for i, v in enumerate(['ta', 'te', 'ti']):
    print i, v

#LIsta, Tomando 2 elementos
lista  = [1245,15555,'kola!']
take   = lista[0:2]
#toma el primer elemento y luego lo elimina de la lista
Reduce = lista.pop(0)

#vSTACK
lista  = [1245,15555,'kola!']
lista2 = ['0','1','5']
#Devuelve una matriz array el cual contiene las listas
mem = np.vstack((lista,lista2))
mem[0,]

#Creando una STACK a partir de Listas |_drg_|
#Las Listas apiladas deben de tener la MISMA cantidad de elementos!!
ListaNew = []
ListaNew.append(lista)
ListaNew.append(lista2)
NewMem = np.vstack(tuple(ListaNew))


#TEST: lista, cadena 
cadena =[]
c = ['000\x08']
for ptr in range(len(c[0])): 
    print c[0][ptr]
    if (c[0][ptr]=='0'):
        cadena.append('\x00')
    else:
        cadena.append(c[0][ptr])

print 'cadena', cadena
trans = ""
for ptr in range(len(cadena)): 
    trans=trans+cadena[ptr]


#Convertir un numero SIGNADO
#---------------------------
print '\n'
print 'Convertir un numero signado:'
print 'señal S(16,13) Q(3,13)'
nbt = 16
nbf = 13

binarioPos = 0b0011010000000000
binarioNeg = 0b1111010000000000
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

# Bucle 
# Arranca en 3, pasos de 2, hasta (10-1)
for n in xrange (3,10,2):
    print n
# Su salida es:
#3
#5
#7
#9

for n_samples,n_tests in [(100000,3), (10000,30), (1000,100), (100,500), (10,500)]: 
    print n_samples,n_tests
# Su salida es:
#100000 3
#10000 30
#1000 100
#100 500
#10 500

# Repeticion de un valor y Funcion
potencia = lambda x: x**3
# Repite la funcion, de acuerdo al bucle
[potencia(k) for k in xrange(5)]   
# Out[93]: [0, 1, 8, 27, 64]

# CONDICIONAL en LINEA
v = 5
r = 2*(v>2) #r=2
r = 2*(v>6) #r=0

# Otro Ejemplos
salir = False
# el operador (not) invierte el valor de la variable
while not salir:
    salir = True
    print 'fin del Bucle'

a = raw_input('Put your selection: ')
# si le ingreas el 0, un entero
# a = '0'

# Represent Infinite
infinite = float("inf")

"""
# LIMPIAR PANTALLA
# En windows
import os
borrar = os.system('cls')
# En Linux
import os
borrar = os.system('clear')

def clear(): #También la podemos llamar cls (depende a lo que estemos acostumbrados)
    if os.name == "posix":
        os.system ("clear")
    elif os.name == ("ce", "nt", "dos"):
        os.system ("cls")
clear()
"""





























###################################
#plt.show()
print'\n\n'
###################################
"""
fc = 0.2
b, a = signal.butter(15, fc)
n = np.arange(500)
c = 0.0005
x = np.exp(-c*(n-250) ** 2)

H, w = signal.freqz(b, a, 4096)
W, gd = signal.group_delay((b, a), 4096)

w0 = .92 * np.pi * fc  # carrier frequency
y = x * np.cos(w0*n)   # modulated signal
z = signal.lfilter(b,a,y)

I = np.argmin([abs(ww-w0) for ww in W])
tau = int(gd[I])       # tau

plt.figure()
plt.plot(W, gd)
plt.show()

plt.subplot(2,1,1)
plt.plot(n,y)
plt.subplot(2,1,2)
plt.plot(n,z)
plt.plot(n[:-tau],z[tau:], '--', label='spline')
plt.legend(loc='center')
plt.show()
"""