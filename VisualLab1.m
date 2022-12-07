% X  = imread('cameraman.tif');
% % whos
% 
% imshow(X);
% imtool(X);
% 
% C = X;
% C(:,:,2) = C;
% C(:,:,3) = C(:,:,1);
% whos
% 
% Y=C;
% Y(:,:,1) = uint8(0.5*double(C(:,:,1))); %Red plane
% imshow(Y);
% 
% Xd = double(X)/255;
% whos
% imshow(Xd);
% 
% L = (X > 100);
% imshow(L)
% 
% clear
% X = imread('coins.png');
% figure
% imshow(X)
% figure
% imhist(X)

% v = VideoReader('xylophone.mp4');
% vidHeight = v.Height;
% vidWidth = v.Width;
% s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
% 
% mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
% 
% k = 1;
% while hasFrame(v)
%     mov(k).cdata = readFrame(v);
%     k = k+1;
% end
% 
% hf = figure;
% set(hf,'position',[150 150 vidWidth vidHeight]);
% movie(hf,mov,1,v.FrameRate);
% 
% P = roipoly(mov(1).cdata);
% ptr = find(P);
% 
% M1 = double(mov(1).cdata);
% R = M1(:,:,1);
% G = M1(:,:,2);
% B = M1(:,:,3);
% 
% D = sqrt((M1(:,:,1)-cm(1)).^2 + (M1(:,:,2) - cm(2)).^2 + (M1(:,:,3)-cm(3)).^2);
% 
% imshow(D<std(D(:)));
% 

%X = imread('cameraman.tif');
%whos
%imfinfo('cameraman.tif')
%
% imshow(X);
% C = X;
% C(:,:,2) = C;
% C(:,:,3) = C(:,:,1);
% whos;
% imshow(C);
% Y = C;
% Y(:,:,1) = uint8( 0*double( C(:,:,3) ) );
% imshow(Y)
% Xd = double(X)/255;
% whos
% imshow(Xd);
% L = (X > 100);
% imshow(L)
%who(Y)
%is this what was expected for Practice to make sure who can
% covert between double and uint8 images
%  (note they have different maximal values corresponding to white).
%Conversion between double nad uint8
% f = imread('C:\Users\Administrator\Desktop\2.tif');
% h = mat2gray(h);
% imshow(h)
% % whereas, this other code snippet results a uint8 image.
% 
%  f = imread('coins.png');
% % figure;
% % imshow(f);
% % 
% % 
% % 
% % 
% % clear
% thresh = 100;
% X = imread('coins.png');
% L = (X > thresh);
% figure
% imshow(L);
% figure
% imhist(L)
% Z = bwlabel(L);
% 
% %this labels the items as black and white and marks the circle outline 
% stats = regionprops('table',L,'Centroid','MajorAxisLength','MinorAxisLength');
% 
% centers = stats.Centroid;
% diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
% radii = diameters/2;
% 
% hold on
% viscircles(centers,radii);
% hold off


v = VideoReader('newfile_112612_071222.avi');
vidHeight = v.Height;
vidWidth = v.Width;
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);


mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
k = 1;


while hasFrame(v)
mov(k).cdata = readFrame(v);
k = k+1;
end

hf = figure;
set(hf,'position',[150 150 vidWidth vidHeight]);
movie(hf,mov,1,v.FrameRate);




%finds the position of it 
P = roipoly(mov(100).cdata);
ptr = find(P); 

M1 = double(mov(100).cdata);
R = M1(:,:,1);
G = M1(:,:,2);
B = M1(:,:,3);

cm = [mean(R(ptr)); mean(G(ptr)); (mean(B(ptr)))];

D = sqrt((M1(:,:,1) - cm(1)).^2 + (M1(:,:,2) - cm(2)).^2 + (M1(:,:,3) - cm(3)).^2);
imshow(D < std(D(:)))

% [E,thresh] = edge(rgb2gray(M1/255),'canny');
% imshow(E)
% 
% 
% %edge detection 
% X = imread('cameraman.tif');
% corners = detectHarrisFeatures(X);
% imshow(X)
% hold on
% plot(corners.selectStrongest(50));
% % 
% 
% points = detectSURFFeatures(X);
%  strongest = points.selectStrongest(10);
%     imshow(X); hold on;
%     plot(strongest);
%  
% %     for the 10strongest points in cmd 
%     strongest.Location





