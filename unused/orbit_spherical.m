function dydt = orbit_spherical(t,y)

global mu
r = norm(y(1:3));
dydt = zeros(6,1);
dydt(1) = y(4);
dydt(2) = y(5);
dydt(3) = y(6);
dydt(4) = -mu/r^3*y(1);
dydt(5) = -mu/r^3*y(2);
dydt(6) = -mu/r^3*y(3);
end
