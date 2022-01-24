function h=UpdateScenarioElementGUI(law_name,h,ha,param)
    global all_bases
    if strcmp(law_name,'Nadir Pointing')
        return;
    elseif strcmp(law_name,'Base Pointing')
        txt_scenarioelementbase=new_text(ha.sp22,'Base',[0 0 100 20]);
        under(txt_scenarioelementbase,ha.txt_attitudesequencelaw,5);
        spn_scenarioelementbase=new_spinner(ha.sp22,all_bases.keys,[0 0 100 20]);
        rightof(spn_scenarioelementbase,txt_scenarioelementbase,5);
        base_index=find(strcmp(spn_scenarioelementbase.String,param.Base));
        if isempty(base_index)
            base_index=1;
        end
        spn_scenarioelementbase.Value=base_index;
        h.scenarioelementgui=containers.Map;
        h.scenarioelementgui('txt_scenarioelementbase')=txt_scenarioelementbase;
        h.scenarioelementgui('spn_scenarioelementbase')=spn_scenarioelementbase;
    end
end

