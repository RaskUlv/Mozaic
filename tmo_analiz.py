#! /user/bin/python
# -*- coding: utf-8 -*-
# Теория массового обслуживания. Задача анализа. Находит интенсивность нагрузки канала и вероятность отказа в обслуживании.
import math
l = input('Введите среднее число вызовов в час : ')
tob = input('Введите среднее время разговора (в минутах) : ')
n = input('Введите количество каналов : ')
mu = (1.0/tob)*60
ro_ = l/mu
def Po(n,ro_) :
  x = 0
  for i in range(n+1) :
    h = math.pow(ro_,i)
    g = math.factorial(i)
    x += (h/g)
  return x
P_nul = math.pow(Po(n,ro_),-1)
P_otk = (math.pow(ro_,n)/math.factorial(n))*P_nul
print '\nИнтенсивность нагрузки канала:', ro_
print 'Вероятность отказа (занято):', P_otk
