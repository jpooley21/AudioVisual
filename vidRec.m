% vobj = videoinput("winvideo","2");
% 
% vobj.TimeOut = 2;
% vobj.FrameGrabInterval = 1;
% vobj.LoggingMode = 'disk&memory';
% vobj.FramesPerTrigger = 120;
% vobj.TriggerRepeat = 2;
% 
% v = VideoWriter('NewFile1.avi');
% v.Quality = 50;
% v.FrameRate = 30;
% vobj.DiskLogger = v;
% 
% vobj.SelectedSourceName = 'input1';
% 
% vidRes = vobj.VideoResolution;
% nBands = vobj.NumberOfBands;
% hImage = image(zeros(vidRes(2),vidRes(1),nBands));
% preview(vobj,hImage);
% 
% start(vobj);
% 
% pause(4);
% 
% stop(vobj);







% clear;
% clc; 
% 
% vid1 = videoinput('winvideo',1,'YUY2_1280x720');
% set(vid1, 'FramesPerTrigger',Inf);
% set(vid1, 'ReturnedColorspace', 'rgb');
% vid1.FrameGrabInterval = 1;
% 
% 
% src1 = getselectedsource(vid1);
% frameRates = set(src1, 'FrameRate');
% fps = frameRates{1};
% src1.FrameRate = fps;
% 
% myVideo1 = VideoWriter('cam1.avi');
% myVideo1.FrameRate = str2double(fps);
% 
% open(myVideo1);
% start(vid1);
% totalFrames = 120;
% 
% while(vid1.FramesAcquired<=totalFrames)
%     img1 = getsnapshot(vid1);
%     writeVideo(myVideo1, img1);
% end
% 
% close(myVideo1);
% 
% stop(vid1);
% flushdata(vid1);
% delete(vid1);

vid = videoinput('winvideo',2,'YUY2_640x480');

set(vid,'TimerPeriod',1);
vwObj = VideoWriter('timelapsevideo','Uncompressed AVI');
vwObj.FrameRate = 15;
open(vwObj);

triggerconfig(vid,'manual');
vid.FramesPerTrigger = 1;
vid.TriggerRepeat = 9;
vid;

start(vid);
wait(vid,2);

avi = vid.UserData;
avi = close(avi);




