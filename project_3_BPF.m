clear all; close all;
%BPF
ts = 1/400;
N = 1024;
p = 0.0001;
fs = 1/ts;
%setting wave
t = 0:ts:0.5;
s1 = sin(2*pi*60*t);
s2 = sin(2*pi*20*t) + sin(2*pi*60*t) + 2*cos(2*pi*90*t);
s3 = (1/2)*sin(2*pi*50*t) + sin(2*pi*60*t) + cos(2*pi*80*t);
%figure function
figure, plot(t,s1);
xlabel('[sec]');
ylabel('s1 = sin(2*pi*60*t)');
figure, plot(t,s2);
xlabel('[sec]');
ylabel('s2 = sin(2*pi*20*t) + sin(2*pi*60*t) + 2*cos(2*pi*90*t)');
figure, plot(t,s3);
xlabel('[sec]');
ylabel('s3 = (1/2)*sin(2*pi*50*t) + sin(2*pi*60*t) + cos(2*pi*80*t)');
%dft wave
S1 = dft_new(s1,N);
S2 = dft_new(s2,N);
S3 = dft_new(s3,N);

figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(S1(N/2+1:N)) abs(S1(1:N/2))]);
xlabel('[Hz]');
ylabel('|S1|');
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(S2(N/2+1:N)) abs(S2(1:N/2))]);
xlabel('[Hz]');
ylabel('|S2|');
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(S3(N/2+1:N)) abs(S3(1:N/2))]);
xlabel('[Hz]');
ylabel('|S3|');
%setting BPF
[w,t_d] = BPF_design(ts,40,70,N,9);
%convolution with wave and BPF
B1 = conv_new(s1,w);
B2 = conv_new(s2,w);
B3 = conv_new(s3,w);
%new delayed time
t_delay = 0:ts:1.7775;
figure, plot(t_delay,B1);
xlabel('[sec]');
ylabel('s1 with BPF');
axis([0 0.5 -4 4]);
figure, plot(t_delay,B2);
xlabel('[sec]');
ylabel('s2 with BPF');
axis([0 0.5 -6 6]);
figure, plot(t_delay,B3);
xlabel('[sec]');
ylabel('s3 with BPF');
axis([0 0.5 -6 6]);

B1_f = dft_new(B1,N);
B2_f = dft_new(B2,N);
B3_f = dft_new(B3,N);

figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(B1_f(N/2+1:N)) abs(B1_f(1:N/2))]);
xlabel('[Hz]');
ylabel('|S1 with BPF|');
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(B2_f(N/2+1:N)) abs(B2_f(1:N/2))]);
xlabel('[Hz]');
ylabel('|S2 with BPF|');
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(B3_f(N/2+1:N)) abs(B3_f(1:N/2))]);
xlabel('[Hz]');
ylabel('|S3 with BPF|');