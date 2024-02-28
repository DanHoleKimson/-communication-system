function x=idft_new(X,N);
% author: Jaekwon Kim
% date: April 2008
% X: input sequence; frequency domain signal
% N: fs/N = frequency resolution
% x: output sequence; time domain signal

X_zero_padded=[X zeros(1,N-length(X))];
n=0:N-1;
k=transpose([0:N-1]);
DFT_matrix=1/N*exp(j*2*pi*k*n/N);
x_temp=DFT_matrix*transpose(X_zero_padded);
x=transpose(x_temp);
