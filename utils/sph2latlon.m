function [lat, lon] = sph2latlon(phi, theta)
    lon=phi;
    lat=pi/2-theta;
end

