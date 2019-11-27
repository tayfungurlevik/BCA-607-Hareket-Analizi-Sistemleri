
dosya_on_ad='fettah_sut2_C001H001S0001';
dosya_uzanti='.jpg';
for n=1:105
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
BW=medfilt2(BW,[3 3]);
BW = bwareaopen(BW,15);
%maskeleme islemi icin Y si 135 den kucuk olan tum pixelleri 0 yaptim.
BW(:,1:135)=0;
imshow(BW);
hold on
[B,L]=bwboundaries(BW,'noholes');
stats=regionprops(L,I,'Area','WeightedCentroid','Centroid','Perimeter');

renk='ygbmcr';
for i=1:length(stats)
   centroid=stats(i).Centroid;
   
   plot(centroid(1),centroid(2),'O','Color',renk(i));
   text(centroid(1)+5,centroid(2),sprintf('%3.3f,%3.3f',centroid(1),centroid(2)),'Color',renk(i),'FontSize',12);
   
end
for i=1:length(stats)-1
    centroid=stats(i).Centroid;
    centroid2=stats(i+1).Centroid;
    line([centroid(1),centroid2(1)],[centroid(2),centroid2(2)],'Color','white','LineStyle','--');
end
hold off
pause 
end


