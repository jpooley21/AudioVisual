
% 320 sample sinusoid with 10 cycles
for n = 1:3200
    x(n) = sin(2*pi*100*n/3200);
end


xF = fft(x); % Fast Fourier transform

magSpec = abs(xF); % Magnitude Spectra
phaseSpec = angle(xF); % Phase Spectra

fs = 16000; % Frequency 
f = fs/3200:fs/3200:fs; 

soundsc(x ,fs);
plot(magSpec);


