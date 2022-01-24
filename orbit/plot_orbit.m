function [t,r_eci,v_eci] = plot_orbit(tspan, y0, tol, J2)

if J2==false
    [t,y] = ode45(@orbit_spherical, tspan,y0,odeset('RelTol',tol));
elseif J2 == true
    [t,y] = ode45(@orbit_J2, tspan,y0,odeset('RelTol',tol));
end
hold on;
plot3(y(:,1),y(:,2), y(:,3));

title('Orbit of the ISS around Earth using ODE45')
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
saveas(gcf, 'orbit', 'png');    

r_eci = [y(:,1),y(:,2),y(:,3)];
v_eci = [y(:,4),y(:,5),y(:,6)];

r_eci = r_eci';
v_eci=v_eci';

end

