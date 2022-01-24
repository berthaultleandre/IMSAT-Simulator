function param=GetLawParam(law_name,h,default)
    global all_bases
    all_bases_name=all_bases.keys;
    if strcmp(law_name,'Base Pointing')
        if default
            param=struct('Base',all_bases_name(1));
        else
            tab=h.tbl_attitudesequence;
            ha=guidata(tab);
            if isfield(ha,'scenarioelementgui')
                scenarioelementgui=ha.scenarioelementgui;
                spn=scenarioelementgui('spn_scenarioelementbase');
                base_name=spn.String(spn.Value);
                param=struct('Base',base_name);
            else
                param=struct('Base',all_bases_name(1));
            end
        end
    elseif strcmp(law_name,'Nadir Pointing')
        param=struct([]);
    end
end

