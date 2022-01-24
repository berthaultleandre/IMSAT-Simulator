function earth=draw_earth_spherical()
    [X,Y,Z] = sphere;
    earth=surf(X,Y,Z);
    earth.EdgeColor='none';
    imData = imrotate(imread('earthmap1k.jpg'),180);
    earth=warp(X,Y,Z,imData);
end

