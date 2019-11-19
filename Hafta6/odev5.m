clc, clear
S=[2.5 30;
    2.5 60;
    2.5 130;
    2.5 190;
    108 10;
    108 80;
    108 120;
    108 180];
load calib_im.txt;
I=calib_im;
x=calculate_conformal(I,S,1);
teta=atand(x(2)/x(1));
scale=x(1)/cosd(teta);
Tx=x(3);
Ty=x(4);
load 'ball_drop.txt';
ball_drop_centroid=ball_drop(:,1:2);
[b,a]=butter(2,15/500,'low');
filtered_ball_drop_centroid=filtfilt(b,a,ball_drop_centroid);
ball_drop_weighted=ball_drop(:,3:4);
filtered_ball_drop_weighted=filtfilt(b,a,ball_drop_weighted);
delta_t=1/1000;
%% centroid'e gore hiz ve ivmeler
H_centroid=calculate_reconformal(x,ball_drop_centroid);
filtered_H_centroid=calculate_reconformal(x,filtered_ball_drop_centroid);
hiz_centroid=velocity_central_diff(H_centroid,delta_t)/100;
filtered_hiz_centroid=velocity_central_diff(filtered_H_centroid,delta_t)/100;
ivme_centroid=accl4s_central_diff(H_centroid,delta_t)/100;
filtered_ivme_centroid=accl4s_central_diff(filtered_H_centroid,delta_t)/100;

%% weighted'e gore hiz ve ivmeler
H_weighted=calculate_reconformal(x,ball_drop_weighted);
filtered_H_weighted=calculate_reconformal(x,filtered_ball_drop_weighted);
hiz_weighted=velocity_central_diff(H_weighted,delta_t)/100;
filtered_hiz_weighted=velocity_central_diff(filtered_H_weighted,delta_t)/100;
ivme_weighted=accl4s_central_diff(H_weighted,delta_t)/100;
filtered_ivme_weighted=accl4s_central_diff(filtered_H_weighted,delta_t)/100;


