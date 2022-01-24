function Rob_chap=point_sun(center,Rio,t)
    global re_m
    [x,y,z]=GetSunPosition(t);
    sun_xyz=[x;y;z]/re_m;
    Rob_chap=point(sun_xyz,center,Rio);
end

