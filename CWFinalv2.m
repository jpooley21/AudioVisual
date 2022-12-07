fs = 16000;
% [y,fs] = audioread("CWTraining\WAVS\Adam\Adam3.wav");

% Adam, Agne, Bradley, Cameron, Darcey, Dylan, Georgiana,
% Jack, James, Jonathon, Jordan, Liam, Max, Mikhayla, Rob,
% Shaun, Sophie, Tan, Teodora, Tom


framesize = 320;
hop = framesize/2;

hann_window = hann(framesize);
numFrames = fs*2/framesize*2;

% figure(1);
% t = 1/fs: 1/fs: length(y)/fs; % Plot time in seconds
% plot(t,y);
% xlabel('Time: seconds'); % Add seconds label to x-axis
% ylabel('Amplitude') % Add aplitude label to y-axis
% title("Original Signal");
numDimms = 12;
features = zeros(numFrames,numDimms);


names = {'Adam','Agne', 'Bradley', 'Cameron', 'Darcey', 'Dylan', 'Georgiana', 'Jack', 'James', 'Jonathan', 'Jordan', 'Liam', 'Max', 'Mikhayla', 'Rob', 'Shaun', 'Sophie', 'Tan', 'Teodora', 'Tom' };
for str = names

for fileNumber = 1:10
    [y,fs] = audioread(string(str)  + fileNumber + ".wav");
    output = zeros(size(y));
    
%     win = hann(320, 'periodic');
%     S = stft(y, "Window",win,"OverlapLength",160,"Centered",false);
% 
%     coeffs = mfcc(S,fs,"LogEnergy","Ignore");
%     nbins = 20;
%     coefficientToAnalyze = 5;
%     title(sprintf("Coefficient %d",coefficientToAnalyze));
%     disp(coeffs);

start = 1;

for frameNumber = 1:numFrames-1
    x = start:start+framesize-1;
    start = frameNumber * hop + 1;
    frame = y(x);
    frame = hann_window .* frame;


    yf = fft(frame);
    magSpec_sym = abs(yf);
    magSpec = magSpec_sym(1:framesize/2);

%    figure(4);
%    plot(magSpec);

   n = 20; % n filters
   k = 160; % frequency coefficients

   % Inline conversion functions
   f2m = @(x) 2595 .* log10(1 + (x./700));
   m2f = @(x) 700 .* (10 .^ (x./2595) - 1);
    
   % the frequency range of the magspec frame
   lowHz = 0;
   hiHz = fs/2;
    
   % convert the freq in Hz to MEL.
   lowMel = f2m(lowHz);
   hiMel = f2m(hiHz);
    
   % now in mel scale, create n spaced scale (+ 2 for the last mid and end point).
   x_mel = linspace(lowMel, hiMel, n + 2);
   x_hz = m2f(x_mel);

   fbank = zeros(n,k);
   bin = floor(1+k*x_hz/hiHz);
   bin(n+2) = k;

   for j = 1:n
            % set the up slope.
            for i = bin(j):bin(j+1)
                 fbank(j, i) = (i - bin(j)) / (bin(j+1)-bin(j));
            end
            % set the down slope.
            for i = bin(j+1):bin(j+2)
                 fbank(j, i) = (bin(j+2) - i) / (bin(j+2)-bin(j+1));
            end
   end

   %% Show the filterbank 
%     figure(5);
%     for j = 1:n
%         plot(fbank(j, :));
%         title('N Triangle Filters')
%         hold on;
%     end
%     hold off;

    %% Apply the filterbank
    
    filtered = fbank * magSpec;
    
%     figure(6);
%     plot(filtered);
%     title('FIlter applied to magSpec');

    %% Log of gain + filtered

%     gain = 1;
%     filteredBankApplication = log(gain) + log(filtered);
%     figure(7);
%     plot(filteredBankApplication);
%     title('Log of filtered');

    %% Apply descrete cosine transform (DCT)

    dctApplied = dct(log(abs(filtered)));
%     figure(8);
%     plot(dctApplied);
%     title('DCT');

    %% Truncate the DCT
    features(frameNumber,:) = dctApplied(1:12);
%     figure(9);
%     plot(fv);
%     title('Truncated');

  disp(str);
  

    
end


fileName = string(str) + fileNumber + ".mfc";

numVectors = 199;
%% 
% numDimms = 12;
vectorPeriod = 100000;
parmKind = 6;

fid = fopen(fileName, 'w', 'ieee-be');

%   Write the header information 
fwrite(fid, numVectors, 'int32');
fwrite(fid, vectorPeriod, 'int32');
fwrite(fid, numDimms * 4, 'int16');
fwrite(fid, parmKind, 'int16');

%   Write the data: one coefficient at a time:  
for v = 1:numVectors
    for w = 1:numDimms
        fwrite(fid, features(v,w), 'float32');
    end 
end 

end

end 

writeProtoFile('proto2States.txt',2,12);
writeProtoFile('proto4States.txt',4,12);
writeProtoFile('proto8States.txt',8,12);
writeProtoFile('proto16States.txt',16,12);
writeProtoFile('proto32States.txt',32,12);


