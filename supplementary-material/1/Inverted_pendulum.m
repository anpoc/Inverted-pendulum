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
% Equilibrium val-5:0.1:5ues
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

%% Linealization comporation 
% using the transformation
T =  [1 0 0 0; 0 0 1 0; 0 1 0 0; 0 0 0 1];
double(A_a) - T*A*T'
double(B_a) - T*B
double(C_a) - C*T'
double(D_a) - D_a
%% Linealization curve
U = -5:0.1:5;
X1_nl = repelem(0,length(U));
X3_nl = repelem(0,length(U));
X1_l = repelem(0,length(U));
X3_l = repelem(0,length(U));

for i = 1:length(U)
    u = U(i);
    sim('InvertedPendulumWithLinealization');
    X1_nl(i) = x1.Data(end);
    X3_nl(i) = x3.Data(end);
    X1_l(i) = x1_x3_l.Data(end,1);
    X3_l(i) = x1_x3_l.Data(end,2);
end

%% Linealization curve with steps
Step = -5:0.1:5;
T = 0:100:100*(length(Step)-1);
sim('InvertedPendulumWithLinealization_s')

X1_steps = zeros(length(Step),2);
X3_steps = zeros(length(Step),2);

n = 1;
for i = 1:length(signal.data)
    if(signal.data(i)~=Step(n))
        disp(i)
        disp(X1.data(n,:))
        X1_steps(n,:) = X1.data((i-1),:);
        X3_steps(n,:) = X3.data((i-1),:);
        n = n+1;
    end
end 

figure;
clf;
plot(Step, X1_steps(:,1))
hold on
plot(Step, X1_steps(:,2))


%% Plot
figure;
clf;
plot(U, X3_nl);
hold on
plot(U, X3_l);

figure;
clf;
plot(U, X3_nl);
hold on
plot(U, X3_l);
line([0.9 0.9], [-0.1, 0.1]);
line([-0.9 -0.9], [-0.1, 0.1]);

%% Plot 
% Changing input signal
u = 0.8;
sim('InvertedPendulumWithLinealization')
figure;
clf;
plot(x1.Time, x1.Data);
hold on
plot(x1.Time, x1_x3_l.Data(:,1));

figure;
clf;
plot(x3.Time, x3.Data);
hold on
plot(x3.Time, x1_x3_l.Data(:,2));

u = 3;
sim('InvertedPendulumWithLinealization')
figure;
clf;
plot(x1.Time, x1.Data);
hold on
plot(x1.Time, x1_x3_l.Data(:,1));

figure;
clf;
plot(x3.Time, x3.Data);
hold on
<<<<<<< HEAD
plot(U, X1_l);
%line([0.2 0.2], [0, Theta(find(abs(u - 0.2) < 0.001))]);
%line([-0.2 -0.2], [0, Theta(find(abs(u + 0.2) < 0.001))]);
=======
plot(x3.Time, x1_x3_l.Data(:,2));
>>>>>>> c22f97e382f2bbc36fff7c84ce6f07f8ca315f6e
