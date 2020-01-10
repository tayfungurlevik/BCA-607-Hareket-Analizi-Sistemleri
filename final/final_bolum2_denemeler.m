ld = load('hafta13\phoneIMU.mat');
acc = ld.a;
gyro = ld.omega;

decim = 2;
fuse = imufilter('SampleRate',50,'DecimationFactor',decim);

q = fuse(accelerometerReadings,gyroscopeReadings);
