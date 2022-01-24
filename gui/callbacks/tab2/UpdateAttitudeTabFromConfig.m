function UpdateAttitudeTabFromConfig(config,h)
    global current_conditions current_scenario
    config_name=config.name;
    if strcmp(config_name,'Default')
        h.btn_updateattitudeconfig.Enable='off';
        h.btn_deleteattitudeconfig.Enable='off';
    else
        h.btn_updateattitudeconfig.Enable='on';
        h.btn_deleteattitudeconfig.Enable='on';
    end
    % Deep copy config.conditions to current_conditions
    current_conditions=containers.Map;
    k=config.conditions.keys;
    v=config.conditions.values;
    for i=1:length(k)
        current_conditions(k{i})=v{i};
    end
    conditions=current_conditions.values;
    
    % Deep copy config.scenario to current_scenario
    current_scenario=containers.Map;
    k=config.scenario.keys;
    v=config.scenario.values;
    for i=1:length(k)
        current_scenario(k{i})=v{i};
    end
    
    UpdateElementaryConditions(h);
    UpdateAttitudeSequenceConditions(h);
    if ~isempty(conditions)
        condition=conditions{1};
        name=condition.Name;
        type=condition.Type;
        param=condition.Parameters;
    else
        name='';
        type='Time';
        param=struct([]);
    end
    UpdateConditionDefinitionParameters(h,h.tbl_attitudeelementaryconditions,name,type,param);
    UpdateScenarioTable(h);
    UpdateScenarioElementDefinitionParameters(h,h.tbl_attitudesequence,1);

end

