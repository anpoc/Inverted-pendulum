%% Inicialization
clear
clc

%% Non-Linear system
% Parameters
M = 0.5; %(kg) mass of the cart
m = 0.2; %(kg) mass of the pendulum
b = 0.1; %(N*s/m) coefficient of friction for the cart
L = 0.3; %(m) Length to pendulum center of mass
I = 0.006; %(kg) mass moment of inertia of the pendulum
g = 9.8; %(m/s^2) gravity

% System of equations
% x1=x, x2=dx, y1=theta, y2=dtheta, u=F
syms x1 x2 y1 y2 u; 
denominator = (M+m)*(I+m*L^2)-m^2*L^2*cos(y1)^2;
f1 = x2;
f2 = ((I+m*L^2)*(u-b*x2+m*L*y2^2*sin(y1))+m^2*L^2*g*sin(y1)*cos(y1))/denominator;
f3 = y2;
f4 = (-m*L*u*cos(y1)+m*L*b*x2*cos(y1)-m^2*L^2*y2^2*sin(y1)*cos(y1)-(M+m)*m*g*L*sin(y1))/denominator;

% Output functions
h1 = x1;
h2 = y1;

% Equilibrium points
equilibrium = solve([f1, f2, f3, f4], [x1, x2, y1, y2, u]);

%% Linealization for theta0=pi and other vars 0 to 0
% Equilibrium values
n = 5;
x10 = equilibrium.x1(n);
x20 = equilibrium.x2(n);
y10 = equilibrium.y1(n);
y20 = equilibrium.y2(n);
u0 = equilibrium.u(n);

% Matrices
A_a = jacobian([f1, f2, f3, f4], [x1, x2, y1, y2]);
A_a = subs(A, [x1, x2, y1, y2, u], [x10, x20, y10, y20, u0]);
B_a = jacobian([f1, f2, f3, f4], u);
B_a = subs(B, [x1, x2, y1, y2, u], [x10, x20, y10, y20, u0]);
C_a = jacobian([h1, h2], [x1, x2, y1, y2]);
C_a = subs(C, [x1, x2, y1, y2, u], [x10, x20, y10, y20, u0]);
D_a = [0 ; 0];

%% Equilibrium evaluation
eigen = eig(A);


%% Linealization 'linmod'
[A,B,C,D] = linmod('InvertedPendulum');
sys = ss(A,B,C,D);
[a,b,c,d] = ssdata(sys);

%% Linealization curve
U = -5:0.1:5;
X = [];
Theta = [];
X_l = [];
Theta_l = [];

for i = 1:length(U)
    u = U(i);
    sim('InvertedPendulumWithLinealization');
    X(i) = x.Data(end);
    Theta(i) = theta.Data(end);
    X_l(i) = x_theta_l.Data(end,1);
    Theta_l(i) = x_theta_l.Data(end,2);
end

%% Plot
figure;
clf;
plot(U, Theta);
hold on
plot(U, Theta_l);
%line([0.2 0.2], [0, Theta(find(abs(u - 0.2) < 0.001))]);
%line([-0.2 -0.2], [0, Theta(find(abs(u + 0.2) < 0.001))]);

%% Lineal (theta = y1 = pi+phi, phi aprox to 0)
% System of equations
% NOTE: given that phi is aprox 0, sin(pi+phi) and cos(pi+phi) are aprox
% -phi and -1, and dtheta^2=dphi^2 aprox 0.
% x1=x, x2=dx, y1=phi, y2=dphi, u=F

denominator = I*(M+m)+M*m*L^2;
f1 = x2;
f2 = ((I+m*L^2)*u-(I+m*L^2)*b*x2+m^2*L^2*g*y1)/denominator;
f3 = y2;
f4 = (m*L*u-m*L*b*x2+(M+m)*m*g*L*y1)/denominator;