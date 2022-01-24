function UpdateCond0Data(name,h)
    global all_cond0 re_m

    cond0=all_cond0(name);
    set(h.ed_cond0eulob0degphi,'String',num2str(cond0.eul_o_b_0_deg(1)));
    set(h.ed_cond0eulob0degtheta,'String',num2str(cond0.eul_o_b_0_deg(2)));
    set(h.ed_cond0eulob0degpsi,'String',num2str(cond0.eul_o_b_0_deg(3)));
    
    set(h.ed_cond0wob0x,'String',num2str(cond0.w_o_b_0(1)));
    set(h.ed_cond0wob0y,'String',num2str(cond0.w_o_b_0(2)));
    set(h.ed_cond0wob0z,'String',num2str(cond0.w_o_b_0(3)));
    
    set(h.ed_cond0reci0x,'String',num2str(floor(cond0.r_eci_0(1)/1000)));
    set(h.ed_cond0reci0y,'String',num2str(floor(cond0.r_eci_0(2)/1000)));
    set(h.ed_cond0reci0z,'String',num2str(floor(cond0.r_eci_0(3)/1000)));
    
    set(h.ed_cond0veci0x,'String',num2str(floor(cond0.v_eci_0(1))));
    set(h.ed_cond0veci0y,'String',num2str(floor(cond0.v_eci_0(2))));
    set(h.ed_cond0veci0z,'String',num2str(floor(cond0.v_eci_0(3))));
    
    set(h.ed_cond0altitude,'String',num2str(floor((norm(cond0.r_eci_0)-re_m)/1000)));
end

