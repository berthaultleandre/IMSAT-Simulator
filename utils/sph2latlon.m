function [lat, lon] = sph2latlon(phi, theta)
    lat=pi/2-theta;
    lon=phi;
end

