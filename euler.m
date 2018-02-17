% Euler Method
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
l = 0.3;       % length to pendulum center of mass      [m]
I = 0.006;     % mass moment of inertia of the pendulum [kg.m^2]
g = 9.807;     % earth gravity                          [m/s²]

% input
F = 0;         % force applied to the cart              [N]

% State equations
% TODO: definir bien con andrea la notacion

% Initial conditions
x0 = 0;
%th0 = %TODO
dx0 = 0;
dth0 = 0;

%% Euler method
tf = 10;       % Simulation time
h = 1/(25*tf); % Step size

t = h:h:tf;

% State variables
xse = zeros(1/h * tf, 4);
xse = [x0 th0 dx0 dth0; xse];

% Euler Method
for i=t
    xse(i) = xse(i - 1) + h * f(x(i - 1));
end