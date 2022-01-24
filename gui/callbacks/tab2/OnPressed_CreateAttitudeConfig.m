function OnPressed_CreateAttitudeConfig(src,event,h)
    global all_attitude_configs
    name=h.ed_createattitudeconfig.String;
    if ~ismember(name,all_attitude_configs.keys)
        CreateOrUpdateAttitudeConfig(name,h);
    end
end

