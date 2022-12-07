fs = 16000; % Sampling frequency
nBits = 16; % number of bits
nChannels = 1; % number of channels

[y,fs] = audioread("CWTraining\WAVS\Adam\Adam1.wav");

hWin = hamming(512);
frame = hWin .* y(16001:16512);
yF = fft(frame);
plot(yF);

magSpec_sym = abs(yF);
magSpec = magSpec_sym(1:256);

figure(1);
plot(magSpec);

n = 20;
k = 256;

f2m = @(x) 2595 .* log10(1 + (x./700));
m2f = @(x) 700 .* (10 .^ (x./2595) - 1);

lowHz = 0;
hiHz = fs/2;

lowMel = f2m(lowHz);
hiMel = f2m(hiHz);

x_mel = linspace(lowMel, hiMel, n + 2);
x_hz = m2f(x_mel);

for j = 1:n
    % set the up slope.
    for i = bin(j):bin(j+1)
         fbank(j, i) = (i - bin(j)) / (bin(j+1)-bin(j));
    end
    % set the down slope.
    for i = bin(j+1):bin(j+2)
         fbank(j, i) = (bin(j+2) - i) / (bin(j+2)-bin(j+1));
    end
end

figure(2);
for j = 1:n
plot(fbank(j, :));
title('N Triangle Filters')
hold on;
end
hold off;
