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
tf = 10;       % Simulation time
h = 1/(25*tf); % Step size

t = h:h:tf;

% State variables
xsrk = zeros(1/h * tf, 4);
xsrk = [x0 th0 dx0 dth0; xsrk];

u = 0;

k = zeros(4, 4);

for i=1:length(t)
    k(1, :) = f(u, xsrk(i - 1,:));
    k(2, :) = f(u, xsrk(i - 1,:) + h/2 * k(:, 1));
    k(3, :) = f(u, xsrk(i - 1, :) + h/2 * k(:, 2));
    k(4, :) = f(u, xsrk(i - 1, :) + h * k(:, 3));
    
    xsrk(i, :) = xsrk(i - 1, :) + h/6 * k(1, :) + 2 * k(2, :) + 2 * k(3, :) + k(4, :);
end
x1 = xskr(:, 1);
x2 = xskr(:, 2);
x3 = xskr(:, 3);
x4 = xskr(:, 4);
 