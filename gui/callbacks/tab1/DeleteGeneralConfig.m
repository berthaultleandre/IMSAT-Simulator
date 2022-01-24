function DeleteGeneralConfig(name,h)
    global all_general_configs
    if ~strcmp(name, 'Default')
        remove(all_general_configs,name);
        configs=all_general_configs;
        save('configs/general_configs.mat','configs');
        h.spn_generalconfig.String=all_general_configs.keys;
        UpdateGeneralTabFromConfig(configs('Default'),h);
    end
end

