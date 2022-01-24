function [x,y,z] = sph2cart(r, phi, theta)
    x=r*cos(phi)*sin(theta);
    y=r*sin(phi)*sin(theta);
    z=r*cos(theta);
end

