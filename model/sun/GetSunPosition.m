function [x,y,z]=GetSunPosition(t,a_sun,b_sun,e_sun,w_sun)
    incl=23.5*pi/180; %ecliptic inclination
    co=cos(incl);
    si=sin(incl);
    r_sun=a_sun^2/b_sun*(1-e_sun^2*cos(w_sun*t)^2)^(3/2);
    x=r_sun*co*cos(w_sun*t);
    y=r_sun*sin(w_sun*t);
    z=r_sun*si*cos(w_sun*t);
end