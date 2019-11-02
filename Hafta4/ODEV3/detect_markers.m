
%Student Dave's tutorial on:  Finding flies! lol :P
%this code uses blob analysis to find 
%Copyright Student Dave's Tutorials 2013
%if you would like to use this code, please feel free, just remember to
%reference and tell your friends! :)
%requires matlabs image processing toolbox

%you can get the fly footage here!  (notably, the free version is pretty low quality so
%tracking will have some issues ..you gotta tweaky it :-/
%http://footage.shutterstock.com/clip-978808-stock-footage-swarm-of-flies-buzzing-with-matte-for-easy-compositing-into-your-own-scenes.html

%What the heck does this code do!?
%the code tries to find the flies..but not just when they are very visual,
%but even when the are partially overlapping..how?!
% 1) Averaged background subtraction
% 2) Noise reduction via image smoothing using 2-d gaussian filter.
% 3) Threshold and point detection in binary image.



%% get listing of frames so that you can cycle through them easily.



%% initialize gaussian filter

%using fspecial, we will make a laplacian of a gaussian (LOG) template to convolve (pass over)
%over the image to find blobs!

hsizeh = 30  %you will need to iterative test these values two values. the bigger they are, the larger the blob they will find!
sigmah = 6   %
h = fspecial('log', hsizeh, sigmah)
subplot(121); imagesc(h)
subplot(122); mesh(h)
colormap(jet)


%% iteratively (frame by frame) find flies and save the X Y coordinates!
a=VideoReader('salto.avi');
X = cell(1,a.NumberOfFrames); %detection X coordinate indice
Y = cell(1,a.NumberOfFrames);  %detection Y coordinate indice

for i = 1:a.NumberOfFrames;
    img_real = read(a, i);
    I=rgb2gray(img_real);
    T=graythresh(I);
    BW=imbinarize(I,T);
    BW=medfilt2(BW,[3 3]);
    %now we have an image of hills and valleys..some are distinct, some
    %overlap..but you can still see the peak...most of the time.
    %use this GREAT 2-d local max/min finder 
    %http://www.mathworks.com/matlabcentral/fileexchange/12275-extrema-m-extrema2-m
    %it find the blob peak indices for this video, there should be ~11
    [zmax,imax,zmin,imin] = extrema2(BW);
    [X{i},Y{i}] = ind2sub(size(BW),imax);
     %for plotting
    %%{
    clf
    %subplot(211);     
    %imagesc(blob_img)
    %    axis off
    %subplot(212)
    imshow(img_real)
    hold on
    for j = 1:length(X{i})
        plot(Y{i}(j),X{i}(j),'or')
    end
    axis off
    pause
    %}
    
    i
end

%save it!
save('raw_marker_detections.mat',  'X','Y')

%now, move on to the multi object tracking code!
