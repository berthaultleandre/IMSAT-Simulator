clear all
close all
clc
%cd 'C:\Users\djoff\OneDrive\Documents\IMT\A3\projet 3A\courbes'

line2 = '2 25544  51.6454 114.3468 0000873 353.4400   1.0119 15.49140402239344';
%  n° catalogue   inclinaison(°) noeud_ascendant(°) excentricité
%  arg_périgé(°) anomalie_moyenne(°) n_rev/jour


global mu J2 Re S Cd rho erad prad T w0

mu = 3.986004418e14; %si
J2 = 1.0827e-3;
Re = 6371e3; %m
S=0.01; %m2
Cd=2.2;
rho=2.6*10^(-12); %kg/m3
erad = 6378.1e3;  % equatorial radius (m)
prad = 6356.8e3;  % polar radius (m)

nb_per=5;

[a, incl, Omega, e, w, M, n] = TLE_to_orbital_elements(line2);
[E, f] = get_Ef(M, e);
[r, v] = orbital_elements_to_ECI(a ,e, incl, Omega, w, f);
draw_earth_non_spherical();
%tspan = [0 86164];
y0 = [r,v];
tol = 1e-10;


w0=sqrt(mu/norm(r)^3);
T=2*pi/w0;
tspan = [0 nb_per*T];
%ECI frame

[t, r_eci, v_eci] = plot_J2drag(tspan, y0, tol);
