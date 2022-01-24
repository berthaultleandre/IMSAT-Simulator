function OnPressed_RemoveAttitudeSequenceElementButton(src,event,h)
    global current_scenario
    SetAttitudeTabUpdateState(false,h);
    priority=h.spn_attitudesequencepriority.Value;
    key=num2str(priority);
    remove(current_scenario,key);
    if length(current_scenario)-priority>=0
        for i=priority:length(scenario)
            current_scenario(int2str(i))=current_scenario(int2str(i+1));
            remove(current_scenario,int2str(i+1));
        end
    end
    UpdateScenarioTable(h);
    if priority>1
        h.spn_attitudesequencepriority.Value=priority-1;
    else
        h.spn_attitudesequencepriority.Value=1;
    end
end

