%% 
load('hafta13\phoneIMU.mat');
bileske_ivme=sqrt(a(:,1).^2+a(:,2).^2+a(:,3).^2);
plot(t_a,bileske_ivme);
a_no_g=a;
a_no_g(:,3)=a_no_g(:,3)+9.81;
no_gravity_bil_ivme=sqrt(a_no_g(:,1).^2+a_no_g(:,2).^2+a_no_g(:,3).^2);
plot(t_a,a_no_g);
%% 

fc=5;
fs=1/0.02;
[c,d]=butter(1,fc/(fs/2),'low');
[e,f]=butter(1,fc/(fs/2),'high');
filtrelenmis_ivme=filtfilt(c,d,a_no_g);

plot(t_a,filtrelenmis_ivme);

v=cumtrapz(t_a,filtrelenmis_ivme);
v=filter(e,f,v);
s=cumtrapz(t_a,v);
plot(t_a,v);