function Y = pidS(K, sys)
    s = tf('s');
    cPID = K(1) + K(2)/s + K(3)*s;
    aPID = K(4) + K(5)/s + K(6)*s;

    [num, den] = tfdata(sys);
    Tc = tf(num{1}, den{1});
    Ta = tf(num{1}, den{1});

    T_p = feedback((Tc*cPID + Ta*aPID)*sys, [1 1]);
    
    y = step(T_p);
    
    Y = max(abs(y(end, :)-1));
end