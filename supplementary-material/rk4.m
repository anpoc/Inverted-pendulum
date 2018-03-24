% Runge Kutta method
% Author: Santiago Hincapie
% Course: CM0440
% Date: 17/02/2017

% clear enviroment
clear
close all
clc

%% Define parameters
M = 0.5;       % mass of the cart                       [kg]
m = 0.2;       % mass of the pendulum                   [kg]
b = 0.1;       % coefficient of friction for cart       [N/m/sec]
L = 0.3;       % length to pendulum center of mass      [m]
I = 0.006;     % mass moment of inertia of the pendulum [kg.m^2]
g = 9.807;     % earth gravity                          [m/s²]

% input
F = 0;         % force applied to the cart              [N]

% State equations
% TODO: definir bien con andrea la notacion

% Initial conditions
x0 = 0;
th0 = 0;
dx0 = 0;
dth0 = 0;

% Function
f = @(u, x) [x(2);
             (I+m*L^2)*(u-b*x(2)+m*L*x(4)^2*sin(x(3))) ...
                + m^2*L^2*g*sin(x(3))*cos(x(3))/ ...
                  ((M+m)*(I+m*L^2)-m^2*L^2*cos(x(3))^2);
             x(4);
             (-m*L*u*cos(x(3))+m*L*b*x(2)*cos(x(3)) ...
               - m^2*L^2*x(4)^2*sin(x(3))*cos(x(3)) ...
                 -(M+m)*m*g*L*sin(x(3)))/ ...
                   (M+m)*(I+m*L^2)-m^2*L^2*cos(x(3))^2]';

%% Runge Kutta

 