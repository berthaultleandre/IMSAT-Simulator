function Rob_chap=point_sun(data,state)
    c=data.constants;
    [x,y,z]=GetSunPosition(state.t,c.a_sun,c.b_sun,c.e_sun,c.w_sun);
    sun_xyz=[x;y;z]/c.re_m;
    Rob_chap=point(sun_xyz,state.pos,state.Rio);
end

