function UpdateConditionDefinitionParameters(ha,src,name,type,param)
    ha.ed_attitudeconditiondefinitionname.String=name;
    ha.spn_attitudeconditiondefinitiontype.Value=...
        find(strcmp(ha.spn_attitudeconditiondefinitiontype.String,type));
    h=guidata(src);
    if isfield(h,'condition_gui')
        keys=h.condition_gui.keys;
        for i=1:length(keys)
            delete(h.condition_gui(keys{i}));
        end
    end
    h=UpdateConditionGUI(type,param,h,ha);
    guidata(src,h);
end