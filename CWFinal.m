

fs = 16000;
[y,fs] = audioread('CWTraining\WAVS\Adam\Adam2.wav');

framesize = 1600;
hop = 800;
numFrames = fs*2/framesize;

fileName = 'Adam2.mfc';
numVectors = 20;
numDimms = 12;
vectorPeriod = 2000;
parmKind = 6;

% figure(1);
% t = 1/fs: 1/fs: length(y)/fs; % Plot time in seconds
% plot(t,y);
% xlabel('Time: seconds'); % Add seconds label to x-axis
% ylabel('Amplitude') % Add aplitude label to y-axis
% title("Original Signal");

frameStart = 1;
mfccStart = 1;
mfcc = zeros(numVectors,numDimms);

hann_window = hann(framesize);



% for fileNo = 1:length(file)
    for frameNumber = 1:numFrames

        x = frameStart:frameStart+framesize-1;
        frameStart = frameNumber * hop + 1;
        frame = y(x);
        frame = hann_window .* frame;



    %     figure(2);
    %     plot(frame);
    
        
    %     figure(3);
    %     plot(hann_window);
    
        yf = fft(frame);
        magSpec_sym = abs(yf);
        magSpec = magSpec_sym(1:framesize/2);
        figure(4);
        plot(magSpec);
    
        % n filters
        n = 20; 
        % k frequency coefficients
        k = 256;
        
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
      
        fbank = zeros(n, k);
        bin = floor(1 + k * x_hz / hiHz);
        bin(n + 2) = k;
        
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
     

    %% Plot the filter banks
    
%     figure(1);
%     for j = 1:n
%     plot(fbank(j, :));
%     title('N Triangle Filters')
%     hold on;
%     end
%     hold off;

    %% Apply the filterbank
    filtered = fbank .* magSpec;
    figure(2);
    
    plot(filtered);
    title('Filter applied to MagSpec')

    % Log of gain + filtered 
    gain = 1;
    filterBankApplication = log(gain) + log(filtered);
    figure(6);
    plot(filterBankApplication);
    title('Log of filtered')

    % Apply Descrete cosine transform 
    dctApplied = dct(log(abs(filterBankApplication)));
    figure(7);
    plot(dctApplied);
    title('DCT')

    % Truncate the DCT 
    fv = dctApplied(1:12);
    figure(8);
    plot(fv);
    title('Truncated')
    

%     [coeffs, delta, deltaDelta, loc] = mfcc(y,fs);
%     mfcc(y,fs);

    frameStart = frameStart + hop;
    frameEnd = frameEnd + hop;
   
    mfccStart = mfccStart + 1;

    disp(frameNumber);

    fv_rot = rot90(fv);

    
    NewCol = mfcc(numDimms,numVectors);
    mfcc = mfcc(Arr:NewCol);
    
    disp(fv_rot);


    

    
    end 
% end

% for i = columns:10
% %   Arr(:,columns) = [];
%     NewCol = rand(12,columns);
%     Arr = [Arr NewCol];
%     disp(Arr);
% end 

%   Open file for writing 
fid = fopen(fileName, 'w', 'ieee-be');

%   Write the header information 
fwrite(fid, numVectors, 'int32');
fwrite(fid, vectorPeriod, 'int32');
fwrite(fid, numDimms * 4, 'int16');
fwrite(fid, parmKind, 'int16');

%   Write the data: one coefficient at a time:  
for v = 1:numVectors
    for w = 1:numDimms
        fwrite(fid, fv(v,w), 'float32');
    end 
end 

disp(mfcc);
