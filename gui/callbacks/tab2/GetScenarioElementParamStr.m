function param_str=GetScenarioElementParamStr(law_name,param)
    if strcmp(law_name,'Base Pointing')
        param_str=param.Base;
    elseif strcmp(law_name,'Nadir Pointing')
        param_str='None';
    end
end

