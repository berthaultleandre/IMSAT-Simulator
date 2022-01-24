function [phi, theta] = latlon2sph(lat, lon)
    phi=lon;
    theta=pi/2-lat;
end

