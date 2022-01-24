function h=UpdateScenarioElementDefinitionParametersAux(ha,src,law_name,param)
    h=guidata(src);
    if isfield(h,'scenarioelementgui')
        keys=h.scenarioelementgui.keys;
        for i=1:length(keys)
            delete(h.scenarioelementgui(keys{i}));
        end
    end
    h=UpdateScenarioElementGUI(law_name,h,ha,param);
    guidata(src,h);
end