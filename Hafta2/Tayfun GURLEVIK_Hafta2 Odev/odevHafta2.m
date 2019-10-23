%% Dosya adi islemleri
dosya_on='topbirak_0';
dosya_uzanti='.jpg';
%% Histogramlar? kaydeden section

for n=41:70
    dosya_adi=strcat(dosya_on,int2str(n),dosya_uzanti);
    RGB=imread(dosya_adi);
    I=rgb2gray(RGB);
    histogram(I);
    saveas(gcf,strcat('histogramlar\histogram_0',int2str(n)),'jpeg');
end
%% Threshold=0.3
for n=41:70
    dosya_adi=strcat(dosya_on,int2str(n),dosya_uzanti);
    RGB=imread(dosya_adi);
    imshow(RGB);
    I=rgb2gray(RGB);
    se=strel('disk',15);
    background=imopen(I,se);
    I2=I-background;
    I3=imadjust(I2,[0.3 0.7],[]);
    
    BWem=imbinarize(I3,0.3);
    BWem = bwareaopen(BWem,50);
    BW=medfilt2(BWem,[3 3]);
    L=bwlabel(BW);
    cg=regionprops(L,'centroid');
    marker_centroids=cat(1,cg.Centroid);
    hold on 
    plot(marker_centroids(:,1),marker_centroids(:,2),'r+')
    saveas(gcf,strcat('Threshold 0.3\marked_0',int2str(n)),'jpeg');
    hold off
end
%% Global thresholding yöntemi
for n=41:70
    dosya_adi=strcat(dosya_on,int2str(n),dosya_uzanti);
    RGB=imread(dosya_adi);
    imshow(RGB); 
    I=rgb2gray(RGB);
    se=strel('disk',15);
    background=imopen(I,se);
    I2=I-background;
    I3=imadjust(I2,[0.3 0.7],[]);
    [level EM]=graythresh(I3);
    BWem=imbinarize(I3,level);
    BWem = bwareaopen(BWem,50);
    BW=medfilt2(BWem,[3 3]);
    L=bwlabel(BW);
    cg=regionprops(L,'centroid');
    marker_centroids=cat(1,cg.Centroid);
    hold on 
    plot(marker_centroids(:,1),marker_centroids(:,2),'r+')
    saveas(gcf,strcat('graythresh_global\marked_0',int2str(n)),'jpeg');
    hold off
end
%% otsu thresholding yöntemi
for n=41:70
    dosya_adi=strcat(dosya_on,int2str(n),dosya_uzanti);
    RGB=imread(dosya_adi);
    imshow(RGB);
    I=rgb2gray(RGB);
    se=strel('disk',15);
    background=imopen(I,se);
    I2=I-background;
    I3=imadjust(I2,[0.3 0.7],[]);
    [counts x]=imhist(I3);
    [T EM]=otsuthresh(counts);
    
    BWem=imbinarize(I3,T);
    BWem = bwareaopen(BWem,50);
    BW=medfilt2(BWem,[3 3]);

    L=bwlabel(BW);
    cg=regionprops(L,'centroid');
    marker_centroids=cat(1,cg.Centroid);
    hold on 
    plot(marker_centroids(:,1),marker_centroids(:,2),'r+')
    saveas(gcf,strcat('otsu\marked_0',int2str(n)),'jpeg');
    hold off
end
%% Adaptive thresholding yöntemi
for n=41:70
    dosya_adi=strcat(dosya_on,int2str(n),dosya_uzanti);
    RGB=imread(dosya_adi);
    imshow(RGB);
    I=rgb2gray(RGB);
   se=strel('disk',15);
    background=imopen(I,se);
    I2=I-background;
    I3=imadjust(I2,[0.3 0.7],[]);
    T=adaptthresh(I3,0.6);
    BWem=imbinarize(I3,T);
    
    BW=medfilt2(BWem,[15 15]);
    L=bwlabel(BW);
    cg=regionprops(L,'centroid');
    marker_centroids=cat(1,cg.Centroid);
    hold on 
    plot(marker_centroids(:,1),marker_centroids(:,2),'r+')
    saveas(gcf,strcat('adaptive\marked_0',int2str(n)),'jpeg');
    hold off
end