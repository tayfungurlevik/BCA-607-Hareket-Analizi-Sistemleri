%% vicon dosyasindan labellarin pozisyonlarini okuma islemi

load 'vicon_parsed.txt';
frames=vicon_parsed(:,1);
M1=vicon_parsed(:,2:4);
M2=vicon_parsed(:,5:7);
M3=vicon_parsed(:,8:10);
M4=vicon_parsed(:,11:13);
M5=vicon_parsed(:,14:16);
video=true;
if video
   aviObj=VideoWriter('final.mp4','MPEG-4');
   aviObj.FrameRate=25;
   open(aviObj);
end

for i=1:length(frames)
    plot3(M1(:,1),M1(:,3),M1(:,2),'--r')
    grid on
    axis equal
    hold on
    plot3(M2(:,1),M2(:,3),M2(:,2),'--g')
    plot3(M3(:,1),M3(:,3),M3(:,2),'--b')
    plot3(M4(:,1),M4(:,3),M4(:,2),'--y')
    plot3(M5(:,1),M5(:,3),M5(:,2),'--c')

    

    X(1,1)=M1(i,1);
    X(1,2)=M3(i,1);
    X(1,3)=M5(i,1);
    Y(1,1)=M1(i,3);
    Y(1,2)=M3(i,3);
    Y(1,3)=M5(i,3);
    Z(1,1)=M1(i,2);
    Z(1,2)=M3(i,2);
    Z(1,3)=M5(i,2);


    fill3(X,Y,Z,'red');
    if video
       frame=getframe(gcf);
       writeVideo(aviObj,frame);
    end
    hold off
end
if video
   close(aviObj); 
end
%% Roll,pitch ve yaw degerlerinin hesaplanmasi
roll=zeros(1,length(frames));
pitch=zeros(1,length(frames));
yaw=zeros(1,length(frames));
for n=1:length(frames)
    P1=M1(n,:);
    P2=M3(n,:);
    P3=M5(n,:);
    [P1(1,2),P1(1,3)]=deal(P1(1,3),P1(1,2));
    [P2(1,2),P2(1,3)]=deal(P2(1,3),P2(1,2));
    [P3(1,2),P3(1,3)]=deal(P3(1,3),P3(1,2));
    v1=P2-P1;
    v2=cross(P3-P1,v1);
    i=v1/norm(v1);
    j=v2/norm(v2);
    k=cross(i,j);
    R=[i(1),j(1),k(1);i(2),j(2),k(2);i(3),j(3),k(3)];

    eul=rotm2eul(R,'XYZ');
    roll(n)=eul(1);
    pitch(n)=eul(2);
    yaw(n)=eul(3);
     
end

plot(1:length(frames),radtodeg(roll));