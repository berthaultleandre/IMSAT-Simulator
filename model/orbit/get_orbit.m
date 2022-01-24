function [t,r_eci,v_eci] =get_orbit(tspan, y0, tol)

[t,y] = ode45(@func_orbit,tspan,y0,odeset('RelTol',tol));

r_eci = [y(:,1),y(:,2),y(:,3)]';
v_eci = [y(:,4),y(:,5),y(:,6)]';
end