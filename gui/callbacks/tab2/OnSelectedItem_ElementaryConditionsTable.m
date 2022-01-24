function OnSelectedItem_ElementaryConditionsTable(src,event,h)
    global current_conditions
    indices=event.Indices;
    if length(indices)==2
        row=indices(1);
        col=indices(2);  
        v=current_conditions.values;
        condition=v{row};
        name=condition.Name;
        type=condition.Type;
        param=condition.Parameters;
        UpdateConditionDefinitionParameters(h,src,name,type,param);
    end
end