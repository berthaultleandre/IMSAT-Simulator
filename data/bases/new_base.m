function base=new_base(name, phi, theta)
    [lat,lon]=sph2latlon(phi,theta);
    base=struct('name',name,'lat',lat,'lon',lon);
end

