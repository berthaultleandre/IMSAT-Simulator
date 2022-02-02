function [t,r_orb,v_orb] =GetSpacecraftOrbit(tspan, y0, data)
    [t,y] = ode45(@(t,y) SpacecraftOrbitFunc(t,y,data.constants),tspan,y0,odeset('RelTol',data.constants.tol));
    r_orb = y(:,1:3)';
    v_orb = y(:,4:6)';
end