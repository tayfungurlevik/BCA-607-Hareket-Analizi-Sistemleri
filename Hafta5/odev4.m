clc, clear
S=[0 80;
    0 109;
    103 72;
    103 111];
load calib_im.txt;
I=calib_im;
x=calculate_conformal(I,S,1);
teta=atand(x(2)/x(1));
scale=x(1)/cosd(teta);
Tx=x(3);
Ty=x(4);
load 'ball_drop.txt';
ball_drop_centroid=ball_drop(:,1:2);
ball_drop_weighted=ball_drop(:,3:4);
%% centroid'e gore hiz ve ivmeler
H=calculate_reconformal(x,ball_drop_centroid);
figure(1),plot(H(:,1),H(:,2),'ro');
axis([0 100 0 160]);
axis equal;
grid on;


fid=fopen('hizlar_centroid.txt','wt');
if fid<0
   warning('hizlar_centroid.txt dosyasi acilmadi!');
   return;
end
fprintf(fid,'%d. karedeki hiz: %3.3f \n',1,0);
hizlar_centroid=zeros(length(H),1);

for i=2:length(H)-1
    hiz=(H(i+1,2)-H(i-1,2))/(0.04)/100;
    hizlar_centroid(i,1)=hiz;
    
    fprintf(fid,'%d. karedeki hiz: %3.3f m/s \n',i,hiz);
end
% polyfit yöntemi ile son hiz
zaman=ones(29,1);
zaman(:,1)=1:29;
zaman=zaman*0.04;
p=polyfit(zaman,hizlar_centroid(1:29,1),1);
hizlar_centroid(30,1)=polyval(p,30*0.04);
% hizlar_centroid(30,1)=(H(30,2)-H(29,2))/0.04/100;
fprintf(fid,'%d. karedeki hiz: %3.3f m/s \n',30,hizlar_centroid(30,1));

fclose(fid);
fid=fopen('ivmeler_centroid.txt','wt');
if fid<0
   warning('ivmeler_centroid.txt dosyasi acilmadi!');
   return;
end
fprintf(fid,'%d. karedeki ivme: %3.3f m/s2 \n',1,0);
ivmeler_centroid=zeros(length(H),1);
ivmeler_centroid(1,1)=-9.81;
ivmeler_centroid(30,1)=-9.81;
for i=2:length(H)-1
    ivme=(hizlar_centroid(i+1,1)-hizlar_centroid(i-1,1))/(0.04);
    ivmeler_centroid(i,1)=ivme;
    fprintf(fid,'%d. karedeki ivme: %3.3f m/s2 \n',i,ivme);
end
fclose(fid);
%% weighted centroid'e göre h?z ve ivme

H=calculate_reconformal(x,ball_drop_weighted);
figure(1),plot(H(:,1),H(:,2),'ro');
axis([0 100 0 160]);
axis equal;
grid on;
fid=fopen('hizlar_weighted.txt','wt');
if fid<0
   warning('hizlar_weighted.txt dosyasi acilmadi!');
   return;
end
fprintf(fid,'%d. karedeki hiz: %3.3f \n',1,0);
hizlar_weighted=zeros(length(H),1);

for i=2:length(H)-1
    hiz=(H(i+1,2)-H(i-1,2))/(0.04)/100;
    hizlar_weighted(i,1)=hiz;
    
    fprintf(fid,'%d. karedeki hiz: %3.3f m/s \n',i,hiz);
end
% polyfit yöntemi ile son hiz
zaman=ones(29,1);
zaman(:,1)=1:29;
zaman=zaman*0.04;
p=polyfit(zaman,hizlar_weighted(1:29,1),1);
hizlar_weighted(30,1)=polyval(p,30*0.04);
fprintf(fid,'%d. karedeki hiz: %3.3f m/s \n',30,hizlar_weighted(30,1));
fclose(fid);
fid=fopen('ivmeler_weighted.txt','wt');
if fid<0
   warning('ivmeler_weighted.txt dosyasi acilmadi!');
   return;
end
fprintf(fid,'%d. karedeki ivme: %3.3f m/s2 \n',1,0);
ivmeler_weighted=zeros(length(H),1);
ivmeler_weighted(1,1)=-9.81;
ivmeler_weighted(30,1)=-9.81;
for i=2:length(H)-1
    ivme=(hizlar_weighted(i+1,1)-hizlar_weighted(i-1,1))/(0.04);
    ivmeler_weighted(i,1)=ivme;
    fprintf(fid,'%d. karedeki ivme: %3.3f m/s2 \n',i,ivme);
end
fclose(fid);