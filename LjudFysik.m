%record.
recObj = audiorecorder;
disp('Start speaking.');
recordblocking(recObj,4);
disp('End of Recording.');
y = getaudiodata(recObj);

%%
Fs = 8000;
x = zeros(1000,1);
x(1) = 1;
x(1000) = 1;
z = conv(x,y);
%frequency domain
[b,a] = butter(3,[0.25 0.95],'bandpass');
filteredY = filter(b,a,y);
soundsc(filteredY,Fs/1.15);

subplot(2,1,1)
plot(z)
title('Original Signal')
ys = ylim;

subplot(2,1,2)
plot(filteredY)
title('bandpass Filtered Signal')
xlabel('Time (s)')
ylim(ys)

%%
Fs = 8000;
blo = fir1(48,[0.35 0.75]);
outlo = filter(blo,1,y);
%soundsc(outlo,Fs);

subplot(2,1,1)
plot(y)
title('Original Signal')
ys = ylim;

subplot(2,1,2)
plot(outlo)
title('bandpass Filtered Signal')
xlabel('Time (s)')
ylim(ys)


%% Frequence analysis
Fs = 8000; %sampling frequency
N = length(y);
Y = fft(y);
T = 1/Fs; %sampling period
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;

[b,a] = butter(3,0.3);
filteredY = filter(b,a,y);
filterfftY = fft(filteredY);
Pfilter = abs(filterfftY/N):
P2filter = Pfilter(1:N



plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
