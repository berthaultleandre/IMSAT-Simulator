function UpdateSpacecraftData(name,h)
    global all_spacecrafts
    spacecraft=all_spacecrafts(name);
    set(h.ed_spacecraftdimx,'String',num2str(spacecraft.dim(1)));
    set(h.ed_spacecraftdimy,'String',num2str(spacecraft.dim(2)));
    set(h.ed_spacecraftdimz,'String',num2str(spacecraft.dim(3)));
    set(h.ed_spacecraftweight,'String',num2str(spacecraft.m));
end

