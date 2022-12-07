obj = VideoReader('newfile_130124_071222.avi');
vid = read(obj);

frames = obj.NumFrames;

STadam = 'adam';
ST = '.jpg';

for x = 1 :  frames
    Sx = num2str(x);

    Strc = strcat(STadam,Sx,ST);
    Vid = vid(:,:,:,x);
    cd frames

    imwrite(Vid, Strc);
    cd ..
end 

