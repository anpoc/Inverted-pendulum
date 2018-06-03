% genetic

clear
close all
clc
%%
[A,B,C,D] = linmod('InvertedPendulum');
EPS = 1e-10;

%% Control
% initial population
N = 100; % Population size
Next = 50;
x = rand(N, 6).*randi([-20 20], N, 6);
fit = [];
mut = 0.05
i = 1;
%% Selection
while i <= N
    try
        xnc = x(i, :);
        sim('control')
        if max(simout(:)) < EPS
            x(i, :) = [];
            N = N - 1;
            continue
        end
        fitness = abs(simout(end-100:end, :) - 1);
        fit(i) = max(fitness(:));
        i = i + 1;
    catch
        x(i, :) = [];
        N = N - 1;
    end
end

fit = 1./fit;

%% Crossover
cross = fit/sum(fit) < rand(1, N);
PP = 0.5;
O = perms([-1:1 -1:1]);

fit2 = [];
sons = [];
while sum(cross) > 0
    if sum(cross == 1)
        pair = find(1);
        pair = [pair pair];
    else
        pair = randi(N, 1, 2);
    end
    if all(cross(pair))
        son = O(randi(720), :).*x(pair(1), :) + ...
            O(randi(720), :).*x(pair(1), :);
        if mut > rand
            son(randi(6)) = rand;
        end
        sons = [sons; son];
        try
            xnc = son;
            sim('control')
            if max(simout(:)) < EPS
                cross(pair) = 0;
                continue
            end
            fitness = abs(simout(end-100:end, :) - 1);
            fit2(i) = max(fitness(:));
        catch
            cross(pair) = 0;
            continue
        end
        cross(pair) = 0;
    end
end

fit2 = 1./ fit2;
for i=1:N
    if fit2(i) == Inf
        fit2(i) = [];
        sons(i, :) = [];
    end
end
%% Population update