fs = 16000; % Sampling frequency
nBits = 16; % number of bits
nChannels = 1; % number of channels

[y,fs] = audioread("CWTraining/WAVS/Adam/Adam1.wav");


t = 1/fs: 1/fs: length(y)/fs; % Plot time in seconds

figure;
plot(t,y); % Plot with time in seconds
xlabel('Time: seconds'); % Add seconds label to x-axis
ylabel('Amplitude') % Add aplitude label to y-axis
title('Time domain signal'); 

yf = fft(y);

f_sym = (0:length(yf)-1)*fs/length(yf);
f = f_sym(1:16000);

magSpec_sym = abs(yf);
magSpec = magSpec_sym(1:fs);
plot(f,magSpec);
xlabel('Frequency Hz');
ylabel('Magnitude');

