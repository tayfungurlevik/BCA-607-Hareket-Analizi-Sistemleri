
dosya_on_ad='fettah_sut2_C001H001S0001';
dosya_uzanti='.jpg';
n=85
%for n=1:105
dosya_adi=strcat(dosya_on_ad,sprintf( '%06d', n ) ,dosya_uzanti);
RGB=imread(dosya_adi);
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


imshow(BW);
hold on
[B,L]=bwboundaries(BW,'noholes');
stats=regionprops(L,I,'Area','WeightedCentroid','Centroid','Perimeter');
%bel ve diz karistigi icin 60-85 frame arasi
[stats(4),stats(5)]=deal(stats(5),stats(4));
renk='ygbmc';
for i=1:length(stats)
   centroid=stats(i).WeightedCentroid;
   
   plot(centroid(1),centroid(2),'O','Color',renk(i));
   text(centroid(1)+5,centroid(2),sprintf('%3.3f,%3.3f',centroid(1),centroid(2)),'Color',renk(i),'FontSize',12);
   
end
for i=1:length(stats)-1
    centroid=stats(i).WeightedCentroid;
    centroid2=stats(i+1).WeightedCentroid;
    line([centroid(1),centroid2(1)],[centroid(2),centroid2(2)],'Color','white','LineStyle','--');
end
hold off
%pause 
%end


