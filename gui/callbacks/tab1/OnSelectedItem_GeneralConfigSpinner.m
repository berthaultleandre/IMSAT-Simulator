function OnSelectedItem_GeneralConfigSpinner(src,event,h)
    global all_general_configs
    config_name=h.spn_generalconfig.String{h.spn_generalconfig.Value};
    config=all_general_configs(config_name);
    UpdateGeneralTabFromConfig(config,h);
end