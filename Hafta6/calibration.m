RGB=imread('topbirak_calib.jpg');
I=rgb2gray(RGB);
se=strel('disk',15);
background=imopen(I,se);
I2=I-background;
I3=imadjust(I2,[0.3 0.7],[]);
[T EM]=graythresh(I3);
BW=imbinarize(I3,T);
BW=medfilt2(BW,[3 3]);
BW = bwareaopen(BW,50);
imshow(BW)
hold on
[B,L]=bwboundaries(BW,'noholes');
stats=regionprops(BW,'Centroid');
centroids=cat(1,stats.Centroid);

centroids=sortrows(centroids,[1 2],{'descend','descend'});

for i=1:length(centroids)
   centroid=centroids(i,:);
   plot(centroid(1),centroid(2),'r+');
   text(centroid(1)-15,centroid(2)+15,num2str(i),'Color','r');
end
hold off
