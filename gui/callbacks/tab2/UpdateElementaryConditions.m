function UpdateElementaryConditions(h)
    global current_conditions
    newdata={};
    v=values(current_conditions);
    for i=1:length(current_conditions)
        condition=v{i};
        name=condition.Name;
        type=condition.Type;
        param=condition.Parameters;
        param_str=GetConditionParamStr(type,param);
        if isempty(newdata)
            newdata={{name, type, param_str}};
        else
            newdata={cat(1,newdata{:});{name, type, param_str}};
        end
    end
    newdata=cat(1, newdata{:});
    h.tbl_attitudeelementaryconditions.Data=newdata;
    UpdateAttitudeSequenceConditions(h);
end