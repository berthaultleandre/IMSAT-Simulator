function CreateOrUpdateGeneralConfig(name,h)
    global all_general_configs
    if ~isempty(name) && ~strcmp(name,'Default')
        SetGeneralTabUpdateState(true,h);
        new_general_config=GetGeneralConfigFromGUI(name,h);
        all_general_configs(name)=new_general_config;
        h.spn_generalconfig.String=all_general_configs.keys;
        h.spn_generalconfig.Value=find(strcmp(h.spn_generalconfig.String,name));
        configs=all_general_configs;
        save('configs/general_configs.mat','configs');
        UpdateGeneralTabFromConfig(new_general_config,h);
    end
end

