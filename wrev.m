%filename:wrev.m
function w_out=wrev(w_in)
N=length(w_in);
w_out=w_in(N:-1:1);