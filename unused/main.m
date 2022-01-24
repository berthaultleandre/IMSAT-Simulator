line2 = '2 25544  51.6454 114.3468 0000873 353.4400   1.0119 15.49140402239344';

[a, incl, Omega, e, w, M, n] = TLE_to_orbital_elements(line2);
[E, f] = get_Ef(M, e);
[r, v] = orbital_elements_to_ECI(a ,e, incl, Omega, w, f);
draw_earth_non_spherical();
%tspan = [0 86164];
y0 = [r,v];
tol = 1e-10;
J2 = false;
mu = 3.986004418e5;

w0=sqrt(mu/norm(r)^3)
tspan = [0 2*pi/w0];
%ECI frame
%[t, r_eci] = plot_orbit(tspan, y0, tol, J2);
%J2 = true;
%[t, r_eci] = plot_orbit(tspan, y0, tol, J2);

[t, r_eci,v_eci] = plot_J2drag(tspan,y0, tol);

figure(2); %ECEF frame
omega_e = 2*pi/86164;
theta = omega_e.*t;
lat = zeros(size(t,1));
lambda = zeros(size(t,1));

for i =1:size(t,1)
    [lat(i), lambda(i)] = ECI_to_ECEF(r_eci(:,i), theta(i));
end

plot(lambda, lat);

title('Ground track of the ISS');
xlabel('Longitude (rad)');
ylabel('Latitude (rad)');
