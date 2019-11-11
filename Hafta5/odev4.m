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
H=calculate_reconformal(x,ball_drop);
figure(1),plot(H(:,1),H(:,2),'ro');
axis([0 100 0 160]);
axis equal;
grid on;
fid=fopen('hizlar.txt','wt');
if fid<0
   warning('hizlar.txt dosyasi acilmadi!');
   return;
end
fprintf(fid,'%d. karedeki hiz: %3.3f \n',1,0);
hizlar=zeros(length(H),1);

for i=2:length(H)-1
    hiz=(H(i+1,2)-H(i-1,2))/(0.04)/100;
    hizlar(i,1)=hiz;
    
    fprintf(fid,'%d. karedeki hiz: %3.3f m/s \n',i,hiz);
end
fclose(fid);
fid=fopen('ivmeler.txt','wt');
if fid<0
   warning('ivmeler.txt dosyasi acilmadi!');
   return;
end
fprintf(fid,'%d. karedeki ivme: %3.3f m/s2 \n',1,0);
ivmeler=zeros(length(H),1);
ivmeler(1,1)=-9.81;
ivmeler(30,1)=-9.81;
for i=2:length(H)-1
    ivme=(hizlar(i+1,1)-hizlar(i-1,1))/(0.04);
    ivmeler(i,1)=ivme;
    fprintf(fid,'%d. karedeki ivme: %3.3f m/s2 \n',i,ivme);
end
fclose(fid);