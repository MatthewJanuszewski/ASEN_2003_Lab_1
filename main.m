% ASEN 2003 Lab 1 - Roller Coaster Dynamics

% Housekeeping
clc
clear
close all

% Constants
g = 9.81; % m/s^2
h_i = 125; % Initial height (m)
prec = 50; % Precision (number of elements in each vector used for calculations)


%% Parameterization of vertical drop (component 1)
% Cart drops from rest and experiences freefall
h_d = 50; % Total height of drop

% Calculate time required to drop h_d meters in freefall
time_total_comp1 = sqrt(2*(h_d)/g);

% Allocate vector for the time period where the cart is in component 1
t_1 = linspace(0, time_total_comp1, prec);

% Parameterization of vertical drop
x_1 = zeros(1,prec);
y_1 = zeros(1,prec);
z_1 = h_i - 0.5*g*(t_1).^2;


% Parameterization of circular valley (component 2)
% r = 100; % Radius of circle
% t_2 = linspace(0, (3*pi)/4, 100);
% x_2 = -r.*cos(t);
% y_2 = zeros(1,100);
% z_2 = 125 -r.*sin(t);


% Plot circular valley and axes
hold on
plot3(zeros(1,10),linspace(-150,150,10),zeros(1,10), 'Color', 'Black')
plot3(linspace(-150,150,10),zeros(1,10),zeros(1,10), 'Color', 'Black')
% plot3(zeros(1,10),zeros(1,10),linspace(-150,150,10), 'Color', 'Black')
scatter3(x_1,y_1,z_1)
% plot3(x_2,y_2,z_2)




xlabel('x') 
ylabel('y')
zlabel('z')
xlim([-150 150])
ylim([-150 150])
zlim([-150 150])

% Settings to avoid annoying zoom in effect
camproj('perspective')
set(gca,'CameraViewAngle', 9.5)
set(gca,'CameraViewAngleMode','Manual')
set(groot,'defaultfigureposition',[400 250 900 750])


