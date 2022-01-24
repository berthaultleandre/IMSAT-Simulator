function SetGeneralTabUpdateState(updated,h)
    if ~updated
        if strcmp(h.btn_updategeneralconfig.Enable,'off')
            h.btn_creategeneralconfig.BackgroundColor='red';
        else
            h.btn_updategeneralconfig.BackgroundColor='red';
        end
    else
        if strcmp(h.btn_updategeneralconfig.Enable,'off')
            h.btn_creategeneralconfig.BackgroundColor=[0.94 0.94 0.94];
        else
            h.btn_updategeneralconfig.BackgroundColor=[0.94 0.94 0.94];
        end
    end
end

