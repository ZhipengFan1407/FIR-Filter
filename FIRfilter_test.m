load("coefficient.mat");
filenamex = 'input.results';
filenamey = 'output.results';
input_file = fopen(filenamex, "w");
output_file = fopen(filenamey, "w");
fs=10000;
t = 0 : 1/fs : 1-1/fs;
d_in = (1.7)*sin(2*pi*1000*t) ...
  + (1.5)*sin(2*pi*3000*t) ...
  + (1.3)*sin(2*pi*4000*t) + 5*randn(size(t));
for i = 1 : length(d_in)
    bit_rep_d_in = bin(fi(d_in(i), 1, 16, 9));
    fwrite(input_file, bit_rep_d_in);
    fwrite(input_file, newline);
end
f_d_in = fft(d_in);
f_d_in = fftshift(f_d_in);
n = length(d_in);
f = (0 : n-1) * (fs/n);
subplot(1,2,1);
power = abs(f_d_in).^2/n;
plot(f, power);
subplot(1,2,2);
result = filter(b, 1, d_in);
fwrite(output_file, result);
f_result = fft(result);
f_result = fftshift(f_result);
result_pow = abs(f_result).^2/n;
plot(f, result_pow);
