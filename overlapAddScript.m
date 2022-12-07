%% Using audio file from lab.
fs = 16000;
[y,fs] = audioread("CWTraining\WAVS\Tan\Tan9.wav");

framesize = 3200;
hop = 1600;
output = zeros(size(y));
hann_window = hann(framesize);



figure(1);
t = 1/fs: 1/fs: length(y)/fs; % Plot time in seconds
plot(t,y);
xlabel('Time: seconds'); % Add seconds label to x-axis
ylabel('Amplitude') % Add aplitude label to y-axis
title("Original Signal");

figure(2);

start = 1;
for i = 1:19 % just process 10 frames to illustrate...
    x = start:start+framesize-1;
    start = i * hop + 1;
    frame = y(x);
    frame = hann_window .* frame;
    
%     Time domain 
    figure(3);  
    plot(x, frame);
    
    hold on;
    % this is overlap and add here..
    output(x) = output(x) + frame;
end

title("Framed Signal");

hold off;


start = 1;
for i = 1:19
    x = start:start+framesize-1;
    start = i * hop + 1;
    frame = y(x);
    
    frame = hann_window .* frame;

    yf = fft(frame);
    f_sym = (0:length(yf)-1)*fs/length(yf);
    f = f_sym(1:1600);
    magSpec_sym = abs(yf);
    magSpec = magSpec_sym(1:fs/10);
    %     Combined magnitude spec of all frames

    figure(4); 
    plot(f,magSpec);

    hold on;

    output(x) = output(x) + frame;
end

title('Magnitude Spectrum');
hold off

figure(5);
plot(output(1:32000));
title("Combined Frames");
