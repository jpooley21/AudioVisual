fs = 16000; % Sampling frequency
nBits = 16; % number of bits
nChannels = 1; % number of channels

% Adam, Agne, Bradley, Cameron, Darcey, Dylan, Georgiana,
% Jack, James, Jonathan, Jordan, Liam, Max, Mikhayla, Rob,
% Shaun, Sophie, Tan, Teodora, Tom

r = audiorecorder(fs, nBits, nChannels);

for fileNumber = 1:10
    disp(fileNumber);
    disp('Start recording');
    recDuration = 2;
    recordblocking(r, recDuration);
    disp('End recording');

    x = getaudiodata(r, 'double');
    

    xNorm = 0.99 * x / max(abs(x));

    audiowrite("Tom" + fileNumber + ".wav", xNorm, fs);
end 