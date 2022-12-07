fs = 16000; % Sampling frequency
nBits = 16; % number of bits
nChannels = 1; % number of channels

[y,fs] = audioread("speech.wav");


t = 1/fs: 1/fs: length(y)/fs; % Plot time in seconds

figure;
plot(t,y); % Plot with time in seconds
xlabel('Time: seconds'); % Add seconds label to x-axis
ylabel('Amplitude') % Add aplitude label to y-axis
title('Time domain signal'); 


% Create a single frame of speech 




hwin = hamming(512);  % Hamming window
frame = hwin.*y(1001:1512);
yf = fft(frame); % Fast-fourier transform
magSpec_sym = abs(yf); % Magnitude spectrum symetrical
magSpec = magSpec_sym(1:256); % Just the left side of magnitude spectrum

figure;
plot(magSpec);
xlabel('Samples');
ylabel('Amplitude');
title('Magnitude spectrum');


% n filters
n = 20;
% k frequency coefficients 
k = 256;

f2m = @(x) 2595 .* log10(1 + (x./700));
m2f = @(x) 700 .* (10 .^ (x./2595) - 1);

lowHz = 0;
hiHz = fs/2;

% convert the freq in Hz to MEL.
lowMel = f2m(lowHz);
hiMel = f2m(hiHz);

% In the mel scale, create n spaced scale
x_mel = linspace(lowMel, hiMel, n + 2);
x_hz = m2f(x_mel);

%  Set up the filter bank
fbank = zeros(n, k);
bin = floor(1 + k * x_hz / hiHz);
bin(n + 2) = k;

for j = 1:n
%     Set up the triangles up slope
    for i = bin(j):bin(j+1)
        fbank(j,i) = (i-bin(j))/(bin(j+1)-bin(j));
    end 
%     Set up the down slope
    for i = bin(j+1):bin(j+2)
        fbank(j,i) = (bin(j+2)-i)/(bin(j+2)-bin(j+1));
    end 
end

%% Plot filter bank

figure;
for j = 1:n
    plot(fbank(j,:));
    title('N triangle filters')
    hold on;
end 
hold off;

%% Apply the filter bank

filtered = fbank * magSpec;
figure;
plot(filtered);
title('Filter applied to Mag Spec')
hold on;
plot(magSpec);
hold off;



