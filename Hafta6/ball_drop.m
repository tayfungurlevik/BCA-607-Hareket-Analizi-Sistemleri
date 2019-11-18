dosya_on='top_';
dosya_uzanti='.jpg';

fid=fopen('ball_drop.txt','wt');
if fid<0
   warning('ball_drop.txt dosyasi acilmadi!');
   return;
end

for n=1:687
    dosya_adi=strcat(dosya_on,sprintf( '%03d', n ) ,dosya_uzanti);
    RGB=imread(dosya_adi);
    info=imfinfo(dosya_adi);
    Height=info.Height;
    I=rgb2gray(RGB);
    se=strel('disk',15);
    background=imopen(I,se);
    I2=I-background;
    I3=imadjust(I2,[0.3 0.7],[]);
    [T EM]=graythresh(I3);
    BW=imbinarize(I3,T);
    BW=medfilt2(BW,[3 3]);
    BW = bwareaopen(BW,50);
    L=bwlabel(BW);
    stats=regionprops(L,I,'Area','WeightedCentroid','Centroid','Perimeter');

    centroid=stats(1).Centroid;
    WeightedCentroid=stats(1).WeightedCentroid;
    fprintf(fid,'%3.3f,%3.3f,%3.3f,%3.3f \n',centroid(1),Height-centroid(2),WeightedCentroid(1),Height-WeightedCentroid(2));
    
end

fclose(fid);
