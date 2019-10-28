import numpy as np
import commpy.filters as compyf  # Para confeccion de filtros
import scipy.special as sspe
import scipy.signal as ss
from matplotlib import pyplot as plt  # Para analisis grafico
import math  # erfc
from cmath import *
from decimal import Decimal  # Floating point arithmetic

'''
Generate Pseudo Random Binary sequences
@param: number of data to generate (bits)   (type: int)
@param: seed to use                         (type: list)
@return: generated PRBS                     (type: list)

'''
def generate_PRBS9(n_data, seed):

    shift_reg = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    for i in range(len(seed)):
        shift_reg[i] = seed[i]

    out = 0
    in_reg = 0

    PRBS = []

    # Sequence generation
    for element in range(n_data):
        # I
        out = shift_reg[0]
        in_reg = shift_reg[4] ^ shift_reg[0]
        shift_reg.pop(0)
        shift_reg.append(in_reg)
        PRBS.append(out)

    return PRBS



'''
BPSK mapper

@param: prbs or stream of bits to mapp      (type: list)
@return: generated symbols                  (type: list)

'''

def bpsk_mapper(prbs):
    symbols = []

    for i in range(len(prbs)):
        if (prbs[i]):
            symbols.append(int(-1))
        else:
            symbols.append(int(1))

    return symbols


'''
QPSK mapper


@param: prbs or stream of bits to mapp      (type: list)
@param: number of data/bits                 (type: int)
@return: generated symbols                  (type: list; dtype = complex)

'''

def qpsk_mapper(PRBS, n_bits):
    # QPSK Mapper

    m_ary = 2
    qpsk_symbols = []
    qpsk_mapper = {
        (0, 0): +1 + 1j,
        (0, 1): -1 + 1j,
        (1, 0): -1 - 1j,
        (1, 1): +1 - 1j
    }

    for m in range(0, n_bits, m_ary):
        pair = (PRBS[m], PRBS[m + 1])
        symbol = qpsk_mapper[pair]
        qpsk_symbols.append(symbol)

    return qpsk_symbols



'''
Configures plot for easy analysis

@param: baud rate                           (type: float)
@param: freq_line where carrier lies        (type: float)
@return: scaled variables                   (type: list)

'''

def plot_scale(fBaud, freq_line):

    scaled = []
    if (fBaud>=1e9):
      fbaud_for_plot        = fBaud /1e9
      scaled.append(fbaud_for_plot)
      carrier_freq_for_plot = freq_line/1e9
      scaled.append(carrier_freq_for_plot)
      unit_for_plot         = '[Ghz]'
      scaled.append(unit_for_plot)
    elif (fBaud>=1e6):
      fbaud_for_plot        = fBaud/1e6
      scaled.append(fbaud_for_plot)
      carrier_freq_for_plot = freq_line/1e6
      scaled.append(carrier_freq_for_plot)
      unit_for_plot         = '[Mhz]'
      scaled.append(unit_for_plot)
    else:
        scaled.append(fBaud)
        scaled.append(freq_line)
        scaled.append('[Hz]')


    return scaled



'''
Modulation by multiplying signal with complex exp

@param: signal   signal to modulate         (type:ndarray)
@param: carrier_freq  carrier frequency     (type: float)
@param: sample_rate  sample rate of signal  (type: float)
@return: modulated signal to carrier freq   (type: ndarray)

'''

def signal_modulation(mod_signal, carrier_freq, sample_rate):
    exp_freqs = np.array(np.arange(0, len(mod_signal)))
    # generate exponent values normalized with sample rate
    exp_freqs = exp_freqs * (carrier_freq /sample_rate) * 1j
    # array with complex exp.
    carrier_signal = np.exp(exp_freqs)

    out_mod = carrier_signal * mod_signal

    return out_mod



'''
Upsample symbols received with given os_factor

@param: symbols                             (type: list)
@param: upsampling factor                   (type: int/float)
@return: upsampled symbols                  (type: list)

'''

def upsample(symbols, os_factor):

    # List of zeros
    upsampled = [0]*(len(symbols)*os_factor)
    upsampled[::os_factor] = symbols

    return upsampled

def NormCrossCorrSlow(x1, x2, nlags=400):
    res=[]
    for i in range(-(nlags/2),nlags/2,1):
        if i<0:
            xx1=x1[:i]
            xx2=x2[-i:]
        elif i==0:
            xx1=x1
            xx2=x2

        else:
            xx1=x1[i:]
            xx2=x2[:-i]

    res.append( (xx1*xx2).sum() /( (xx1**2).sum() *(xx2**2).sum() )**0.5)
    return np.array(res)


'''
Calculates filter energy for given filter

@param: filter                              (type: ndarray)
@return: filter energy calculated           (type: float)

'''

def filter_energy(filter):

    filter_energy = 0
    # Energy adquisition
    for tap in filter:
        filter_energy = filter_energy+ (tap ** 2)

    return filter_energy


'''
Plot signals in one side of SCM system

@param: baseband1   signal 1                                (type:ndarray; dtype=complex)
@param: baseband2   signal 2                                (type:ndarray; dtype=complex)
@param: line1       shifted signal 1                        (type:ndarray; dtype=complex)
@param: line2       shifted signal 2                        (type:ndarray; dtype=complex)
@param: scmsignal   addition of both shifted signals        (type:ndarray; dtype=complex)
@param: Fs          sample rate                             (type:float)
@param: fb_plot     fbaud parameter for plot scale          (type:float)
@param: unit_plot   unit [Hz] [Mhz] [Ghz]                   (type:string)
@param: OS_factor   oversampling factor                     (type:float)
@param: beta        roll off factor                         (type:float)
@param: c_plot      carrier frequency                       (type:float)
@param: freq_line   for drawing axes frequency line         (type:float)
@param: archive_name  output archive pdf name               (type:string)

@param: filter                              (type: ndarray)
@return: filter energy calculated           (type: float)

'''
def plot_side_SCM(baseband1, baseband2, line1, line2, scmsignal, Fs, fb_plot, unit_plot, OS_factor, beta, c_plot, freq_line, archive_name):
    plt.subplot(4, 1, 1)
    plt.title('PSD[dB/Hz]   fBaud = %i %s  Oversampling = %i   roll off = %f   carrier frequency = %f %s' % (
    fb_plot, unit_plot, OS_factor, beta, c_plot, unit_plot), style='italic', horizontalalignment='center')
    plt.psd(baseband1, NFFT=8192, Fs=Fs, window=plt.mlab.window_hanning, sides='twosided', color='xkcd:plum')
    plt.psd(baseband2, NFFT=8192, Fs=Fs, window=plt.mlab.window_hanning, sides='twosided', color='xkcd:wheat')
    plt.ylabel('first line PSD')
    #
    plt.subplot(4, 1, 2)
    plt.axvline(freq_line, color='r')
    plt.axvline((freq_line * -1), color='r')
    plt.psd(line1, NFFT=8192, Fs=Fs, window=plt.mlab.window_hanning, sides='twosided', color='xkcd:plum')
    #
    plt.subplot(4, 1, 3)
    plt.axvline(freq_line, color='r')
    plt.axvline((freq_line * -1), color='r')
    plt.psd(line2, NFFT=8192, Fs=Fs, window=plt.mlab.window_hanning, sides='twosided', color='xkcd:wheat')
    plt.ylabel('Shifted signals')
    plt.xlabel(' ')

    plt.subplot(4, 1, 4)
    plt.axvline(freq_line, color='r')
    plt.axvline((freq_line * -1), color='r')
    plt.psd(scmsignal, NFFT=8192, Fs=Fs, window=plt.mlab.window_hanning, sides='twosided', color='b')
    plt.ylabel('SCM Tx signal')
    plt.xlabel(' frequency')




    #Save archive
    fig = plt.gcf()
    fig.set_size_inches(18.5, 10.5)
    fig.savefig(str(archive_name), dpi= 100)
    plt.show()


def plot_rxside_SCM(noisy_signal, baseband1, baseband2, filtered1, filtered2, ds_1, ds_2, Fs, fb_plot, unit_plot, OS_factor, beta, c_plot, freq_line, archive_name):

    plt.subplot(7, 1, 1)
    plt.title('PSD[dB/Hz]   fBaud = %i %s  Oversampling = %i   roll off = %f   carrier frequency = %f %s' % (
    fb_plot, unit_plot, OS_factor, beta, c_plot, unit_plot), style='italic', horizontalalignment='center')
    plt.psd(noisy_signal, NFFT=8192, Fs=Fs, window=plt.mlab.window_hanning, sides='twosided', color='xkcd:plum')
    plt.ylabel('Received signal with noise PSD')
    #
    plt.subplot(7, 1, 2)
    plt.axvline(freq_line, color='r')
    plt.axvline((freq_line * -1), color='r')
    plt.psd(baseband1, NFFT=8192, Fs=Fs, window=plt.mlab.window_hanning, sides='twosided', color='xkcd:plum')
    plt.ylabel('Shifted to baseband (L2)')
    plt.xlabel(' ')
    #
    plt.subplot(7, 1, 3)
    plt.axvline(freq_line, color='r')
    plt.axvline((freq_line * -1), color='r')
    plt.psd(baseband2, NFFT=8192, Fs=Fs, window=plt.mlab.window_hanning, sides='twosided', color='xkcd:wheat')
    plt.ylabel('Shifted to baseband (L2)')
    plt.xlabel(' ')

    plt.subplot(7, 1, 4)
    plt.axvline(freq_line, color='r')
    plt.axvline((freq_line * -1), color='r')
    plt.psd(filtered1, NFFT=8192, Fs=Fs, window=plt.mlab.window_hanning, sides='twosided', color='b')
    plt.ylabel('Filtered L1 signal')
    plt.xlabel(' ')

    plt.subplot(7, 1, 5)
    plt.axvline(freq_line, color='r')
    plt.axvline((freq_line * -1), color='r')
    plt.psd(filtered2, NFFT=8192, Fs=Fs, window=plt.mlab.window_hanning, sides='twosided', color='b')
    plt.ylabel('Filtered L2 signal')
    plt.xlabel(' ')

    plt.subplot(7, 1, 6)
    plt.axvline(freq_line, color='r')
    plt.axvline((freq_line * -1), color='r')
    plt.psd(ds_1, NFFT=8192, Fs=Fs, window=plt.mlab.window_hanning, sides='twosided', color='b')
    plt.ylabel('Downsampled L1 signal')
    plt.xlabel(' ')


    plt.subplot(7, 1, 7)
    plt.axvline(freq_line, color='r')
    plt.axvline((freq_line * -1), color='r')
    plt.psd(ds_2, NFFT=8192, Fs=Fs, window=plt.mlab.window_hanning, sides='twosided', color='b')
    plt.ylabel('Downsampled L2 signal')
    plt.xlabel(' ')

    # Save archive
    fig = plt.gcf()
    fig.set_size_inches(18.5, 10.5)
    fig.savefig(str(archive_name), dpi=100)
    plt.show()



'''
Plot signals in one side of SCM system

@param: sigma         sqrt(No/2)                           (type:float)
@param: len_noise_re  length of the noise real part        (type:int)
@param: len_noise_im  length of the noise imag part        (type:int)
@return: awgn_noise   AWGN generated noise                 (type:ndarray)

'''

def awgn_complex_generation(sigma, len_noise_re, len_noise_im):

    #vector with random values
    awgn_noise = (sigma * np.random.randn(1, len_noise_re) ) + ( sigma * 1j * np.random.rand(1,len_noise_im) )

    return awgn_noise



'''
AGC for the given signal

@param: gain     limit value                               (type:float)
@return: controled signal  signal with values changed      (type: ndarray)
'''


def gain_control(signal, gain_rd):

    gain = float(gain_rd)
    copy_signal = signal.copy()
    signal_re = copy_signal.real


    signal_re[signal_re > 2.0] = 2.0
    signal_re[signal_re < -2.0] = -2.0



    signal_controled = signal_re
    return signal_controled




'''

QPSK Symbol detection emulating slicer

@param: complex_symbols   symbols received                 (type:ndarray, dtype=complex)
@return: output slicer symbols (detected)                  (type:ndarray, dtype=complex)
'''

def qpsk_complex_slicer(complex_symbols):

    complex_symbols_re = complex_symbols.real
    complex_symbols_im = complex_symbols.imag
    symb_re            = []
    symb_im            = []

    for re in complex_symbols_re:

        if re >=0:
            symb_re.append(int(1))
        else:
            symb_re.append(int(-1))

    for im in complex_symbols_im:

        if im >=0:
            symb_im.append(int(1))
        else:
            symb_im.append(int(-1))

    symb_re = np.array(symb_re)
    symb_im = np.array(symb_im)
    symb_complex = symb_re + (1j*symb_im)


    return symb_complex



'''

QPSK Symbol to bit conversion 

@param: complex_symbols   symbols to convert               (type:ndarray, dtype=complex)
@return: bits converted                                    (type:list, dtype=int)
'''

def qpsk_bit_detection(symbols_to_convert):

    bits_detected = []

    #(0, 0):+1 + 1j,
    #(0, 1): -1 + 1j,
    #(1, 0): -1 - 1j,
    #(1, 1): +1 - 1j

    for symbol in symbols_to_convert:

        if symbol == (1 + 1j):
            bits_detected.append(int(0))
            bits_detected.append(int(0))

        elif (symbol ==( (-1)+ 1j) ):
            bits_detected.append(int(0))
            bits_detected.append(int(1))

        elif (symbol ==( (-1) - 1j) ):
            bits_detected.append(int(1))
            bits_detected.append(int(0))

        else:
            bits_detected.append(int(1))
            bits_detected.append(int(1))

    #print 'Bit detectados: '
    #print(bits_detected)

    return bits_detected

'''
Generates BER counter responding to detected bits and sent bits

@param detected         Slicer output bits
@param sent             bits intended to transmit

'''

def BER_control(detected, sent):

    ber_counter = 0
    if (type(detected[4]) != type(sent[4])):
        print "WARNING, DIFFERENT TYPES bit"
        print(type(detected[4]))
        print(type(sent[4]))

    for bit in range(len(detected)):

        if(detected[bit] != sent[bit]):
            ber_counter +=1
        else:
            ber_counter += 0

    return ber_counter

'''
Generates SER counter responding to detected bits and sent bits

@param detected         Slicer output bits
@param sent             bits intended to transmit

'''

def SER_control(detected, sent):

    ser_counter = 0

    #all(isinstance(n, int) for n in lst)
    if (type(detected[4]) != type(sent[4])):
        print "WARNING, DIFFERENT TYPES symb"
        print "WARNING, DIFFERENT TYPES bit"
        print(type(detected[4]))
        print(type(sent[4]))

    for symb in range(len(detected)):

        if (detected[symb] != sent[symb]):
            ser_counter += 1
        else:
            ser_counter += 0

    return ser_counter


'''
Generates one line of QPSK modulation. 

@param  PRBS    bits to transmit
@param  carrier_freq            carrier frequency for modulation
@param  tx_filter               tx filter to use
@param  os_factor               upsampling factor
@param  sample_rate             signal sample rate

'''

def tx_phase_quadrature(PRBS, carrier_freq, tx_filter, os_factor, sample_rate):


    symbols_i = [0] * (len(PRBS)/2)
    symbols_q = [0] * (len(PRBS)/2)


    us_symb_i = [0] * (len(symbols_i)*os_factor)
    us_symb_q = [0] * (len(symbols_q) * os_factor)



    itri = 0
    itrq = 0
    # Mapper
    for biti in range(0,len(PRBS)-1,2):

        if(PRBS[biti] ==0 ):
            symbols_i[itri] = 1
        else:
            symbols_i[itri] = -1

        itri+=1

    for bitq in range (1, len(PRBS),2):

        # 1 0 1 0 1 0
        if (PRBS[bitq] == 0):
            symbols_q[itrq] = 1
        else:
            symbols_q[itrq] = -1

        itrq +=1

    # print("PRBS ENVIADA:\n")
    # print("longitud: ", len(PRBS))
    # print(PRBS)
    # print("Se genero: \n")
    # print("I:  ", symbols_i)
    # print(len(symbols_i))
    # print(len(symbols_q))
    # print("Q:  ", symbols_q)

    #Upsample
    us_symb_i[::os_factor] = symbols_i
    us_symb_q[::os_factor] = symbols_q

    #Filtering
    s_i = np.convolve(us_symb_i, tx_filter)
    s_q = np.convolve(us_symb_q, tx_filter)

    #Modulation
    #Carrier generations
    exp_freqs1 = np.arange(0, len(s_i))
    exp_freqs1 =  exp_freqs1 * (carrier_freq/sample_rate)

    exp_freqs2 = np.arange(0,len(s_q))
    exp_freqs2 = exp_freqs2 * (carrier_freq/sample_rate)
    cos_i      = (math.sqrt(2))*(np.cos(exp_freqs1))
    sin_q      = (math.sqrt(2))*(np.sin(exp_freqs2))

    #I and Q signals
    passband_i = s_i* cos_i
    passband_q = s_q * sin_q

    #QPSK sum
    qpsk_phase_quadrature = passband_i - passband_q

    return qpsk_phase_quadrature

'''

DQPSK codification 

@param: complex symbols   symbols to code with DQPSK       (type:ndarray, dtype=complex)
@return: tx_data with DQPSK codification                   (type:list, dtype=int)
'''

def DQPSK(symbols):

    tx_data = []
    fi      = 0

    for ptr in range(len(symbols)):
        fi=fi+np.angle(symbols[ptr])
        tx_data.append(np.exp(1j*fi))


    return tx_data






































