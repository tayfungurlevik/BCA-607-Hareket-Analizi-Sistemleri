
dosya_on_ad='fettah_sut2_C001H001S0001';
dosya_uzanti='.jpg';
bos=zeros(105,2);
noktalar.ayak_ucu=bos;
noktalar.topuk=bos;
noktalar.bilek=bos;
noktalar.diz=bos;
noktalar.kalca=bos;
%%Yakalanabilinen markerlarin degiskenlere atanmasi
for n=1:105
n
dosya_adi=strcat(dosya_on_ad,sprintf( '%06d', n ) ,dosya_uzanti);
RGB=imread(dosya_adi);


I=rgb2gray(RGB);
info=imfinfo(dosya_adi);
Height=info.Height;
se=strel('disk',15);
background=imopen(I,se);
I2=I-background;
I3=imadjust(I2,[0.3 0.7],[]);
T=graythresh(I3);
BW=imbinarize(I3,T);
%maskeleme islemi icin Y si 135 den kucuk olan tum pixelleri 0 yaptim.
BW(:,1:135)=0;
BW=medfilt2(BW,[3 3]);
BW = bwareaopen(BW,15);
[B,L]=bwboundaries(BW,'noholes');
stats=regionprops(L,I,'Centroid');
cg_centroids=cat(1,stats.Centroid);
if n>=60 && n<=86
    [cg_centroids(4,:),cg_centroids(5,:)]=deal(cg_centroids(5,:),cg_centroids(4,:));       
elseif n>=87 && n<=89
    [cg_centroids(3,:),cg_centroids(5,:)]=deal(cg_centroids(5,:),cg_centroids(3,:));
    [cg_centroids(3,:),cg_centroids(4,:)]=deal(cg_centroids(4,:),cg_centroids(3,:)); 
elseif n>=90
    cg_centroids=sortrows(cg_centroids,2,'descend');
    if n==90
    [cg_centroids(2,:),cg_centroids(3,:)]=deal(cg_centroids(3,:),cg_centroids(2,:));
    end
end

noktalar.ayak_ucu(n,:)=cg_centroids(1,:);
noktalar.topuk(n,:)=cg_centroids(2,:);
noktalar.bilek(n,:)=cg_centroids(3,:);
noktalar.diz(n,:)=cg_centroids(4,:);
if n<48 || n>51
    noktalar.kalca(n,:)=cg_centroids(5,:);
end
end
%kalcanin 48-51 frameleri arasindaki pozisyonlarini cubic spline yontemi
%ile bulacagiz
noktalar.kalca(48:51,:)=[];
xq=[48,49,50,51];
x=ones(105,1);
x(:,1)=1:105;
x(48:51,:)=[];
sx=spline(x,noktalar.kalca(:,1),xq);
sy=spline(x,noktalar.kalca(:,2),xq);
eklenecekler=zeros(4,2);
for i=1:4
    eklenecekler(i,1)=sx(i);
    eklenecekler(i,2)=sy(i);
end
temp=zeros(105,2);
temp(1:47,:)=noktalar.kalca(1:47,:);
temp(48:51,:)=eklenecekler;
temp(52:end,:)=noktalar.kalca(48:end,:);
noktalar.kalca=temp;
%% Video goruntulerinin olusturulmasi islemi
video=false;
if video
    aviobj=VideoWriter('sut.mp4','MPEG-4');
    aviobj.FrameRate=25;
    aviobj.Quality=100;
    open(aviobj);
    renk='ygbmc';
    cell_noktalar=struct2cell(noktalar);
    for n=1:105
        dosya_adi=strcat(dosya_on_ad,sprintf( '%06d', n ) ,dosya_uzanti);
        RGB=imread(dosya_adi);
        imshow(RGB);
        hold on
        for i=1:length(cell_noktalar)
            centroid=cell_noktalar{i};
            x=centroid(n,1);
            y=centroid(n,2);
            plot(x,y,'O','Color',renk(i));
            text(x+5,y,sprintf('%3.3f,%3.3f',x,y),'Color',renk(i),'FontSize',12);
        end
        for i=1:length(cell_noktalar)-1
            centroid=cell_noktalar{i};
            centroid2=cell_noktalar{i+1};
            line([centroid(n,1),centroid2(n,1)],[centroid(n,2),centroid2(n,2)],'Color','white','LineStyle','--');
        end
        frame=getframe(gcf);
        writeVideo(aviobj,frame);
        hold off
    end
end
if video
    close(aviobj);
end
%% Kalibrasyon islemi
kalibRGB=imread('kalibrasyon.jpg');
I=rgb2gray(kalibRGB);
se=strel('disk',15);
background=imopen(I,se);
I2=I-background;
I3=imadjust(I2,[0.3 0.7],[]);
[T EM]=graythresh(I3);
BW=imbinarize(I3,T);

BW(:,1:135)=0;
BW=medfilt2(BW,[3 3]);

BW = bwareaopen(BW,50);
imshow(BW)
hold on
[B,L]=bwboundaries(BW,'noholes');
kalib_stats=regionprops(BW,'Centroid');
kalib_centroids=cat(1,kalib_stats.Centroid);

kalib_centroids=sortrows(kalib_centroids,[1 2],{'descend','descend'});
[kalib_centroids(1,:),kalib_centroids(5,:)]=deal(kalib_centroids(5,:),...
    kalib_centroids(1,:));
[kalib_centroids(2,:),kalib_centroids(6,:)]=deal(kalib_centroids(6,:),...
    kalib_centroids(2,:));
[kalib_centroids(3,:),kalib_centroids(7,:)]=deal(kalib_centroids(7,:),...
    kalib_centroids(3,:));
[kalib_centroids(4,:),kalib_centroids(8,:)]=deal(kalib_centroids(8,:),...
    kalib_centroids(4,:));
for i=1:length(kalib_centroids)
   centroid=kalib_centroids(i,:);
   plot(centroid(1),centroid(2),'r+');
   text(centroid(1)-15,centroid(2)+15,num2str(i),'Color','r');
end
hold off
%% birim degistirme ve filtre islemleri
kalib_centroids(:,2)=1024-kalib_centroids(:,2);
noktalar.kalca(:,2)=1024-noktalar.kalca(:,2);
noktalar.diz(:,2)=1024-noktalar.diz(:,2);
noktalar.bilek(:,2)=1024-noktalar.bilek(:,2);
noktalar.topuk(:,2)=1024-noktalar.topuk(:,2);
noktalar.ayak_ucu(:,2)=1024-noktalar.ayak_ucu(:,2);
S=[2.5 30;
    2.5 60;
    2.5 130;
    2.5 190;
    108 10;
    108 80;
    108 120;
    108 180];
I=kalib_centroids;
x=calculate_conformal(I,S,1);
teta=atand(x(2)/x(1));
scale=x(1)/cosd(teta);
Tx=x(3);
Ty=x(4);
delta_t=1/500;
[b,a]=butter(2,15/250,'low');
filtered_kalca=filtfilt(b,a,noktalar.kalca);
filtered_diz=filtfilt(b,a,noktalar.diz);
filtered_bilek=filtfilt(b,a,noktalar.bilek);
filtered_topuk=filtfilt(b,a,noktalar.topuk);
filtered_ayak_ucu=filtfilt(b,a,noktalar.ayak_ucu);
gercek_konumlar.ayakucu=calculate_reconformal(x,filtered_ayak_ucu);
gercek_konumlar.topuk=calculate_reconformal(x,filtered_topuk);
gercek_konumlar.bilek=calculate_reconformal(x,filtered_bilek);
gercek_konumlar.diz=calculate_reconformal(x,filtered_diz);
gercek_konumlar.kalca=calculate_reconformal(x,filtered_kalca);
hizlar.ayakucu=velocity_central_diff(gercek_konumlar.ayakucu/100,delta_t);
hizlar.topuk=velocity_central_diff(gercek_konumlar.topuk/100,delta_t);
hizlar.bilek=velocity_central_diff(gercek_konumlar.bilek/100,delta_t);
hizlar.diz=velocity_central_diff(gercek_konumlar.diz/100,delta_t);
hizlar.kalca=velocity_central_diff(gercek_konumlar.kalca/100,delta_t);
ivmeler.ayakucu=accl4v_central_diff(hizlar.ayakucu,delta_t);
ivmeler.topuk=accl4v_central_diff(hizlar.topuk,delta_t);
ivmeler.bilek=accl4v_central_diff(hizlar.bilek,delta_t);
ivmeler.diz=accl4v_central_diff(hizlar.diz,delta_t);
ivmeler.kalca=accl4v_central_diff(hizlar.kalca,delta_t);
%% grafikler
%pozisyon grafigi
plot(gercek_konumlar.ayakucu(:,1),gercek_konumlar.ayakucu(:,2));
hold on
plot(gercek_konumlar.topuk(:,1),gercek_konumlar.topuk(:,2));
plot(gercek_konumlar.bilek(:,1),gercek_konumlar.bilek(:,2));
plot(gercek_konumlar.diz(:,1),gercek_konumlar.diz(:,2));
plot(gercek_konumlar.kalca(:,1),gercek_konumlar.kalca(:,2));
title('Sut Marker Pozisyonlari');
xlabel('x(cm)');
ylabel('y(cm)');
legend('Ayak Ucu','Topuk','Bilek','Diz','Kalca');
axis([-150 200 0 200]);
grid on;
saveas(gcf,'Pozisyonlar.png');
hold off
%Ayak Ucu Hiz grafigi   
plot(1:104,hizlar.ayakucu(:,1));
hold on
plot(1:104,hizlar.ayakucu(:,2));
title('Ayak Ucu Hizi (m/s)');
xlabel('Frames');
ylabel('m/s');
legend('Ayak Ucu Vx','Ayak Ucu Vy');
grid on;
saveas(gcf,'AyakUcuHiz.png');
hold off
%Topuk Hiz grafigi   
plot(1:104,hizlar.topuk(:,1));
hold on
plot(1:104,hizlar.topuk(:,2));
title('Topuk Hizi (m/s)');
xlabel('Frames');
ylabel('m/s');
legend('Topuk Vx','Topuk Vy');
grid on;
saveas(gcf,'TopukHiz.png');
hold off
%Bilek Hiz grafigi   
plot(1:104,hizlar.bilek(:,1));
hold on
plot(1:104,hizlar.bilek(:,2));
title('Bilek Hizi (m/s)');
xlabel('Frames');
ylabel('m/s');
legend('Bilek Vx','Bilek Vy');
grid on;
saveas(gcf,'BilekHiz.png');
hold off
%Diz Hiz grafigi   
plot(1:104,hizlar.diz(:,1));
hold on
plot(1:104,hizlar.diz(:,2));
title('Diz Hizi (m/s)');
xlabel('Frames');
ylabel('m/s');
legend('Diz Vx','Diz Vy');
grid on;
saveas(gcf,'DizHiz.png');
hold off
%Kalca Hiz grafigi   
plot(1:104,hizlar.kalca(:,1));
hold on
plot(1:104,hizlar.kalca(:,2));
title('Kalca Hizi (m/s)');
xlabel('Frames');
ylabel('m/s');
legend('Kalca Vx','Kalca Vy');
grid on;
saveas(gcf,'KalcaHiz.png');
hold off
%AyakUcu ivme grafigi   
plot(3:length(ivmeler.ayakucu),ivmeler.ayakucu(3:end,1));
hold on
plot(3:length(ivmeler.ayakucu),ivmeler.ayakucu(3:end,2));
title('Ivme AyakUcu (m/s/s)');
xlabel('Frames');
ylabel('m/s/s');
legend('AyakUcu Ax','AyakUcu Ay');
grid on;
saveas(gcf,'AyakUcuIvme.png');
hold off
%Topuk ivme grafigi   
plot(3:length(ivmeler.topuk),ivmeler.topuk(3:end,1));
hold on
plot(3:length(ivmeler.topuk),ivmeler.topuk(3:end,2));
title('Ivme Topuk (m/s/s)');
xlabel('Frames');
ylabel('m/s/s');
legend('Topuk Ax','Topuk Ay');
grid on;
saveas(gcf,'TopukIvme.png');
hold off
%Bilek ivme grafigi   
plot(3:length(ivmeler.bilek),ivmeler.bilek(3:end,1));
hold on
plot(3:length(ivmeler.bilek),ivmeler.bilek(3:end,2));
title('Ivme Bilek (m/s/s)');
xlabel('Frames');
ylabel('m/s/s');
legend('Bilek Ax','Bilek Ay');
grid on;
saveas(gcf,'BilekIvme.png');
hold off
%Diz ivme grafigi   
plot(3:length(ivmeler.diz),ivmeler.diz(3:end,1));
hold on
plot(3:length(ivmeler.diz),ivmeler.diz(3:end,2));
title('Ivme Diz (m/s/s)');
xlabel('Frames');
ylabel('m/s/s');
legend('Diz Ax','Diz Ay');
grid on;
saveas(gcf,'DizIvme.png');
hold off
%Kalca ivme grafigi   
plot(3:length(ivmeler.kalca),ivmeler.kalca(3:end,1));
hold on
plot(3:length(ivmeler.kalca),ivmeler.kalca(3:end,2));
title('Ivme Kalca (m/s/s)');
xlabel('Frames');
ylabel('m/s/s');
legend('Kalca Ax','Kalca Ay');
grid on;
saveas(gcf,'KalcaIvme.png');
hold off
%% Dizin acisal hizinin hesaplanmasi

angle=atan((gercek_konumlar.kalca(:,2)-gercek_konumlar.diz(:,2))/...
    (gercek_konumlar.kalca(:,1)-gercek_konumlar.diz(:,1)));
angle=angle(:,105);
acisal_hizlar=zeros(105,1);
for i=1:104
   acisal_hizlar(i,1)=(angle(i+1,1)-angle(i,1))/delta_t;
end
plot(1:length(acisal_hizlar)-1,acisal_hizlar(1:end-1,1));
hold on

title('Diz Acisal Hiz rad/s');
xlabel('Frames');
ylabel('rad/s');

grid on;
saveas(gcf,'Diz Acisal Hiz.png');
hold off




