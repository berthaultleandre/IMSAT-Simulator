function dydt = orbit_J2(t,y)

global mu J2 Re

r = norm(y(1:3));
dydt = zeros(6,1);
dydt(1) = y(4);
dydt(2) = y(5);
dydt(3) = y(6);
dydt(4) = -mu/r^3*y(1) -3/2*J2*(mu/r^2)*(Re/r)^2*(1-5*(y(3)/r)^2)*y(1)/r ;
dydt(5) = -mu/r^3*y(2) -3/2*J2*(mu/r^2)*(Re/r)^2*(1-5*(y(3)/r)^2)*y(2)/r ;
dydt(6) = -mu/r^3*y(3) -3/2*J2*(mu/r^2)*(Re/r)^2*(3-5*(y(3)/r)^2)*y(3)/r ;
end
