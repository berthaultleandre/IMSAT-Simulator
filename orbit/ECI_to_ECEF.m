function [lat,long] = ECI_to_ECEF(r_eci, theta)

T = [cos(theta), sin(theta),0;
    -sin(theta), cos(theta),0;
    0,0,1];

r_ecef = T*r_eci;

lat = pi/2 - acos(r_ecef(3)/norm(r_ecef));
long = acos(r_ecef(1)/(norm(r_ecef)*cos(lat)));


end

