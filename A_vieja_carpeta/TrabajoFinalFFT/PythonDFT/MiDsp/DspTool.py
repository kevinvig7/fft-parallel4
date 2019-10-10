import numpy as np
import matplotlib.pyplot as plt
#------------------------------------------------------------------------------
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
#------------------------------------------------------------------------------
def rrcosine(beta, Tbaud, oversampling, Nbauds, Norm):
    """ Square Root Raised Cosine Filter """
    t_vect = np.arange(-0.5*Nbauds*Tbaud, 0.5*Nbauds*Tbaud, float(Tbaud)/oversampling)
    cuadrado=[]
    y_vect = []
    for t in t_vect:
        
        if t==0:
            y_vect.append( (1-beta) + 4*beta/np.pi )
        elif t==1/(4*beta) or t==-1/(4*beta) :
            y_vect.append( beta/np.sqrt(2)*((1+2/np.pi)*np.sin(np.pi/(4*beta))+(1-2/np.pi)*np.cos(np.pi/(4*beta)))  )
        else:   
            numerador=np.sin( (np.pi*t/Tbaud)*(1-beta) ) + (4*beta*t/Tbaud)*np.cos( (np.pi*t/Tbaud)*(1+beta) ) 
            denominador= (np.pi*t/Tbaud)*(1-(4*beta*t/Tbaud)**2)
            y_vect.append( numerador/denominador )
            
    #----------    
    for indice in range (len(y_vect) ):
        cuadrado.append( y_vect[indice]*y_vect[indice] )
    #----------
    y_vect = np.array(y_vect)
    cuadrado = np.array(cuadrado)
    if(Norm):
        return  (  t_vect, y_vect/np.sqrt( cuadrado.sum() )  ) #Normalization to unit energy
    else:
        return (t_vect,y_vect)
#------------------------------------------------------------------------------    
def eyediagram(data, n, offset, period):
    span     = 2*n
    segments = int(len(data)/span)
    xmax     = (n-1)*period
    xmin     = -(n-1)*period
    x        = list(np.arange(-n,n,)*period)
    xoff     = offset

    plt.figure()
    for i in range(0,segments-1):
        plt.plot(x, data[int(i*span+xoff):int((i+1)*span+xoff)],'b')
        plt.hold(True)
        plt.grid(True)

    plt.xlim(xmin, xmax)
#------------------------------------------------------------------------------
def resp_freq(filt, Ts, Nfreqs):
    """Computo de la respuesta en frecuencia de cualquier filtro FIR"""
    H = [] # Lista de salida de la magnitud
    A = [] # Lista de salida de la fase
    filt_len = len(filt)
    #### Genero el vector de frecuencias
    freqs = np.matrix(np.linspace(0,1.0/(2.0*Ts),Nfreqs))
    #### Calculo cuantas muestras necesito para 20 ciclo de
    #### la m baja frec diferente de cero
    Lseq = 20.0/(freqs[0,1]*Ts)
    #### Genero el vector tiempo
    t = np.matrix(np.arange(0,Lseq))*Ts
    #### Genero la matriz de 2pifTn
    Omega = 2.0j*np.pi*(t.transpose()*freqs)
    #### Valuacin de la exponencial compleja en todo el
    #### rango de frecuencias
    fin = np.exp(Omega)
    #### Suma de convolucion con cada una de las exponenciales complejas
    for i in range(0,np.size(fin,1)):
        fout = np.convolve(np.squeeze(np.array(fin[:,i].transpose())),filt)
        mfout = abs(fout[filt_len:len(fout)-filt_len])
        afout = np.angle(fout[filt_len:len(fout)-filt_len])
        H.append(mfout.sum()/len(mfout))
        A.append(afout.sum()/len(afout))

    return [H,A,list(np.squeeze(np.array(freqs)))]
#------------------------------------------------------------------------------
    