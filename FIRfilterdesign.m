n = 63;         % order of FIR filter, 1 less than number of taps
Wn = 0.4;       % 10kS/s sampling rate of the design, Nyquist frequency = 5kHz,
                % a good cutoff at midrange level would be around 2kHz
w = flattopwin(n + 1, "symmetric");     % flat top weighted window for lowpass
b = fir1(n, Wn, "low", w, 'scale');     % create FIR filter with normalized coefficients
fvtool(b);      % display frequency response
                % observed filter -3dB frequency is at around 1.75kHz, acceptable