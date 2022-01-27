function Rob_chap=point_sun(center,Rio,t,re_m,a_sun,b_sun,e_sun,w_sun)
    [x,y,z]=GetSunPosition(t,a_sun,b_sun,e_sun,w_sun);
    sun_xyz=[x;y;z]/re_m;
    Rob_chap=point(sun_xyz,center,Rio);
end

