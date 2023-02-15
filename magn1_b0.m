%% This is a demo code for the MRI part of the course BME2103
% Function: Simulate the magnetization precession under B0.
% Author: Dr. Jianpan Huang, Email: jianpanhuang@outlook.com, 20230214
clear all, close all, clc;

%% Set parameters
b0 = 3; % external magnetic field, in T
gama = 42.576e6; % gyromagnetic ratio, for 1H
w0 = gama*b0/1e6/128; % actual w0 is fast at such a high field, here divided by a factor  visualization of precession
t = 0:0.1:30; % the time duration to observe the precession

%% Compute the magnetization precession
m0 = 100; % magnetization at equilibrium, here set to 100
alpha = pi/6; % angle between magnetization and z axis, here set to 30 degree
mxy = m0*sin(alpha); % initial magnetization xy component
mx = mxy.*cos(w0*t); % time-dependent magnetization x component
my = mxy.*sin(w0*t); % time-dependent magnetization y component
mz = repmat(m0*cos(alpha),[size(mx)]); % time-dependent magnetization z component

%% Visualize the magnetization precession
figure
plot3(mx,my,mz,'LineWidth',2)
axis([-max(m0) max(m0), -max(m0) max(m0), -max(m0) max(m0)]);
title('Stationary frame: M precession in B_0')
pause(0.005);
for m = 1:length(t)
    % t_part = t(1:m);
    mx_prec = mx(1:m);
    my_prec = my(1:m);
    mz_prec = mz(1:m);
    plot3(mx_prec,my_prec,mz_prec,'LineWidth',2)
    hold on;
    plot3(mx_prec(end),my_prec(end),mz_prec(end),'om','LineWidth',2)
    axis([-max(m0) max(m0), -max(m0) max(m0), -max(m0) max(m0)]);
    title('Stationary frame: M precession in B_0')
    pause(0.005);
    hold off
end