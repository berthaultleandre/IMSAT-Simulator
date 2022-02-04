function [x,y,z] = base_position(base,t,offset,w_e_deg)
    lat=base.lat;
    lon=base.lon+pi/180*w_e_deg*t;
    %[phi,theta]=latlon2sph(lat,lon);
    [x,y,z]=sph2cart(lon,lat,1+offset);
end

