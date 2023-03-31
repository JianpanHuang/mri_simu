%% This is a demo code for the MRI part of the course BME2103
% To demonstrate the Fourier transform of a free induction decay (FID) to an NMR spectrum.
% To be note: The data is a synthesized data not a real NMR data.
% Author: Dr. Jianpan Huang, Email: jianpanhuang@outlook.com, 20230214
clear all, close all, clc;

%% Set parameters
w1 = 3; % frequency of a group 1
w2 = 6; % frequency of a group 2
w3 = 9; % frequency of a group 3
t = 0:0.01:50; % time, in ms
t2 = 20; % T2 relaxation, in ms

%% Simulate FID signal
fid1 = 1*sin(w1*t).*exp(-t/t2);
fid2 = 2*sin(w2*t).*exp(-t/t2);
fid3 = 3*sin(w3*t).*exp(-t/t2);
fid = fid1 + fid2 + fid3 + 0.1*randn(size(t)); % sum of signal with noise

%% Fourier transform of FID
spec = fftshift(fft(fid));

%% Visualize the results
figure, 
subplot(1,2,1), plot(t, fid);
title("FID");
subplot(1,2,2), plot(abs(spec(round(length(fid)/2):length(fid)/2+100)));
title("Spectrum");
