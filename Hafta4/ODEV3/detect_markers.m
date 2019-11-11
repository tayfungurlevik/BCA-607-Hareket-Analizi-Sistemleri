



a=VideoReader('salto.avi');
X = cell(1,a.NumberOfFrames); %detection X coordinate indice
Y = cell(1,a.NumberOfFrames);  %detection Y coordinate indice

for i = 1:a.NumberOfFrames;
    img_real = read(a, i);
    I=rgb2gray(img_real);
    T=graythresh(I);
    BW=imbinarize(I,T);
    
    BW=medfilt2(BW,[3 3]);
    [zmax,imax,zmin,imin] = extrema2(BW);
    [X{i},Y{i}] = ind2sub(size(BW),imax);

    clf

    imshow(img_real)
    hold on
    for j = 1:length(X{i})
        plot(Y{i}(j),X{i}(j),'+r')
    end
    axis off


    

end

%save it!
save('raw_marker_detections.mat',  'X','Y')

%now, move on to the multi object tracking code!
