import numpy as np
import matplotlib.pyplot as plt
import _fixedInt as fx


def rcosine(beta, Tbaud, oversampling, Nbauds, Norm):
    """ Respuesta al impulso del pulso de caida cosenoidal """
    t_vect = np.arange(-0.5*Nbauds*Tbaud, 0.5*Nbauds*Tbaud, float(Tbaud)/oversampling)
    
    y_vect = []
    for t in t_vect:
        y_vect.append(np.sinc(t/Tbaud)*(np.cos(np.pi*beta*t/Tbaud)/
                                        (1-(4.0*beta*beta*t*t/(Tbaud*Tbaud)))))

    y_vect = np.array(y_vect)
    
    if(Norm):
        return (t_vect, y_vect/y_vect.sum())
    else:
        return (t_vect,y_vect)

def rrcosine(alpha, Tbaud, oversampling, Nbauds, Norm):
    N = Nbauds*oversampling
    Ts = Tbaud
    Fs = oversampling/Tbaud


    T_delta = 1/float(Fs)
    time_idx = ((np.arange(N)-N/2))*T_delta
    sample_num = np.arange(N)
    h_rrc = np.zeros(N, dtype=float)

    for x in sample_num:
        t = (x-N/2)*T_delta
        if t == 0.0:
            h_rrc[x] = 1.0 - alpha + (4*alpha/np.pi)
        elif alpha != 0 and t == Ts/(4*alpha):
            h_rrc[x] = (alpha/np.sqrt(2))*(((1+2/np.pi)* \
                    (np.sin(np.pi/(4*alpha)))) + ((1-2/np.pi)*(np.cos(np.pi/(4*alpha)))))
        elif alpha != 0 and t == -Ts/(4*alpha):
            h_rrc[x] = (alpha/np.sqrt(2))*(((1+2/np.pi)* \
                    (np.sin(np.pi/(4*alpha)))) + ((1-2/np.pi)*(np.cos(np.pi/(4*alpha)))))
        else:
            h_rrc[x] = (np.sin(np.pi*t*(1-alpha)/Ts) +  \
                    4*alpha*(t/Ts)*np.cos(np.pi*t*(1+alpha)/Ts))/ \
                    (np.pi*t*(1-(4*alpha*t/Ts)*(4*alpha*t/Ts))/Ts)

    return time_idx, h_rrc

def eyediagram(data, n, offset, period, color1):
    span     = 2*n
    segments = int(len(data)/span)
    xmax     = (n-1)*period
    xmin     = -(n-1)*period
    x        = list(np.arange(-n,n,)*period)
    xoff     = offset

    plt.figure()
    for i in range(0,segments-1):
        plt.plot(x, data[(i*span+xoff):((i+1)*span+xoff)],color1)
        plt.hold(True)
        plt.grid(True)

    plt.xlim(xmin, xmax)

def fixing_append(vector):
    fixed_vector = []
    for ptr in range(len(vector)):
        fixed_vector.append(vector[ptr].fValue)
    return fixed_vector


def twos_comp(val,NB):
    if(val>=2**(NB-1)):
        return val - 2**NB
    else:
        return val
'''
def twos_comp(val,NB):
    num = (val+2**(NB-1))&0xFF
    num = ( num - 2**(NB-1) ) * (2**-6)
    return num
'''