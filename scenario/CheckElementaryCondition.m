function b = CheckElementaryCondition(condition,state)
    func=GetConditionFunction(condition.Type,condition.Parameters);
    if strcmp(condition.Type,'Time')
        b=func(state.t);
    elseif strcmp(condition.Type,'Latitude')
        b=func(state.latitude);
    elseif strcmp(condition.Type,'Longitude')
        b=func(state.longitude);
    end
end

