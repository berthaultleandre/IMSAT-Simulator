function [E, f] = get_Ef(M, e)
eps = 1e-6;
E = 1;
Eold = 0;
while E - Eold > eps
    Eold = E;
    fE = E - e*sin(E) - M;
    fpE = 1 - e*cos(E);
    E = E - fE/fpE;
end
f = 2*atan(sqrt((1+e)/(1-e))*tan(E/2));
end

