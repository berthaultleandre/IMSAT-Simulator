G = 6.67428e-11; %gravity constant [m^3kg^-1s^-2]
m_e = 5.9742e24; %earth mass [kg]
mu = G*m_e; %earth gravitation coefficient [m^3s^-2]
%plot_earth();
tspan = [0 86164];

tol = 1e-10;
data=GetData();
data.constants.tol=tol;
data.constants.S=10;

line2 = '2 25544  51.6454 114.3468 0000873 353.4400   1.0119 15.49140402239344';
[a, incl, Omega, e, w, M, ~]=TLE_to_orbital_elements(line2, mu);
[~, f]=get_Ef(M, e);
[r_eci_0, v_eci_0]=orbital_elements_to_ECI(a ,e, incl, Omega, w, f, mu);
    
%[t, r_eci] = plot_orbit(tspan, y0, data);

figure(2); %ECEF frame
