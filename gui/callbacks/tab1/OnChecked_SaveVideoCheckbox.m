function OnChecked_SaveVideoCheckbox(src,event,h)
    SetGeneralTabUpdateState(false,h);
    enable=onoff(src.Value);
    set(h.txt_videoname,'Enable',enable); 
    set(h.ed_videoname,'Enable',enable); 
    set(h.txt_videoformat,'Enable',enable); 
    set(h.ed_videoformat,'Enable',enable);
    set(h.txt_videoframerate,'Enable',enable); 
    set(h.ed_videoframerate,'Enable',enable); 
end