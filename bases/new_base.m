function new_base(name, phi, theta)
    global all_bases
    [lat,lon]=sph2latlon(phi,theta);
    base=struct('name',name,'lat',lat,'lon',lon);
    all_bases(name)=base; 
end

