%% bileske ivme ve yercekimsiz ivmenin hesaplanmas?
load('hafta13\phoneIMU.mat');
bileske_ivme=sqrt(a(:,1).^2+a(:,2).^2+a(:,3).^2);
%bileske ivme
plot(t_a,bileske_ivme);
title('Raw Magnitude - No filter');
xlabel('Time(s)');
ylabel('Acceleration (m/s2)');
saveas(gcf,'bileske_ivme.png');
g=9.80148;

a_no_g=bileske_ivme-g;

%bileske ivme(yercekimsiz)
plot(t_a,a_no_g);
title('No Gravity - No filter');
xlabel('Time(s)');
ylabel('Acceleration (m/s2)');
saveas(gcf,'bileske_ivme_yercekimsiz.png');
%% FFT incelemesi
Fs = 50;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(t_a);             % Length of signal
t = t_a;        % Time vector
Y=fft(a);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of a(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')


%% ivmenin filtrelenmesi

fc=1;
fs=1/0.02;
[c,d]=butter(1,fc/(fs/2),'low');

filtrelenmis_ivme=filtfilt(c,d,a);
bileske_ivme_filtered=sqrt(filtrelenmis_ivme(:,1).^2+filtrelenmis_ivme(:,2).^2+filtrelenmis_ivme(:,3).^2);
a_no_g_filtered=bileske_ivme_filtered-g;
%filtrelenmis yercekimsiz ivme
plot(t_a,a_no_g_filtered);
title('No Gravity - low pass filtered');
xlabel('Time(s)');
ylabel('Acceleration (m/s2)');
ylim([-10 10]);
saveas(gcf,'filtrelenmis_ivme.png');
%% FFT incelemesi bileske ivme
Fs = 50;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(t_a);             % Length of signal
t = t_a;        % Time vector
Y=fft(a_no_g);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of a(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
%% bileskeivmenin filtrelenmesi

fc=2;
fs=1/0.02;
[c,d]=butter(2,fc/(fs/2),'low');

filtrelenmis_ivme=filtfilt(c,d,a_no_g);


%filtrelenmis yercekimsiz ivme
plot(t_a,filtrelenmis_ivme);
title('No Gravity - low pass filtered');
xlabel('Time(s)');
ylabel('Acceleration (m/s2)');
ylim([-10 10])
saveas(gcf,'filtrelenmis_ivme_2.png');
%% velocity-with drift

 v=cumtrapz(t_a,a_no_g_filtered);
 plot(t_a,v);

%% position-with drift

  s=cumtrapz(t_a,v);
  plot(t_a,s);

%% filter velocity-with drift
fcv=0.5;
[e,f]=butter(2,fcv/(fs/2),'high');
v_filtered=filter(e,f,v);

plot(t_a,v_filtered);
ylim([-2 2]);

%% position no drift
s_filtered=cumtrapz(t_a,v_filtered);
plot(t_a,s_filtered);
ylim([-0.5 0.5]);
