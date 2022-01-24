function OnPressed_RemoveConditionDefinitionButton(src,event,h)
    global current_conditions
    name=h.ed_attitudeconditiondefinitionname.String;
    if isKey(current_conditions,name)
        SetAttitudeTabUpdateState(false,h);
        remove(current_conditions,name);    
        
        conditions=current_conditions.values;
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
        UpdateElementaryConditions(h);
    end
end