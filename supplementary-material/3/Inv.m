%%
clear
close all
clc
%%dis
[A,B,C,D] = linmod('InvertedPendulum');

%% Filter
% https://www.mathworks.com/help/physmod/sps/powersys/ref/firstorderfilter.html
Ts = 1/(15);

%% Control
% initial solution
sys = tf(ss(A, B, C,D));
x = zeros(1, 6);
xN = x;
F = inf;
Ff = inf;
O = perms([-1:1 -1:1]);
fac = 1;
N =  100;
alpha = 3;
EPS = 1e-15;
Foo = []; Xoo = [];
Fnc = inf;
rC = 1; rA = 1;
W = 300;
maxIter = 100;
%% Grasp
for it=1:maxIter
    % construcion
    Op = O(randi([1 720], N, 1), :);
    Fa = [];
    xa = [];
    for i=1:N
        xnc = fac .* Op(i, :) + x;
        sim('control');
        
        eA = simout(end-W:end, 1);
        eC = simout(end-W:end, 2);
        
        Fnc = abs(max(abs(rC - eC)) + max(abs(rC - eC)));
        if(abs(Fnc - 2) < EPS)
            continue
        end
        if Fnc < F
            Fa = [Fnc; Fa];
            xa = [xnc; xa];
            F = Fnc;
        end
    end
    if Fa
        index = randi([1 min([length(Fa) alpha])]);
        F = Fa(index, :)
        x = xa(index, :)
        Foo = [Foo; F];
        Xoo = [Xoo; x];
    else
        fac = fac / 2
        F;
    end
    if fac < 0.0005
        % disp('refactor fac')
        r = randi([1000 10000])
        fac = r*fac*rand;
        
    end
end
%%

