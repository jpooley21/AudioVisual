% clear;
% 
% a  = imread('cameraman.tif');
% figure(1);
% imshow(a);
% 
% k = ones(3)/9;
% 
% b = double(padarray(a,[1,1]));
% disp(b);
% 
% output = zeros([size(a,1) size(a,2)]);
% 
% 
% for i = 1:size(b,1)-2
%     for j = 1:size(b,2)-2
%         Temp = b(i:i+2,j:j+2).*k;
%         output(i,j) = sum(Temp(:));
%     end 
% end 
% 
% norm = output/255;
% figure(2);
% imshow(norm);
% disp(norm);


linearFilter('cameraman.tif',5);
