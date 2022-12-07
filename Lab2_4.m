numSamples = length('speech1.wav');
frameLength = 320;
numFrames = floor(numSamples/frameLength);

for frame  = 1:numFrames
    firstSample = numFrames(1);
    lastSample = numFrames(320);
    shortTimeFrame = speechFile(firstSample:lastSample);
    [magSpec, phaseSpec]  = magAndPhase(shortTimeFrame);
    plot(magSpec);
    plot(phaseSpec);
end 

    
