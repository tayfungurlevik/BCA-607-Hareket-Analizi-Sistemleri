%% Dosya ad? i?lemleri
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

%% Global thresholding yöntemi
for n=41:70
    dosya_adi=strcat(dosya_on,int2str(n),dosya_uzanti);
    RGB=imread(dosya_adi);
    imshow(RGB);
    I=rgb2gray(RGB);
    [level EM]=graythresh(I);
    BWem=im2bw(I,EM);
    BW=medfilt2(BWem,[5 5]);
    L=bwlabel(BW);
    cg=regionprops(L,'centroid');
    marker_centroids=cat(1,cg.Centroid);
    hold on 
    plot(marker_centroids(:,1),marker_centroids(:,2),'r+')
    saveas(gcf,strcat('graythresh\marked_0',int2str(n)),'jpeg');
    hold off
end
%% otsu thresholding yöntemi
for n=41:70
    dosya_adi=strcat(dosya_on,int2str(n),dosya_uzanti);
    RGB=imread(dosya_adi);
    imshow(RGB);
    I=rgb2gray(RGB);
    [counts x]=imhist(I);
    [T EM]=otsuthresh(counts);
    BWem=im2bw(I,EM);
    BW=medfilt2(BWem,[5 5]);
    L=bwlabel(BW);
    cg=regionprops(L,'centroid');
    marker_centroids=cat(1,cg.Centroid);
    hold on 
    plot(marker_centroids(:,1),marker_centroids(:,2),'r+')
    saveas(gcf,strcat('adaptive\marked_0',int2str(n)),'jpeg');
    hold off
end
%% Adaptive thresholding yöntemi
for n=41:70
    dosya_adi=strcat(dosya_on,int2str(n),dosya_uzanti);
    RGB=imread(dosya_adi);
    imshow(RGB);
    I=rgb2gray(RGB);
   
    T=adaptthresh(I,0.4,'ForegroundPolarity','bright');
    BWem=imbinarize(I,T);
    
    BW=medfilt2(BWem,[5 5]);
    L=bwlabel(BW);
    cg=regionprops(L,'centroid');
    marker_centroids=cat(1,cg.Centroid);
    hold on 
    plot(marker_centroids(:,1),marker_centroids(:,2),'r+')
    saveas(gcf,strcat('adaptive\marked_0',int2str(n)),'jpeg');
    hold off
end