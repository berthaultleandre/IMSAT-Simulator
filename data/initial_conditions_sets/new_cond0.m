function cond0=new_cond0(name,eul_o_b_0_deg,w_o_b_0,r_eci_0,v_eci_0)
    cond0=struct('name',name,'eul_o_b_0_deg',eul_o_b_0_deg,... %initial angles orbit to body [°]
        'w_o_b_0',w_o_b_0,... %initial angular velocity orbit to body [rad/s]
        'r_eci_0',r_eci_0,'v_eci_0',v_eci_0);
end

