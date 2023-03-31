%% This is a demo code for the MRI part of the course BME2103
% To demonstrate the Fourier transform of image to k-space, and vice versa.
% Author: Dr. Jianpan Huang, Email: jianpanhuang@outlook.com, 20230214
clear all, close all, clc;

%% Original image and k-sapce
img = imread("brain.tif");
ksp = fftshift(fft2(fftshift(img)));
figure, set(gcf,'unit','normalized','position',[0.25,0.6,0.5,0.35]);
subplot(1,2,1),imagesc(img); axis off; colormap("gray"); title('Original')
subplot(1,2,2),imagesc(abs(ksp)); axis off; colormap("gray"); clim([0, max(abs(ksp(2)))]); title('Original')

%% Low-frequency reconstruction
ds_rate = 4; % down sampling rate
[xn, yn] = size(ksp);
img = imread("brain.tif");
ksp_low = zeros(xn, yn);
ksp_low(round(xn/2-xn/2/ds_rate)+1:round(xn/2+xn/2/ds_rate),round(yn/2-yn/2/ds_rate)+1:round(yn/2+yn/2/ds_rate)) = ...
    ksp(round(xn/2-xn/2/ds_rate)+1:round(xn/2+xn/2/ds_rate),round(yn/2-yn/2/ds_rate)+1:round(yn/2+yn/2/ds_rate));
img_low = fftshift(ifft2(fftshift(ksp_low)));
figure, set(gcf,'unit','normalized','position',[0.25,0.6,0.5,0.35]);
subplot(1,2,1),imagesc(abs(img_low)); axis off; colormap("gray"); title('Low-frequency')
subplot(1,2,2),imagesc(abs(ksp_low)); axis off; colormap("gray"); clim([0, max(abs(ksp(2)))]); title('Low-frequency')

%% High-frequency reconstruction
ds_rate = 5; % down sampling rate
[xn, yn] = size(ksp);
img = imread("brain.tif");
ksp_low = ksp;
ksp_low(round(xn/2-xn/2/ds_rate*(ds_rate-1))+1:round(xn/2+xn/2/ds_rate*(ds_rate-1)), ...
    round(yn/2-yn/2/ds_rate*(ds_rate-1))+1:round(yn/2+yn/2/ds_rate*(ds_rate-1))) = 0;
img_low = fftshift(ifft2(fftshift(ksp_low)));
figure, set(gcf,'unit','normalized','position',[0.25,0.6,0.5,0.35]);
subplot(1,2,1),imagesc(abs(img_low)); axis off; colormap("gray"); title('High-frequency')
subplot(1,2,2),imagesc(abs(ksp_low)); axis off; colormap("gray"); clim([0, max(abs(ksp(2)))]); title('High-frequency')