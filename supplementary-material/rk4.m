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
%th0 = %TODO
dx0 = 0;
dth0 = 0;
%% Runge Kutta
tf = 10;       % Simulation time
h = 1/(25*tf); % Step size

t = h:h:tf;

% State variables
xsrk = zeros(1/h * tf, 4);
xsrk = [x0 th0 dx0 dth0; xsrk];

for i=t
    k(1) = f(xsrk(i - 1));
    k(2) = f(xsrk(i - 1) + h/2 * k(1));
    k(3) = f(xsrk(i - 1) + h/2 * k(2));
    k(4) = f(xsrk(i - 1) + h * k(3));
    
    xsrk = xsrk(i - 1) + h/6 * k(1) + 2 * k(2) + 2 * k(3) + k(4);
end
 