function DeleteAttitudeConfig(name,h)
    global all_attitude_configs
    if ~strcmp(name, 'Default')
        remove(all_attitude_configs,name);
        configs=all_attitude_configs;
        save('configs/attitude_configs.mat','configs');
        h.spn_attitudeconfig.String=all_attitude_configs.keys;
        UpdateAttitudeTabFromConfig(configs('Default'),h);
    end
end

