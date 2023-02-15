%% This is a demo code for the MRI part of the course BME2103
% Function: Simulate the magnetization precession under B0 after the 90 RF pulse (B1) excitation (signal detection).
% Author: Dr. Jianpan Huang, Email: jianpanhuang@outlook.com, 20230214
clear all, close all, clc;

%% Set parameters
b0 = 3; % external magnetic field, in T
gama = 42.576e6; % gyromagnetic ratio, for 1H
w0 = gama*b0/1e6/128; % Larmor frequency, actual w0 is fast, here scaled by a factor for visualization of precession
t = 0:0.1:50; % the time duration to observe the precession
b1_fa = pi/2; % the flip angle of b1
w1 = b1_fa/max(t);

%% Compute the magnetization precession
m0 = 100; % magnetization at equilibrium, here set to 100
t1 = 20; % T1
t2 = 10; % T2
alpha = pi/2; % angle between magnetization and z axis, here set to 30 degree
mxy = m0*sin(alpha)*exp(-t/t2); % time-dependent magnetization xy component with T2 relaxation
mx = mxy.*cos(w0*t); % time-dependent magnetization x component
my = mxy.*sin(w0*t); % time-dependent magnetization y component
mz = m0*(1-exp(-t/t1)); % time-dependent magnetization z component, T1 relaxation

%% Visualize the magnetization precession
figure
subplot(2,2,1),plot3(mx,my,mz,'LineWidth',2)
axis([-max(m0) max(m0), -max(m0) max(m0), -max(m0) max(m0)]);
title('Stationary frame: M relaxation in B_0 after 90^{o} RF B_1')
subplot(2,2,2),plot(mx,my,'LineWidth',2)
axis([-max(m0) max(m0), -max(m0) max(m0), -max(m0) max(m0)]);
title('Stationary frame: M_x_y')
subplot(2,2,3),plot(t,mx,'LineWidth',2)
axis([0 max(t), -max(mx) max(mx)]);
title('Rotating frame: M_x')
subplot(2,2,4),plot(t,my,'LineWidth',2)
axis([0 max(t), -max(my) max(my)]);
title('Rotating frame: M_y')
pause(0.005);
for m = 1:length(t)
    t_prec = t(1:m);
    mx_prec = mx(1:m);
    my_prec = my(1:m);
    mz_prec = mz(1:m);
    mxy_prec = mxy(1:m);
    subplot(2,2,1),plot3(mx_prec,my_prec,mz_prec,'LineWidth',2)
    axis([-max(m0) max(m0), -max(m0) max(m0), -max(m0) max(m0)]);
    title('Stationary frame: M relaxation in B_0 after 90^{o} RF B_1')
    subplot(2,2,2),plot(mx_prec,my_prec,'LineWidth',2)
    axis([-max(m0) max(m0), -max(m0) max(m0), -max(m0) max(m0)]);
    title('Stationary frame: M_x_y')
    subplot(2,2,3),plot(t_prec,mx_prec,'LineWidth',2)
    axis([0 max(t), -max(mx) max(mx)]);
    title('Rotating frame: M_x')
    subplot(2,2,4),plot(t_prec,my_prec,'LineWidth',2)
    axis([0 max(t), -max(my) max(my)]);
    title('Rotating frame: M_y')
    pause(0.005);
end