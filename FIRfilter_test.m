load("coefficient.mat");
fs=10000;
t = 0 : 1/fs : 10-1/fs;
d_in = (1.7)*sin(2*pi*1000*t) ...
  + (1.5)*sin(2*pi*3000*t) ...
  + (1.3)*sin(2*pi*4000*t) + 50*randn(size(t));
f_d_in = fft(d_in);
f_d_in = fftshift(f_d_in);
n = length(d_in);
f = (0 : n-1) * (fs/n);
subplot(1,2,1);
power = abs(f_d_in).^2/n;
plot(f, power);
subplot(1,2,2);
result = filter(b, 1, d_in);
f_result = fft(result);
f_result = fftshift(f_result);
result_pow = abs(f_result).^2/n;
plot(f, result_pow);