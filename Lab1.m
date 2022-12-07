fs = 16000; % Sampling frequency
nBits = 16; % number of bits
nChannels = 1; % number of channels

r = audiorecorder(fs, nBits, nChannels);

disp('Start recording');
recDuration = 5; % Duration of recording in seconds
recordblocking(r, recDuration); % Record audio from input device
disp('End recording');

% play(r);

x = getaudiodata(r, 'double'); % Get the audio signal as a numeric array 
soundsc(x,fs); % Scale data and play as sound
% plot(x);  % Plot data on graph


% Time domain 
t = 1/fs: 1/fs: length(x)/fs; % Plot time in seconds
plot( t, x ); % Plot with time in seconds (blue line)
xlabel('Time: seconds'); % Add seconds label to x-axis
ylabel('Amplitude') % Add aplitude label to y-axis

% Normalisation  
xNorm = 0.99 * x / max(abs(x));
hold on
plot(t, xNorm); % plot normalised data (red line)
hold off

audiowrite('speech1.wav', xNorm, fs); % Write data to .wav file 

% Spectrogram 
% spectrogram(x, 512, 400, 512, fs, 'yaxis');  % Narrowband spectrogram
% spectrogram(x, 64, 40, 512, 16000, 'yaxis'); % Wideband spectrogram


