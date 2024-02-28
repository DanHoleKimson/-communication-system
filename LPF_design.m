% filename:LPF_design.m
% Ts: sampling time ==> fs=1/Ts: maximum frequency
% B: Passband Bandwidth [Hz]
% fs/N: frequency resolution 
% p: tolerance to decide the delay
% w: filter weight
% t_D: minimum delay within the tolerance p
function [w, t_D]=LPF_design(Ts,B,N,p)
j=sqrt(-1);
fs=1/Ts;
N_B=ceil(B/(fs/N)); % conversion from B to k*fs/N
W_tmp=[ones(1,N_B) 0.9 0.7 0.4 0.2 0.1 0.01 0.001 0 0 0  0 0 0 0.001 0.01 0.1 0.2 0.4 0.7 0.9 ones(1,N_B-1)];
W=[ones(1,N_B) 0.9 0.7 0.4 0.2 0.1 0.01 0.001 0 0 0 zeros(1,N-length(W_tmp)) 0 0 0 0.001 0.01 0.1 0.2 0.4 0.7 0.9 ones(1,N_B-1)];
for d=0:N-1
    W_D=W.*exp(-j*2*pi*[0:N-1]/N*d);%exp(-j*2*pi*[0:N-1]/N*n)=exp(-j*2*pi*1/Ts*[0:N-1]/N*n*Ts)
    w_tmp1=idft_new(W_D,N);
    w_tmp2=real(w_tmp1);
    w_tmp3=w_tmp2/max(abs(w_tmp2));%normalization
    total_power=sum(w_tmp3.^2);
    leaked_power=total_power-sum(w_tmp3(1:N/2).^2);
    power_leakage_ratio=leaked_power/total_power;
    if power_leakage_ratio<p
        w=w_tmp3(1:N/2);
        t_D=d*Ts;
        return;
    end
end