1% Euler Method
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
u = 1;         % force applied to the cart              [N]

% State equations
% TODO: definir bien con andrea la notacion

% Initial conditions
x0 = 0;
th0 = 0;%TODO
dx0 = 0;
dth0 = 0;

denominator = @(x) (M+m).*(I+m.*L.^2)-m.^2.*L.^2.*cos(x(3)).^2;
f1 = @(u, x) x(2);
f2 = @(u, x) ((I+m.*L.^2).*(u-b.*x(2) + m.*L.*x(4).^2.*sin(x(3))) ... 
    + m.^2.*L.^2.*g.*sin(x(3)).*cos(x(3)))./denominator(x);
f3 = @(u, x) x(4);
f4 = @(u, x) (-m.*L.*u.*cos(x(3)) + m.*L.*b.*x(2).*cos(x(3)) ...
    - m.^2.*L.^2.*x(4).^2.*sin(x(3)).*cos(x(3)) ...
      -(M+m).*m*g.*L.*sin(x(3)))./denominator(x);

tf = 100;
%% Euler method
h = 1/(4000);  % Step size

te = 0:h:tf;

% State variables
xse = zeros(4, 1/h * tf);
xse = [x0 th0 dx0 dth0; xse']';


% Euler Method
for i=2:length(te)
    fprintf("\n\n\n\n\n%d\n", i/length(te)*100);
    xse(1, i) = xse(1, i - 1) + h * f1(u, xse(:, i - 1));
    xse(2, i) = xse(2, i - 1) + h * f2(u, xse(:, i - 1));
    xse(3, i) = xse(3, i - 1) + h * f3(u, xse(:, i - 1));
    xse(4, i) = xse(4, i - 1) + h * f4(u, xse(:, i - 1));
end

% System of equations
% x1=x, x2=dx, x3=theta, x4=dtheta, u=F
x1E = xse(1, :)';
x3E = xse(3, :)';

%% RK4
h = 1/(10);    % Step size

trk = 0:h:tf;

% State variables
xsrk = zeros(4, 1/h * tf);
xsrk = [x0 th0 dx0 dth0; xsrk']';


for i=2:length(trk)
    k(1, 1) = f1(u, xsrk(:, i - 1));
    k(2, 1) = f2(u, xsrk(:, i - 1));
    k(3, 1) = f3(u, xsrk(:, i - 1));
    k(4, 1) = f4(u, xsrk(:, i - 1));
    
    k(1, 2) = f1(u, xsrk(:, i - 1) + (h / 2) * k(:, 1));
    k(2, 2) = f2(u, xsrk(:, i - 1) + (h / 2) * k(:, 1));
    k(3, 2) = f3(u, xsrk(:, i - 1) + (h / 2) * k(:, 1));
    k(4, 2) = f4(u, xsrk(:, i - 1) + (h / 2) * k(:, 1));
    
    k(1, 3) = f1(u, xsrk(:, i - 1) + (h / 2) * k(:, 2));
    k(2, 3) = f2(u, xsrk(:, i - 1) + (h / 2) * k(:, 2));
    k(3, 3) = f3(u, xsrk(:, i - 1) + (h / 2) * k(:, 2));
    k(4, 3) = f4(u, xsrk(:, i - 1) + (h / 2) * k(:, 2));
    
    k(1, 4) = f1(u, xsrk(:, i - 1) + h * k(:, 3));
    k(2, 4) = f2(u, xsrk(:, i - 1) + h * k(:, 3));
    k(3, 4) = f3(u, xsrk(:, i - 1) + h * k(:, 3));
    k(4, 4) = f4(u, xsrk(:, i - 1) + h * k(:, 3));

    xsrk(:, i) = xsrk(:, i - 1) + h/6 * (k(:, 1) + 2 * k(:, 2) ...
        + 2 * k(:, 3) + k(:, 4));
end
x1RK = xsrk(1, :);
x3RK = xsrk(3, :);
%% plot
sim('InvertedPendulumNM')
figure;
hold on;
plot(te, x3E, 'y')
plot(trk, x3RK, 'c')
plot(x3, 'g-')
label('')