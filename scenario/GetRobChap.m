function Rob_chap = GetRobChap(law,param,data,state)
    if strcmp(law,'Base Pointing')
        base_name=param.Base;
        base=data.bases(base_name);
        Rob_chap=point_base(base,data,state);
    elseif strcmp(law,'Nadir Pointing')
        Rob_chap=point_nadir(state);
    elseif strcmp(law,'Solar Pointing')
        Rob_chap=point_sun(data,state);
    end
end

