
dosya_on_ad='fettah_sut2_C001H001S0001';
dosya_uzanti='.jpg';
%% Bel ve diz markerlari yer degistirene kadar
%48 ve 51. frameler arasinda bel markeri kayip
%daha sonra cubic spline ile bu framedeki degerler bulunacak
for n=1:59
n
dosya_adi=strcat(dosya_on_ad,sprintf( '%06d', n ) ,dosya_uzanti);
RGB=imread(dosya_adi);
imshow(RGB);
I=rgb2gray(RGB);
info=imfinfo(dosya_adi);
Height=info.Height;
se=strel('disk',15);
background=imopen(I,se);
I2=I-background;
I3=imadjust(I2,[0.3 0.7],[]);
[T EM]=graythresh(I3);
BW=imbinarize(I3,T);
%maskeleme islemi icin Y si 135 den kucuk olan tum pixelleri 0 yaptim.
BW(:,1:135)=0;
BW=medfilt2(BW,[3 3]);
BW = bwareaopen(BW,15);



hold on
[B,L]=bwboundaries(BW,'noholes');
stats=regionprops(L,I,'Area','WeightedCentroid','Centroid','Perimeter');
cg_centroids=cat(1,stats.Centroid);
renk='ygbmc';
for i=1:length(cg_centroids)
   centroid=cg_centroids(i,:);
   
   plot(centroid(1),centroid(2),'O','Color',renk(i));
   text(centroid(1)+5,centroid(2),sprintf('%3.3f,%3.3f',centroid(1),centroid(2)),'Color',renk(i),'FontSize',12);
   
end
for i=1:length(cg_centroids)-1
    centroid=cg_centroids(i,:);
    centroid2=cg_centroids(i+1,:);
    line([centroid(1),centroid2(1)],[centroid(2),centroid2(2)],'Color','white','LineStyle','--');
end
hold off
pause
end
%% 60 ve 86 frameleri arasinda diz ile bel markerleri yer degisiyor

for n=60:86
n
dosya_adi=strcat(dosya_on_ad,sprintf( '%06d', n ) ,dosya_uzanti);
RGB=imread(dosya_adi);
imshow(RGB);
I=rgb2gray(RGB);
info=imfinfo(dosya_adi);
Height=info.Height;
se=strel('disk',15);
background=imopen(I,se);
I2=I-background;
I3=imadjust(I2,[0.3 0.7],[]);
[T EM]=graythresh(I3);
BW=imbinarize(I3,T);
%maskeleme islemi icin Y si 135 den kucuk olan tum pixelleri 0 yaptim.
BW(:,1:135)=0;
BW=medfilt2(BW,[3 3]);
BW = bwareaopen(BW,15);



hold on
[B,L]=bwboundaries(BW,'noholes');
stats=regionprops(L,I,'Area','WeightedCentroid','Centroid','Perimeter');
cg_centroids=cat(1,stats.Centroid);
%bel ve diz karistigi icin 60-85 frame arasi
[cg_centroids(4,:),cg_centroids(5,:)]=deal(cg_centroids(5,:),cg_centroids(4,:));
renk='ygbmc';
for i=1:length(cg_centroids)
   centroid=cg_centroids(i,:);
   
   plot(centroid(1),centroid(2),'O','Color',renk(i));
   text(centroid(1)+5,centroid(2),sprintf('%3.3f,%3.3f',centroid(1),centroid(2)),'Color',renk(i),'FontSize',12);
   
end
for i=1:length(cg_centroids)-1
    centroid=cg_centroids(i,:);
    centroid2=cg_centroids(i+1,:);
    line([centroid(1),centroid2(1)],[centroid(2),centroid2(2)],'Color','white','LineStyle','--');
end
hold off
pause 
end
%% 87 ve 89 frameleri arasinda bilek-bel-diz markerleri yer degisiyor

for n=87:89
n
dosya_adi=strcat(dosya_on_ad,sprintf( '%06d', n ) ,dosya_uzanti);
RGB=imread(dosya_adi);
imshow(RGB);
I=rgb2gray(RGB);
info=imfinfo(dosya_adi);
Height=info.Height;
se=strel('disk',15);
background=imopen(I,se);
I2=I-background;
I3=imadjust(I2,[0.3 0.7],[]);
[T EM]=graythresh(I3);
BW=imbinarize(I3,T);
%maskeleme islemi icin Y si 135 den kucuk olan tum pixelleri 0 yaptim.
BW(:,1:135)=0;
BW=medfilt2(BW,[3 3]);
BW = bwareaopen(BW,15);


hold on
[B,L]=bwboundaries(BW,'noholes');
stats=regionprops(L,I,'Area','WeightedCentroid','Centroid','Perimeter');
cg_centroids=cat(1,stats.Centroid);
%bel ve diz ve bilek karistigi icin 
[cg_centroids(3,:),cg_centroids(5,:)]=deal(cg_centroids(5,:),cg_centroids(3,:));
[cg_centroids(3,:),cg_centroids(4,:)]=deal(cg_centroids(4,:),cg_centroids(3,:));
renk='ygbmc';
for i=1:length(cg_centroids)
   centroid=cg_centroids(i,:);
   
   plot(centroid(1),centroid(2),'O','Color',renk(i));
   text(centroid(1)+5,centroid(2),sprintf('%3.3f,%3.3f',centroid(1),centroid(2)),'Color',renk(i),'FontSize',12);
   
end
for i=1:length(cg_centroids)-1
    centroid=cg_centroids(i,:);
    centroid2=cg_centroids(i+1,:);
    line([centroid(1),centroid2(1)],[centroid(2),centroid2(2)],'Color','white','LineStyle','--');
end
end
%% 90-105 frameleri arasinda bilek-bel-diz markerleri yer degisiyor

for n=90:105
n
dosya_adi=strcat(dosya_on_ad,sprintf( '%06d', n ) ,dosya_uzanti);
RGB=imread(dosya_adi);
imshow(RGB);
I=rgb2gray(RGB);
info=imfinfo(dosya_adi);
Height=info.Height;
se=strel('disk',15);
background=imopen(I,se);
I2=I-background;
I3=imadjust(I2,[0.3 0.7],[]);
[T EM]=graythresh(I3);
BW=imbinarize(I3,T);
%maskeleme islemi icin Y si 135 den kucuk olan tum pixelleri 0 yaptim.
BW(:,1:135)=0;
BW=medfilt2(BW,[3 3]);
BW = bwareaopen(BW,15);



hold on
[B,L]=bwboundaries(BW,'noholes');
stats=regionprops(L,I,'Area','WeightedCentroid','Centroid','Perimeter');
cg_centroids=cat(1,stats.Centroid);
cg_centroids=sortrows(cg_centroids,2,'descend');
if n==90
    [cg_centroids(2,:),cg_centroids(3,:)]=deal(cg_centroids(3,:),cg_centroids(2,:));
end

renk='ygbmc';
for i=1:length(cg_centroids)
   centroid=cg_centroids(i,:);
   
   plot(centroid(1),centroid(2),'O','Color',renk(i));
   text(centroid(1)+5,centroid(2),sprintf('%3.3f,%3.3f',centroid(1),centroid(2)),'Color',renk(i),'FontSize',12);
   
end
for i=1:length(cg_centroids)-1
    centroid=cg_centroids(i,:);
    centroid2=cg_centroids(i+1,:);
    line([centroid(1),centroid2(1)],[centroid(2),centroid2(2)],'Color','white','LineStyle','--');
end
hold off
pause 
end
