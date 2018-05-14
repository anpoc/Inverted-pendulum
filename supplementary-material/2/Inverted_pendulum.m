%% Inicialization
clear
clc

%% Non-linear system
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
h1 = x1; % distance
h2 = x3; % angle

% Equilibrium points
equilibrium = solve([f1, f2, f3, f4], [x1, x2, x3, x4, u]);

%% Linealization
% Equilibrium values
n = 5; % point->(0,0,0,0,0)
x10 = double(equilibrium.x1(n));
x20 = double(equilibrium.x2(n));
x30 = double(equilibrium.x3(n));
x40 = double(equilibrium.x4(n));
u0 = double(equilibrium.u(n));

% Analytical matrices
A_a = jacobian([f1, f2, f3, f4], [x1, x2, x3, x4]);
A_a = double(subs(A_a, [x1, x2, x3, x4, u], [x10, x20, x30, x40, u0]));
B_a = jacobian([f1, f2, f3, f4], u);
B_a = double(subs(B_a, [x1, x2, x3, x4, u], [x10, x20, x30, x40, u0]));
C_a = jacobian([h1, h2], [x1, x2, x3, x4]);
C_a = double(subs(C_a, [x1, x2, x3, x4, u], [x10, x20, x30, x40, u0]));
D_a = [0 ; 0];

%% Equilibrium stability
eigen = eig(A_a);

%% Linealization 'linmod'
[A,B,C,D] = linmod('InvertedPendulum');
sys = ss(A,B,C,D);

T = [1 0 0 0; 0 0 1 0; 0 1 0 0; 0 0 0 1];
A = T*A*T';
B = T*B;
C = C*T;

%% Different input simulation
% Modify input signal in Simulink and signal variable name
% Run
sim('LinearInvertedPendulum');

% Plot
figure;
clf;
plot(u.Time, u.Data); 
signal = 'sierra';
title(strcat('Señal ', signal))
xlabel('Tiempo')
ylabel('Entrada')

figure;
clf;
plot(x1.Time, x1.Data);
title(strcat('Respuesta temporal de x1 a la señal ', signal))
xlabel('Tiempo')
ylabel('x1 (posición)')

figure;
clf;
plot(x3.Time, x3.Data);
title(strcat('Respuesta temporal de x3 a la señal ', signal))
xlabel('Tiempo')
ylabel('x3 (ángulo)')

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

%% Plot
figure;
clf;
plot(U, X1_nl);
hold on
plot(U, X1_l);

title('2-D Line Plot')
xlabel('x')
ylabel('cos(5x)')

figure;
clf;
plot(U, X3_nl);
hold on
plot(U, X3_l);
grey = [119/250 136/250 153/250];
line([2.5 2.5], [-0.1, 0.1], 'Color',grey,'LineStyle','--');
line([-2.5 -2.5], [-0.1, 0.1],'Color',grey,'LineStyle','--');

title('Curva de linealidad')
xlabel('u')
ylabel('theta (rad)')

%% Linealization curve with steps
Step = -5:1:5;
T = 0:5000:5000*(length(Step)-1);
sim('Copy_of_InvertedPendulumWithLinealization')

X1_steps = zeros(length(Step),2);
X3_steps = zeros(length(Step),2);

n = 1;
for i = 1:length(signal.data)
    if(signal.data(i)~=Step(n))
        X1_steps(n,1) = X1.data((i-1));
        X1_steps(n,2) = X13_l.data((i-1),1);
        X3_steps(n,1) = X3.data((i-1));
        X3_steps(n,1) = X13_l.data((i-1),2);
        n = n+1;
    end
end 

figure;
clf;
plot(Step, X3_steps(:,1))
hold on
plot(Step, X3_steps(:,2))

title('Curva de linealidad con escalera')
xlabel('u')
ylabel('theta (rad)')


%% Plot 
% Changing input signal
val = 0.5;
sim('Copy_of_InvertedPendulumWithLinealization')
figure;
clf;
plot(X3.Time, X3.Data);
hold on
plot(X3.Time, X13_l.Data(:,2));
hold on
plot(X3.Time, X3.Data - X13_l.Data(:,2));
title('Respuesta temporal de theta, u=0.5')
xlabel('tiempo (s)')
ylabel('theta (rad)')

val = -2;
sim('Copy_of_InvertedPendulumWithLinealization')
figure;
clf;
plot(X3.Time, X3.Data);
hold on
plot(X3.Time, X13_l.Data(:,2));
hold on
plot(X3.Time, X3.Data - X13_l.Data(:,2));
title('Respuesta temporal de theta, u=-2')
xlabel('tiempo (s)')
ylabel('theta (rad)')

val = 6;
sim('Copy_of_InvertedPendulumWithLinealization')
figure;
clf;
plot(X3.Time, X3.Data);
hold on
plot(X3.Time, X13_l.Data(:,2));
%hold on
%plot(X3.Time, X3.Data - X13_l.Data(:,2));
title('Respuesta temporal de theta, u=6')
xlabel('tiempo (s)')
ylabel('theta (rad)')

val = -100;
sim('Copy_of_InvertedPendulumWithLinealization')
figure;
clf;
plot(X3.Time, X3.Data);
hold on
plot(X3.Time, X13_l.Data(:,2));
%hold on
%plot(X3.Time, X3.Data - X13_l.Data(:,2));
title('Respuesta temporal de theta, u=-100')
xlabel('tiempo (s)')
ylabel('theta (rad)')

val = 0.1;
val1 = 0.1;
sim('Copy_of_InvertedPendulumWithLinealization')
figure;
clf;
plot(X3.Time, X3.Data);
hold on
plot(X3.Time, X13_l.Data(:,2));
%hold on
%plot(X3.Time, X3.Data - X13_l.Data(:,2));
title('Respuesta temporal de theta, u=0.1 theta0=0.1')
xlabel('tiempo (s)')
ylabel('theta (rad)')

%% Continuous transfer function
G = tf(sys); 

% Spliting
G1 = tf(G.numerator{1}, G.denominator{1});
G2 = tf(G.numerator{2}, G.denominator{2});
[numerator, denominator] = tfdata(G2);

% Poles and zeros continuous
[P,Z] = pzmap(G);
pzmap(G)
[P1,Z1] = pzmap(G1);
pzmap(G1)
[P2,Z2] = pzmap(G2);
pzmap(G2)

% Answer to a Step
figure;
step(G)
impulse(G)

% Final value theorem for continuous tf
%%% Opt 1
dcgain(sys) 
%%% Opt 2
syms s;
for i=1:2
    tfnames = [G1 G2];
    [num, den] = tfdata(tfnames(1));
    poly = poly2sym(cell2mat(num),s)/poly2sym(cell2mat(den),s);
    limit(poly,0)
end

%% Reduce to a second order tf
Gr = tf(reduce(G,2)); 
Gr1 = tf(reduce(G1,2));
Gr2 = tf(reduce(G2,2)); 

% Poles and zeros continuous
[Pr,Zr] = pzmap(Gr);
pzmap(Gr)
[Pr1,Zr1] = pzmap(Gr1);
pzmap(Gr1)
[Pr2,Zr2] = pzmap(Gr2);
pzmap(Gr2)

% Step reaction
step(Gr)
step(Gr1)
step(Gr2)

%% Discrete transfer function
Gd_matrix = cell(1,3);
Gd1_matrix = cell(1,3);
Gd2_matrix = cell(1,3);
T = [0.21 0.73 1.26];
%pz_matrix = cell(3,6);

for i = 1:3
    Gd = c2d(G,T(i)); % discrete
    Gd_matrix{i} = Gd;
    
    % Spliting
    Gd1 = c2d(G1,T(i));
    Gd2 = c2d(G2,T(i));
    Gd1_matrix{i} = Gd1;
    Gd2_matrix{i} = Gd2;
    
    % Poles and zeros continuous
    [Pd,Zd] = pzmap(Gd);
    figure;
    pzmap(Gd)
    [Pd1,Zd1] = pzmap(Gd1);
    figure;
    pzmap(Gd1)
    [Pd2,Zd2] = pzmap(Gd2);
    figure;
    pzmap(Gd2)
    %pz_matrix{i,:} = {Pd, Zd, Pd1, Zd1, Pd2, Zd2}; 
    
    % Answer to a Step
    figure;
    step(Gd)
    figure;
    impulse(Gd)
end

%% Roots place
% P controler 
rlocus(G2)

% PID controler
Gcr = tf([1 -(P2(1)+P2(2)) (P2(1)*P2(2))], [1 0]); 
G2cr = Gcr*G2; % G2cr = tf(G2.numerator{1}, [1 -P2(3) 0]); 
rlocus(G2cr)
