function UpdateActuatorsParameters(ha,src,name,param)
    ha.spn_actuators.Value=find(strcmp(ha.spn_actuators.String,name));
    h=guidata(src);
     if isfield(h,'actuatorsgui')
        keys=h.actuatorsgui.keys;
        for i=1:length(keys)
            delete(h.actuatorsgui(keys{i}));
        end
    end
    h=UpdateActuatorsGUI(name,param,h,ha);
    guidata(src,h);
end

