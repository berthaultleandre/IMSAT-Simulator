function Rob_chap = point_base(base,data,state)
    [x_b,y_b,z_b]=base_position(base,state.t,0,data.constants.w_e_deg);
    base_xyz=[x_b;y_b;z_b];
    
    Rob_chap = point(base_xyz,state.pos,state.Rio);
end

