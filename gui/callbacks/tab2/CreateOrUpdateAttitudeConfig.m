function CreateOrUpdateAttitudeConfig(name,h)
    global all_attitude_configs current_conditions current_scenario
    if ~isempty(name) && ~strcmp(name,'Default')
        SetAttitudeTabUpdateState(true,h);
        conditions=current_conditions;
        scenario=current_scenario;
        new_attitude_config=struct('name',name,...
        'conditions',conditions,...
        'scenario',scenario);
        all_attitude_configs(name)=new_attitude_config;
        h.spn_attitudeconfig.String=all_attitude_configs.keys;
        h.spn_attitudeconfig.Value=find(strcmp(h.spn_attitudeconfig.String,name));
        configs=all_attitude_configs;
        save('configs/attitude_configs.mat','configs');
        UpdateAttitudeTabFromConfig(new_attitude_config,h);
    end
end

