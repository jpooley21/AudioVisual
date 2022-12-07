

%% Record Video records a Video from the Windows webcam and saves two AVI files
% newfile_xxx.avi
%           video file with frame rate provided by the webcam and system
% AcutalFR_xxx.avi
%           Video file with adjusted frame rate (realtime)
%           Frame Rate depends on system and memory

function RecordVideo()
%% Construct a video input object
vobj = videoinput('winvideo', 1);

%% Get Info about Source and Hardware
% source = getselectedsource(vobj);
% source.FrameRate
% You can use the SupportedFormats to specify the 'format' of the
% videoinput object above
% info = imaqhwinfo('winvideo')
% info.DeviceInfo.SupportedFormats

%% Set Properties for Videoinput Object
vobj.TimeOut = Inf;
vobj.FrameGrabInterval = 1;
vobj.LoggingMode = 'disk&memory';
vobj.FramesPerTrigger = 2;
vobj.TriggerRepeat = Inf;

%% Construct VideoWriter object and set Disk Logger Property
timenow = datestr(now,'hhMMss_ddmmyy');
v = VideoWriter(['newfile_', timenow,'.avi']);
v.Quality = 50;
v.FrameRate = 30;
vobj.DiskLogger = v;

% Select the source to use for acquisition.
vobj.SelectedSourceName = 'input1';

%% Preview a stream of image frames.
% Create a customized GUI.
f = figure('Name', 'Video Recording Preview');
uicontrol('String', 'Rec Stop', 'Callback', 'close(gcf)');

% Create an image object for previewing.
vidRes = vobj.VideoResolution;
nBands = vobj.NumberOfBands;
hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
preview(vobj, hImage);
tic
start(vobj)

% Continue recording until figure gets closed
uiwait(f)

%% Stop video
stop(vobj)

% Compute actual Frame Rate
elapsedTime = toc;
framesaq = vobj.FramesAcquired;
ActualFR = framesaq/elapsedTime;

% Delete Object
delete(vobj);

%% Change the Frame Rate to Orinial Value and save it to new video file
% with the same timestamp

end


