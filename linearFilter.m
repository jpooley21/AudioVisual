function [filteredImage] = linearFilter(image,kernalSize)


kernal = ones(kernalSize)/(kernalSize*kernalSize);

a = imread(image);
figure(1);
imshow(a);


b = double(padarray(a,[1,1]));
disp(b);

output = zeros([size(a,1) size(a,2)]);

kA = kernalSize-1;


for i = 1:size(b,1)-kA
    for j = 1:size(b,2)-kA
        Temp = b(i:i+kA,j:j+kA).*kernal;
        output(i,j) = sum(Temp(:));
    end 
end 

filteredImage = output/255;
figure(2);
imshow(filteredImage);

end

