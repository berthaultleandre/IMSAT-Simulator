function [r_ijk, v_ijk] = orbital_elements_to_ECI(a ,e, i, big_omega, small_omega, f, mu)
r_pqw = a*(1-e^2)/(1+e*cos(f))*[cos(f), sin(f), 0];
v_pqw = sqrt(mu/(a*(1-e^2)))*[-sin(f), e+cos(f), 0];

Rz_minus_big_omega = [cos(-big_omega), sin(-big_omega), 0;...
                 -sin(-big_omega), cos(-big_omega), 0;...
                 0, 0, 1];
             
Rx_minus_i = [1,0,0;...
              0, cos(-i), sin(-i);...
              0, -sin(-i), cos(-i)];
          
Rz_minus_small_omega = [cos(-small_omega), sin(-small_omega),0;...
                        -sin(-small_omega), cos(-small_omega), 0;...
                        0,0,1];

total_rotation = Rz_minus_big_omega*Rx_minus_i*Rz_minus_small_omega;
r_ijk = total_rotation*r_pqw';
v_ijk = total_rotation*v_pqw';

end