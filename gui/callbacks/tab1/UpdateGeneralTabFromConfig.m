function UpdateGeneralTabFromConfig(config,h)
    config_name=config.name;
    if strcmp(config_name,'Default')
        h.btn_updategeneralconfig.Enable='off';
        h.btn_deletegeneralconfig.Enable='off';
    else
        h.btn_updategeneralconfig.Enable='on';
        h.btn_deletegeneralconfig.Enable='on';
    end

    spacecraft_name=config.spacecraft_name;
    cond0_name=config.cond0_name;
    
    h.spn_generalconfig.Value=find(strcmp(h.spn_generalconfig.String,config.name));
    h.spn_spacecraft.Value=find(strcmp(h.spn_spacecraft.String,spacecraft_name));
    h.spn_cond0.Value=find(strcmp(h.spn_cond0.String,cond0_name));
   
    UpdateSpacecraftData(spacecraft_name,h);
    UpdateCond0Data(cond0_name,h)   
    
    attitude_wchap=config.attitude_wchap;
    h.ed_attitudewchapx.String=num2str(attitude_wchap(1));
    h.ed_attitudewchapy.String=num2str(attitude_wchap(2));
    h.ed_attitudewchapz.String=num2str(attitude_wchap(3));
    attitude_hchap=config.attitude_hchap;
    h.ed_attitudehchapx.String=num2str(attitude_hchap(1));
    h.ed_attitudehchapy.String=num2str(attitude_hchap(2));
    h.ed_attitudehchapz.String=num2str(attitude_hchap(3));
    
    anim_animation_speed=config.anim_animation_speed;
    h.ed_animspeed.String=num2str(anim_animation_speed);
    anim_spacecraft_size=config.anim_spacecraft_size;
    h.ed_spacecraftsize.String=num2str(anim_spacecraft_size);
    anim_arrow_len=config.anim_arrow_len;
    h.ed_arrowlen.String=num2str(anim_arrow_len);
    anim_line_len=config.anim_line_len;
    h.ed_linelen.String=num2str(anim_line_len);
    anim_axis_limit_ratio=config.anim_axis_limit_ratio;
    h.ed_axislimitratio.String=num2str(anim_axis_limit_ratio);
    r_ratio=config.r_ratio;
    h.ed_radiusratio.String=num2str(r_ratio);
    anim_save_video=config.anim_save_video;
    enable_video_config=onoff(anim_save_video);
    h.cbx_savevideo.Value=anim_save_video;
    anim_video_name=config.anim_video_name;
    h.txt_videoname.Enable=enable_video_config;
    h.ed_videoname.Enable=enable_video_config;
    h.ed_videoname.String=anim_video_name;
    anim_video_format=config.anim_video_format;
    h.txt_videoformat.Enable=enable_video_config;
    h.ed_videoformat.Enable=enable_video_config;
    h.ed_videoformat.String=anim_video_format;
    anim_video_frame_rate=config.anim_video_frame_rate;
    h.txt_videoframerate.Enable=enable_video_config;
    h.ed_videoframerate.Enable=enable_video_config;
    h.ed_videoframerate.String=num2str(anim_video_frame_rate);
    
    UpdateActuatorsParameters(h,h.spn_actuators,config.actuators('name'),config.actuators('parameters'));
end