from tool._fixedInt import * 
#from tool.r_cosine import *
import numpy as np

def rcosine(beta, Tbaud, oversampling, Nbauds, Norm=False):
	""" Respuesta al impulso del pulso de caida cosenoidal """
	t_vect = np.arange(-0.5*Nbauds*Tbaud, 0.5*Nbauds*Tbaud, float(Tbaud)/oversampling)
	
	y_vect = []
	for t in t_vect:
		y_vect.append(np.sinc(t/Tbaud)*(np.cos(np.pi*beta*t/Tbaud)/(1-(4.0*beta*beta*t*t/(Tbaud*Tbaud)))))

	y_vect =np.array(y_vect)

	
	if(Norm):
		return (t_vect, y_vect/y_vect.sum())
	else:
		return (t_vect,y_vect)

def rcosine_gen(opt='int', beta=0.5, T=1.0/1024000.0, os=4.0, N_BAUD=8.0, NB=8, NBF=7, round_mode='round'):
	# Parametros generales
	# T     = 1.0/1024000.0 # Periodo de baudio 
	# os    = 4.0           # Factor de sobremuestreo (M)
	# Nbauds = 8.0          # Cantidad de baudios del filtro
	# beta   = 0.5		  	# Roll-Off

	(t, rcosine_coef) = rcosine(beta, T, os, N_BAUD)

	rcosine_coef_fx = arrayFixedInt(NB, NBF, rcosine_coef, roundMode='round')   
	#rcosine_coef_fxv = []
	rcosine_coef_fxint = []
	for ptr in range(len(rcosine_coef_fx)):
		#rcosine_coef_fxv.append(rcosine_coef_fx[ptr].fValue)
		rcosine_coef_fxint.append(rcosine_coef_fx[ptr].intvalue)

	#print rcosine_coef_fxint
	#print len(rcosine_coef_fxv)
	if (opt=='int'):				# return coef as intvalues (for verilog sim)
		return rcosine_coef_fxint
	elif (opt=='fixed'):			# return coef as DeFixedInt objects (for myhdl sim)
		return rcosine_coef_fx

#coef = rcosine_gen()
#print coef