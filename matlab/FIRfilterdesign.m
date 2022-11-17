clear;
out_file = fopen('./filter_coeff.results', 'w');

fs = 1e4;       % sampling rate of the design
ts = 1 / fs;    % sampling period
n = 63;         % order of FIR filter, 1 less than number of taps
Wn = 0.4;       % 10kS/s sampling rate of the design, Nyquist frequency = 5kHz,
                % a good cutoff at midrange level would be around 2kHz

w = flattopwin(n + 1, "symmetric");     % flat top weighted window for lowpass
b = fir1(n, Wn, "low", w, 'scale');     % create FIR filter with normalized coefficients

t = [0 : ts : ts * (n - 1)];            % time array containing n elements

% frequencies for test signal
f1 = 500;
f2 = 1000;
f3 = 1500;
f4 = 2000;
f5 = 2500;
f6 = 3000;
f7 = 3500;
f8 = 4000;
f9 = 4500;
f10 = 5000;

% test signal
x1 = sin(2 * pi * f1 * t);
x2 = sin(2 * pi * f2 * t);
x3 = sin(2 * pi * f3 * t);
x4 = sin(2 * pi * f4 * t);
x5 = sin(2 * pi * f5 * t);
x6 = sin(2 * pi * f6 * t);
x7 = sin(2 * pi * f7 * t);
x8 = sin(2 * pi * f8 * t);
x9 = sin(2 * pi * f9 * t);
x10 = sin(2 * pi * f10 * t);

x = x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9 + x10;        % test signal
y = filter(b, 1, x);                    % FIR filter driven by test signal

% draw input signal frequency response
subplot(1,2,1);
x_fft_mag = (abs(fft(x, n)));
x_fft_mag_h = x_fft_mag(1 : length(x_fft_mag) / 2);
f = [1 : 1 : length(x_fft_mag_h)] * fs / n;
plot(f, x_fft_mag_h);
xlabel("frequency (Hz)");
ylabel("Input spectrum");

% draw input signal frequency response
subplot(1,2,2);
y_fft_mag = (abs(fft(y, n)));
y_fft_mag_h = y_fft_mag(1: length(y_fft_mag) / 2);
plot(f, y_fft_mag_h);
xlabel("frequency (Hz)");
ylabel("Filtered Signal Spectrum");

% filter analyze tool
fvtool(b);

% output filter coefficient file
for i = 1 : n
    fprintf(out_file, "%d\n", b(i));
end

fclose(out_file);