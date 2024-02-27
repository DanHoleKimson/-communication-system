%filename:plot_sin.m
clear all; close all;

fs=256; %[Hz]
Ts=1/fs;
t=0:Ts:2-Ts;% [sec]
f1=2; f2=5;

x1=sin(2*pi*f1*t);
x2=2*sin(2*pi*f2*t+pi/4);
x3=x1+x2;

length_t=length(t);

%plotting time-domain signal
figure, plot(t,x1);
hold on, plot(t,x2);
legend('sin(2*pi*2*t)','2*sin(2*pi*5*t+pi/4)');
xlabel('t[sec]'); ylabel('x_1(t), x_2(t)');
axis([0 2 -4 4]); grid;

figure, plot(t,x3); 
xlabel('t[sec]'); ylabel('x_3(t)'); axis([0 2 -4 4]); grid;

% frequency resolution decision
% frequency resolution = fs/N
N=2; while(N<length_t), N=N*2; end

X1=dft_new(x1,N); X2=dft_new(x2,N); X3=dft_new(x3,N);

% plotting frequency-domain signal
%figure, stem([0:fs/N:fs*(N-1)/N],[abs(X1(1:N))]);
figure, stem([-fs/2:fs/N:fs*(N/2-1)/N],[abs(X1(N/2+1:N)) abs(X1(1:N/2))]);
xlabel('frequency [Hz]'); ylabel('|X_1(f)|');
grid; axis([-10 10 0 600]);

figure, stem([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(X2(N/2+1:N)) abs(X2(1:N/2))]);
xlabel('frequency [Hz]'); ylabel('|X_2(f)|');
grid; axis([-10 10 0 600]);

figure, stem([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(X3(N/2+1:N)) abs(X3(1:N/2))]);
xlabel('frequency [Hz]'); ylabel('|X_3(f)|');
grid; axis([-10 10 0 600]);