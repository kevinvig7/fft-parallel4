import pytabular as pytab
import numpy as np


# Armo folding set
N = 128 # Cantidad de puntos
P = [0]*14 # Pipeline
offset = N/(2**(3))
Set_in= []

for j in range(len(P)/2):
    vect_set1 = [0] * (N/4)
    vect_set2 = [0] * (N/4)
    if j == 0:
        for i in range(len(vect_set1)):
            vect_set1[i] = ("%d" %(i * 2))
            vect_set2[i]=("%d"%(i*2+1))
    elif j>0 and j<(len(P)/2-1):
        for i in range(len(vect_set1)/2):
            vect_set1[i+ offset - N/(2**3)] = ("%d" % ( i * 2 + 1))
            vect_set1[(i + offset)%(N/4)] = ("%d" % ( i * 2))
            vect_set2[i+ offset - N/(2**3)] = ("%d" % ( i * 2 + 1 + N / 4))
            vect_set2[(i + offset)%(N/4)] = ("%d" % ( i * 2 + N / 4))
        offset += N / (2 ** (j + 3))
    else:
        for i in range(len(vect_set1)/2):
            vect_set1[(i+N/4-1)%(N/4)] = ("%d" % ( i * 2 + 1))
            vect_set1[(i + N / 8-1)] = ("%d" % ( i * 2))
            vect_set2[(i+N/4-1)%(N/4)] = ("%d" %( i * 2 + 1+ N / 4))
            vect_set2[(i + N / 8-1)] = ("%d" % (i * 2+ N / 4))
    Set_in.append(vect_set1)
    Set_in.append(vect_set2)

for i in range(len(Set_in)):
    print Set_in[i]

nom_nodo=["A","A'","B","B'","C","C'","D","D'","E","E'","F","F'","G","G'"]


for i in range(len(nom_nodo)):
    Set_in[i]=[nom_nodo[i]] + Set_in[i]


tabular = pytab.Tabular(Set_in)
print('Shape:', tabular.shape)
print(tabular)
#
# header = [['', 'Treated', '', 'Control', ''],
#           ['Measure', 'Male', 'Female', 'Male', 'Female']]
# measures = ['var{}'.format(i) for i in xrange(10)]
# data = np.random.randn(10,4).tolist()
# data = [[measures[i]] + data[i] for i in xrange(10)]
# data = header + data
# for row in data:
#     print(row)
#
# tabular = pytab.Tabular(data)
# print('Shape:', tabular.shape)
# print(tabular)
