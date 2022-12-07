function [fbank] = linearRectangularFilterBank(magSpec,nChannels)
%LINEARRECTANGULARFILTERBANK Summary of this function goes here
%   Detailed explanation goes here

start = 1;
fin = 32; 
for i = 1:nChannels
    
    fbank = sum(magSpec(start:fin));
    start = start + 32;
    fin = fin + 32;

end

