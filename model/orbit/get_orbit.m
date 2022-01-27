function [t,r_eci,v_eci] =get_orbit(tspan, y0, data)

[t,y] = ode45(@(t,y) func_orbit(t,y,data.constants),tspan,y0,odeset('RelTol',data.constants.tol));
r_eci = [y(:,1),y(:,2),y(:,3)]';
v_eci = [y(:,4),y(:,5),y(:,6)]';
end