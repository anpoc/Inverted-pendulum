%% Inicialization
clear
clc

%% Non-linear system
% Parameters
M = 0.5; %(kg) mass of the cart
m = 0.2; %(kg) mass of the pendulum
b = 0.1; %(N*s/m) coefficient of friction for the cart
l = 0.3; %(m) length to pendulum center of mass
I = 0.006; %(kg) mass moment of inertia of the pendulum
g = 9.8; %(m/s^2) gravity

% System of equations
% x1=x, x2=dx, y1=theta, y2=dtheta, u=F
syms x1 x2 y1 y2 u; 
denominator = (M+m)*(I+m*l^2)-m^2*l^2*cos(y1)^2;
f1 = x2;
f2 = ((I+m*l^2)*u-(I+m*l^2)*b*x2+m^2*l^2*g*sin(y1)*cos(y1)-(I+m*l^2)*y2^2*sin(y1))/denominator;
f3 = y2;
f4 = (-m*l*cos(y1)*u+m*l*b*cos(y1)*x2+m^2*l^2*y2^2*sin(y1)*cos(y1)-(M+m)*m*g*l*sin(y1))/denominator;

% Output functions
h1 = x1;
h2 = y1;

% Equilibrium points
equilibrium = solve([f1, f2, f3, f4], [x1, x2, y1, y2, u]);

%% Linealization for theta0=pi and other vars 0 to 0
% Equilibrium values
x10 = equilibrium.x1(4);
x20 = equilibrium.x2(4);
y10 = equilibrium.y1(4);
y20 = equilibrium.y2(4);
u0 = equilibrium.u(4);

% Matrices
A = jacobian([f1, f2, f3, f4], [x1, x2, y1, y2]);
A = subs(A, [x1, x2, y1, y2], [x10, x20, y10, y20]);
B = jacobian([f1, f2, f3, f4], u);
B = subs(B, u, u0);
C = jacobian([h1, h2], [x1, x2, y1, y2]);
C = subs(C, [x1, x2, y1, y2], [x10, x20, y10, y20]);
D = [0 ; 0];
D = [0 ; 0];

%% Equilibrium evaluation
eigen = eig(A);
%% Lineal (theta = y1 = pi+phi, phi aprox to 0)
% System of equations
% NOTE: given that phi is aprox 0, sin(pi+phi) and cos(pi+phi) are aprox
% -phi and -1, and dtheta^2=dphi^2 aprox 0.
% x1=x, x2=dx, y1=phi, y2=dphi, u=F

denominator = I*(M+m)+M*m*l^2;
f1 = x2;
f2 = ((I+m*l^2)*u-(I+m*l^2)*b*x2+m^2*l^2*g*y1)/denominator;
f3 = y2;
f4 = (m*l*u-m*l*b*x2+(M+m)*m*g*l*y1)/denominator;