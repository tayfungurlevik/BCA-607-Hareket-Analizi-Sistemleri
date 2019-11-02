videoReader=VideoReader('salto.avi');
for img=1:videoReader.NumberOfFrames;
   filename=strcat('salto_',num2str(img),'.jpg');
   resimKaresi=read(videoReader,img);
   imwrite(resimKaresi,filename);
end