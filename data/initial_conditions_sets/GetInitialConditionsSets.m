function initial_conditions_sets = GetInitialConditionsSets(c)

    initial_conditions_sets=containers.Map;

    %Initial conditions sets
    r_o=c.re_m+300e3;
    r_eci_0=r_o*[1;0;0];
    w_0 = sqrt(c.mu/(r_o^3));
    v_eci_0=w_0*r_o*[0;1;0];
    initial_conditions_sets('Equatorial')=new_cond0('Equatorial',[0;0;0],[0;0;0],r_eci_0,v_eci_0);

    line2 = '2 25544  51.6454 114.3468 0000873 353.4400   1.0119 15.49140402239344';
    [a, incl, Omega, e, w, M, ~]=TLE_to_orbital_elements(line2, c.mu);
    [~, f]=get_Ef(M, e);
    [r_eci_0, v_eci_0]=orbital_elements_to_ECI(a ,e, incl, Omega, w, f, c.mu);
    initial_conditions_sets('ISS')=new_cond0('ISS',[0;0;0],[0;0;0],r_eci_0,v_eci_0);
    
end