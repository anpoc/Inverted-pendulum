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
% x1=x, x2=dx, x3=theta, x4=dtheta, u=F
syms x1 x2 x3 x4 u; 
denominator = (M+m)*(I+m*L^2)-m^2*L^2*cos(x3)^2;
f1 = x2;
f2 = ((I+m*L^2)*(u-b*x2+m*L*x4^2*sin(x3))+m^2*L^2*g*sin(x3)*cos(x3))/denominator;
f3 = x4;
f4 = (-m*L*u*cos(x3)+m*L*b*x2*cos(x3)-m^2*L^2*x4^2*sin(x3)*cos(x3)-(M+m)*m*g*L*sin(x3))/denominator;

% Output functions
h1 = x1;
h2 = x3;

% Equilibrium points
equilibrium = solve([f1, f2, f3, f4], [x1, x2, x3, x4, u]);

%% Linealization for theta0=pi and other vars 0 to 0
% Equilibrium values
n = 5;
x10 = equilibrium.x1(n);
x20 = equilibrium.x2(n);
x30 = equilibrium.x3(n);
x40 = equilibrium.x4(n);
u0 = equilibrium.u(n);

% Matrices
A_a = jacobian([f1, f2, f3, f4], [x1, x2, x3, x4]);
A_a = subs(A_a, [x1, x2, x3, x4, u], [x10, x20, x30, x40, u0]);
B_a = jacobian([f1, f2, f3, f4], u);
B_a = subs(B_a, [x1, x2, x3, x4, u], [x10, x20, x30, x40, u0]);
C_a = jacobian([h1, h2], [x1, x2, x3, x4]);
C_a = subs(C_a, [x1, x2, x3, x4, u], [x10, x20, x30, x40, u0]);
D_a = [0 ; 0];

%% Equilibrium evaluation
eigen = eig(A_a);

%% Linealization 'linmod'
[A,B,C,D] = linmod('InvertedPendulum');
sys = ss(A,B,C,D);
[A,B,C,D] = ssdata(sys);

%% Linealization curve
U = -5:0.1:5;
X1 = zeros(length(U));
X3 = zeros(length(U));
X1_l = zeros(length(U));
X3_l = zeros(length(U));

for i = 1:length(U)
    u = U(i);
    sim('InvertedPendulumWithLinealization');
    X1(i) = x1.Data(end);
    X3(i) = x3.Data(end);
    X1_l(i) = x1_x3_l.Data(end,1);
    X3_l(i) = x1_x3_l.Data(end,2);
end

%% Plot
figure;
clf;
plot(U, X3);
hold on
plot(U, X3_l);

figure;
clf;
plot(U, X1);
hold on
plot(U, X1_l);
%line([0.2 0.2], [0, Theta(find(abs(u - 0.2) < 0.001))]);
%line([-0.2 -0.2], [0, Theta(find(abs(u + 0.2) < 0.001))]);