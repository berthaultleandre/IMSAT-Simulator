function OnPressed_CreateGeneralConfig(src,event,h)
    global all_general_configs
    name=h.ed_creategeneralconfig.String;
    if ~ismember(name,all_general_configs.keys)
        CreateOrUpdateGeneralConfig(name,h);
    end
end