function OnSelectedItem_ScenarioTable(src,event,h)
    indices=event.Indices;
    if length(indices)==2
        row=indices(1);
        UpdateScenarioElementDefinitionParameters(h,src,row);
        h2=guidata(src);
    end
end