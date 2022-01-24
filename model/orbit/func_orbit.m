function dydt = func_orbit(t,y)

global mu J2 re_m rho Cd S

r = norm(y(1:3));
co=y(2)/sqrt(y(1)^2+y(2)^2);
si=y(1)/sqrt(y(1)^2+y(2)^2);
colambda=sqrt(y(1)^2+y(2)^2)/r;

v=y(4:6);
vair=2*pi/(24*3600)*r*colambda*[-si co 0];
fdrag=-1/2*Cd*S*rho*(norm(v-vair))*(v-vair);

dydt = zeros(6,1);
dydt(1) = y(4);
dydt(2) = y(5);
dydt(3) = y(6);
dydt(4) = -mu/r^3*y(1) -3/2*J2*(mu/r^2)*(re_m/r)^2*(1-5*(y(3)/r)^2)*y(1)/r+fdrag(1) ;
dydt(5) = -mu/r^3*y(2) -3/2*J2*(mu/r^2)*(re_m/r)^2*(1-5*(y(3)/r)^2)*y(2)/r+fdrag(2);
dydt(6) = -mu/r^3*y(3) -3/2*J2*(mu/r^2)*(re_m/r)^2*(3-5*(y(3)/r)^2)*y(3)/r+fdrag(3);
end
