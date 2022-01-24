function [t,r_eci,v_eci] =plot_J2drag_v2(tspan, y0, tol)

global w0

[t,y] = ode45(@J2drag, tspan,y0,odeset('RelTol',tol));
N=size(y(:,1))
T=2*pi/w0
dt=T/N(1)

hold on;
for k=1:N
    plot3(y(k,1),y(k,2), y(k,3));
    drawnow
    pause(dt)
end

title('Orbit of the ISS around Earth J2 + drag')
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')

r_eci = [y(:,1),y(:,2),y(:,3)];
v_eci = [y(:,4),y(:,5),y(:,6)];

r_eci = r_eci';
v_eci=v_eci';
end