#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import sys
import numpy as np
from   scipy.sparse.csgraph import csgraph_from_dense
from   scipy.sparse         import csr_matrix
from   scipy.sparse.csgraph import bellman_ford
from   scipy.sparse.csgraph import floyd_warshall
# Link web
# https://docs.scipy.org/doc/scipy/reference/generated/scipy.sparse.csgraph.bellman_ford.html

# Matriz de nodos y pesos a Cargar
# Cada posicion (i,j) de la matriz representa el nodo de partida y de llagada respectivamente, en el cual en esa posicion se le debe de 
# asignar el PESO del nodo Ui-->Vj
# Recordar que al diagrama de nodos creado a partir de las restricciones (desigualdades) se le debe de agregar un nodo Adicional mas, leer
# el capitulo 4 Retiming del libro de Parhi.
# Aquellos nodos en donde no existan conexion de le debe de aignar peso infinito.
# Ejemplo: si el orden de la mariz es de orden 5, entonces los elementos de la matriz van desde la posicion 0,0 hasta la 4,4, es decir
# si el grafo posee 5 nodos, la matriz lo representa desde el nodo 0 al nodo 4.
G_data = np.array([[np.inf, np.inf, 0,      np.inf, np.inf],                                            
                   [0,      np.inf, np.inf, np.inf, np.inf],
                   [0,      np.inf, np.inf, np.inf, np.inf],      
                   [-1,     -1,     np.inf, np.inf, np.inf],        
                   [0,      0,      0,      0,      np.inf]])

# Las siguientes 2 funciones, simplemente transforman la matriz cargada anteriormente para que se representen adecuadamente aquellos pesos de
# valores cero (0) y transiciones infinitas.
G_masked = np.ma.masked_invalid(G_data)   
print 'Matriz de Pesos: \n\n', G_masked, '\n'                                                                  
G_sparse = csgraph_from_dense(G_data, null_value=np.inf)

print 'Nodos y pesos: (U--w-->V):\n'
print '  (U, V) -----> weight'
print G_sparse

# El valor del Indice es el orden de la matriz menos uno: M-1
# La funcion regresa la distancia mas corta desde un punto i a un punto j sobre el grafo 
#dist_matrix, predecessors = floyd_warshall(csgraph=G_sparse, directed=True, return_predecessors=True), directed=True, return_predecessors=True)   
dist_matrix, predecessors = bellman_ford(csgraph=G_sparse, directed=True, indices=len(G_data)-1, return_predecessors=True)
print '\nThe Shortest Path Lengths: \n', dist_matrix, '\n' 
#print predecessors


# Matrices de prueba, tomadas del libro; Unidad 4, unidad 6, Apendice A
#G_data = np.array([[np.inf, np.inf, 5,      4,      np.inf],                                                                                             
#                   [0     , np.inf, 2,      np.inf, np.inf],                           
#                   [np.inf, np.inf, np.inf, -1,     np.inf],        
#                   [np.inf, np.inf, np.inf, np.inf, np.inf],        
#                   [0     , 0,      0,      0,      np.inf]])   
#
#
#G_data = np.array([[np.inf, -3,     np.inf, np.inf],                                                                                                    
#                   [np.inf, np.inf, 1,      2     ],                                   
#                   [np.inf, np.inf, np.inf, 2     ],                     
#                   [1,      np.inf, np.inf, np.inf]])  
#
#  
#G_data = np.array([[np.inf, -1,     np.inf, -1,     np.inf],                                                                                                
#                   [np.inf, np.inf, 0,      np.inf, np.inf],                      
#                   [np.inf, 0,      np.inf, np.inf, np.inf],             
#                   [np.inf, 0,      np.inf, np.inf, np.inf], 
#                   [0     , 0,      0,      0,      np.inf]]) 
