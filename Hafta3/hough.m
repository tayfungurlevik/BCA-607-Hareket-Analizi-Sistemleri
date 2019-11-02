jpegFiles = dir('*.jpg'); 
numfiles = length(jpegFiles);
mydata = cell(1, numfiles);
n=1;
for k=1:numfiles
    mydata{k} = imread(jpegFiles(k).name);
    imshow( mydata{k})
%     I=rgb2gray( mydata{k});
%     se=strel('disk',15);
%     background=imopen(I,se);
%     I2=I-background;
%     I3=imadjust(I2,[0.3 0.7],[]);
%     T=graythresh(I3);
%     BW=imbinarize(I3,T);
%     BW = bwareaopen(BW,50);
% %     BW=medfilt2(BW,[3 3]);
    [centers, radii, metric] = imfindcircles( mydata{k},[4 15]);
    centersStrong5 = centers(1:11,:); 
    radiiStrong5 = radii(1:11);
    metricStrong5 = metric(1:11);
    viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');
    saveas(gcf,strcat('Hough\marked_0',int2str(n)),'jpeg');
    n=n+1;
end
