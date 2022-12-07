fs = 16000; % Sampling frequency
nBits = 16; % number of bits
nChannels = 1; % number of channels

r = audiorecorder(fs, nBits, nChannels);

disp('Start recording');
recDuration = 2; % Duration of recording in seconds
recordblocking(r, recDuration); % Record audio from input device
disp('End recording');

% play(r);

x = getaudiodata(r, 'double'); % Get the audio signal as a numeric array 
soundsc(x,fs); % Scale data and play as sound


