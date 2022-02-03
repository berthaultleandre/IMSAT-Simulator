function data = GetData()
    data=struct();
    data.constants = GetConstants();
    data.spacecrafts = GetSpacecrafts();
    data.initial_conditions_sets = GetInitialConditionsSets(data.constants);
    data.configs = GetConfigs();
    data.wheels_configurations = GetWheelsConfigurations();
    data.bases = GetBases();
end

