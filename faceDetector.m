

I = imread("frames/adam1.jpg");

FDetect = vision.CascadeObjectDetector;

MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',100);
BB = step(MouthDetect,I);
BB2 = BB+[-20,-20,50,30];

% BB = step(FDetect,I);
% imshow(I); hold on
% 
% for i = 1:size(BB2,1)
%     rectangle('Position',BB2(i,:), 'LineWidth',1, 'LineStyle','-','EdgeColor','r');
% end
% 
% title('Mouth Detection');
% hold off;

imcrop(I,BB2);

numFrames = 108;

for j = 1:numFrames
    A = imread("frames/adam" + j + ".jpg" );
    B = imcrop(A,BB2);
    imwrite(B,"frames/croppedAdam" + j + ".jpg");
end 


