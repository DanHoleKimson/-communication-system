clear all; close all;

ts = 1/400;
N = 1024;
p = 0.0001;
fs = 1/ts;

%LPF
t = 0:ts:1;
%setting wave
s1 = sin(2*pi*10*t);
s2 = sin(2*pi*10*t) + cos(2*pi*40*t);
%setting LPF
[w, t_d] = LPF_design(ts,20,N,p);
figure, plot(t,s1);
xlabel('[sec]');
ylabel('s1 : sin(2*pi*10*t)');
grid;
figure, plot(t,s2);
xlabel('[sec]');
ylabel('s2 : sin(2*pi*10*t) + cos(2*pi*40*t)');
grid;
S1 = dft_new(s1,N);
S2 = dft_new(s2,N);
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(S1(N/2+1:N)) abs(S1(1:N/2))]);
xlabel('[Hz]');
ylabel('|S1|');
grid;
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(S2(N/2+1:N)) abs(S2(1:N/2))]);
xlabel('[Hz]');
ylabel('|S2|');
grid;
%convolution with wave and LPF
L1 = conv_new(s1,w);
L2 = conv_new(s2,w);
%new delayed time
t_dealy = 0:ts:2.2775;
figure, plot(t_dealy,L1);
xlabel('[sec]');
ylabel('s1 with LPF');
grid;
figure, plot(t_dealy,L2);
xlabel('[sec]');
ylabel('s2 with LPF');
grid;
%observe at frequency domian
L1_f = dft_new(L1,N);
L2_f = dft_new(L2,N);
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(L1_f(N/2+1:N)) abs(L1_f(1:N/2))]);
xlabel('[Hz]');
ylabel('|L1|');
grid;
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(L2_f(N/2+1:N)) abs(L2_f(1:N/2))]);
xlabel('[Hz]');
ylabel('|L2|');
grid;