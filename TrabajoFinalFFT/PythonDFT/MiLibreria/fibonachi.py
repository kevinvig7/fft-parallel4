#!/usr/bin/env python2
# -*- coding: utf-8 -*-

# módulo de números Fibonacci
import numpy             as np
import matplotlib.pyplot as plt

def fib(n):    # escribe la serie Fibonacci hasta n
    a, b = 0, 1
    while b < n:
        print b,
        a, b = b, a+b

def fib2(n): # devuelve la serie Fibonacci hasta n
    resultado = []
    a, b = 0, 1
    while b < n:
        resultado.append(b)
        a, b = b, a+b
    return resultado