function Rob_chap = point_base(base,center,Rio,t,w_e_deg)
    [x_b,y_b,z_b]=base_position(base,t,0,w_e_deg);
    base_xyz=[x_b;y_b;z_b];
    
    Rob_chap = point(base_xyz,center,Rio);
end

