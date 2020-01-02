load('hafta13\phoneIMU.mat');
bileske_ivme=sqrt(a(:,1).^2+a(:,2).^2+a(:,3).^2);
plot(t_a,bileske_ivme);
no_gravity_bil_ivme=sqrt(a(:,1).^2+a(:,2).^2+(a(:,3)+9.81).^2);
plot(t_a,no_gravity_bil_ivme);
