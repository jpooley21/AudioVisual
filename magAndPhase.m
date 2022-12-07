function [shortTimeMag,shortTimePhase] = magAndPhase(speechFrame)

h = hamming(length(speechFrame)); % Hamming window
hf = h.*speechFrame; 
f = fft(hf);

shortTimeMag = abs(f);
shortTimePhase = angle(f);


end
