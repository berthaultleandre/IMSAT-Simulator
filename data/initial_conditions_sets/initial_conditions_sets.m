global all_cond0

all_cond0=containers.Map;

%Initial conditions sets
r_o=re_m+300e3;
r_eci_0=r_o*[1;0;0];
w_0 = sqrt(mu/(r_o^3));
v_eci_0=w_0*r_o*[0;1;0];
new_cond0('Equatorial',[0;0;0],[0;0;0],r_eci_0,v_eci_0);

line2 = '2 25544  51.6454 114.3468 0000873 353.4400   1.0119 15.49140402239344';
[a, incl, Omega, e, w, M, n]=TLE_to_orbital_elements(line2);
[E, f]=get_Ef(M, e);
[r_eci_0, v_eci_0]=orbital_elements_to_ECI(a ,e, incl, Omega, w, f);
new_cond0('ISS',[0;0;0],[0;0;0],r_eci_0,v_eci_0);