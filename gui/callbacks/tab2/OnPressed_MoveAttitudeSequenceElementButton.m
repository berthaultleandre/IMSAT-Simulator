function OnPressed_MoveAttitudeSequenceElementButton(src,event,h,dir)
    global current_scenario
    priority=h.spn_attitudesequencepriority.Value;
    key=num2str(priority);
    priority2=priority+dir;
    if ~(((priority == 1 || priority > length(current_scenario)) && dir == -1) || ...
            (priority >= length(current_scenario) && dir == +1))
        SetAttitudeTabUpdateState(false,h);
        key2=num2str(priority+dir);
        temp=current_scenario(key);
        current_scenario(key)=current_scenario(key2);
        current_scenario(key2)=temp;
        h.spn_attitudesequencepriority.Value=priority2;        
        UpdateScenarioTable(h);
    end
end

