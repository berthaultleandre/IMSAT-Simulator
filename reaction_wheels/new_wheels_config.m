function new_wheels_config(name,distr_matrix)
    global all_wheels_configs
    config = struct('name', name, 'distr_matrix', distr_matrix);
    all_wheels_configs(name)=config;
end

