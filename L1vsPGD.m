clear
close all
M=50;
N=100;
K=10;
%% Generate signal
% x=zeros(N,1);
% ind=randperm(N);
% x(ind(1:K))=randn(K,1);
% A=randn(M,N);% 
% A=A/max(abs(A(:)));% normalized
% x=x/max(abs(x(:)));% normalized
%% load default sensing matrix and signal
load input_dat.mat
snr_A=20;
snr_b=20;
sA=1/(10^(snr_A/10));
sb=1/(10^(snr_b/10));
%% Generate nosie matrix and noise array
E=sA*randn(size(A));
b=(A+E)*x+sb*randn(M,1);
%% signal reconstruction using L1 method and Proximal Gradient Descent method
x0=CS_linprog(A,b);
x1=PGD_TLS(A,b,N,0.01,0.1,10000);
%% error analysis
subplot(211)
plot(x,'*');hold on
plot(x0)
ylim([-1.2 1.2])
title(sprintf('PSNR of L1: %.2f dB',psnr(x0,x)));
subplot(212)
plot(x,'*');hold on
plot(x1)
ylim([-1.2 1.2])
title(sprintf('PSNR of PGD: %.2f dB',psnr(x1,x)));