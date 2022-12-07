%% Using audio file from lab.

[y,fs] = audioread('speech.wav');

framesize = 320;
hop = 160;
output = zeros(size(y));
hann_window = hann(framesize);

figure(1);
plot(y(1:1600));
title("Original Signal");

figure(2);

start = 1;
for i = 1:10 % just process 10 frames to illustrate...
    x = start:start+framesize-1;
    start = i * hop + 1;
    frame = y(x);
    frame = hann_window .* frame;
    % ... other processing ...
    plot(x, frame);
    hold on;
    % this is overlap and add here...
    output(x) = output(x) + frame;
end

title("Framed Signal");
hold off;

figure(3);
plot(output(1:1600));
title("Combined Frames");
