function SetAttitudeTabUpdateState(updated,h)
    if ~updated
        if strcmp(h.btn_updateattitudeconfig.Enable,'off')
            h.btn_createattitudeconfig.BackgroundColor='red';
        else
            h.btn_createattitudeconfig.BackgroundColor=[0.94 0.94 0.94];
            h.btn_updateattitudeconfig.BackgroundColor='red';
        end
    else
        if strcmp(h.btn_updateattitudeconfig.Enable,'off')
            h.btn_createattitudeconfig.BackgroundColor=[0.94 0.94 0.94];
        else
            h.btn_updateattitudeconfig.BackgroundColor=[0.94 0.94 0.94];
        end
    end
end

