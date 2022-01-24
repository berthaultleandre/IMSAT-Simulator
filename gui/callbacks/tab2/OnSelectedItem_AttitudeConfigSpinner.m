function OnSelectedItem_AttitudeConfigSpinner(src,event,h)
    global all_attitude_configs
    config_name=h.spn_attitudeconfig.String{h.spn_attitudeconfig.Value};
    config=all_attitude_configs(config_name);
    UpdateAttitudeTabFromConfig(config,h);
end

