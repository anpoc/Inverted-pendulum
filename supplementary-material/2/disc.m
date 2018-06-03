Ts = 0.21
sim('Discrete_TF')
subplot(2,1,1);
hold on
plot(tf)
plot(c2d)
plot(zoh)
hold off

subplot(2,1,2); 
hold on
plot(tf)
plot(c2d)
plot(zoh)
hold off