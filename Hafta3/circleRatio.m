jpegFiles = dir('*.jpg'); 
numfiles = length(jpegFiles);
mydata = cell(1, numfiles);
n=1;
for j=1:numfiles
    mydata{j} = imread(jpegFiles(j).name);
    imshow( mydata{j})
    I=rgb2gray( mydata{j});
    se=strel('disk',15);
    background=imopen(I,se);
    I2=I-background;
    I3=imadjust(I2,[0.3 0.7],[]);
    T=graythresh(I3);
    BW=imbinarize(I3,T);
    BW = bwareaopen(BW,50);
    BW=medfilt2(BW,[8 8]);
    [B,L]=bwboundaries(BW,'noholes');
    LRGB=label2rgb(L,@jet,[.5 .5 .5]);
    stats=regionprops(L,'Area','Centroid','Perimeter','Eccentricity');
    ratioLow=0.99;
    ratioUp=1.01;
    hold on
    for k=1:length(B)
        boundary=B{k};
        plot(boundary(:,2),boundary(:,1),'w','LineWidth',2)
        perimeter=stats(k).Perimeter;
        area=stats(k).Area;
        eccent=stats(k).Eccentricity;
        ratio=4*pi*area/perimeter^2;
        ratio_string=sprintf('%2.2f',ratio);
        if((ratio>=ratioLow)&&(ratio<=ratioUp)&&(eccent==0))
            centroid=stats(k).Centroid;
            plot(centroid(1),centroid(2),'ko');
        end
   
    end
    saveas(gcf,strcat('CircleRatio\marked_0',int2str(n)),'jpeg');
    n=n+1;
end




